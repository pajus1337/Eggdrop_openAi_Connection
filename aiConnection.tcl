package require http
package require tls
package require json

http::register https 443 [list ::tls::socket -autoservername true]

set botNickName "SparkBuddy"

# Options
set ::respond_to_private_messages 1 ;# 1: Yes, 0: No
set ::respond_to_channel_questions 1 ;# 1: Yes, 0: No
set ::reply_delay 12000 ;# Time delay in milliseconds before sending a reply

bind pubm - "$botNickName: " q_command
bind pubm - "*$botNickName*" q_command
bind msgm - "*" q_command_private

proc q_command_private {nick uhost handle target args} {
    global respond_to_private_messages
    set message $target
    set encodedMessage [::http::formatQuery "message" $message]
    
    set url "http://127.0.0.1:5000/chat?$encodedMessage"
    set token [http::geturl $url -headers {Accept-Encoding gzip}]
    http::wait $token
    set response [http::data $token]
    set status [http::status $token]
    http::cleanup $token

    if {[string is true -strict $::respond_to_private_messages]} {
        if {$status == "ok"} {
            after $::reply_delay [list displayPrivateMessageChunks $response $nick]
        } else {
            putlog "Error with my brain connection: $status"
        }
    }
}

proc q_command {nick uhost handle target args} {
    global respond_to_channel_questions botNickName
    set message [join [lrange $args 0 end] " "] 
    set message [string replace $message 0 [string length $botNickName] ""] ;
    set message [string trim $message] ;

    set encodedMessage [::http::formatQuery "message" $message]

    set url "http://127.0.0.1:5000/chat?$encodedMessage"
    set token [http::geturl $url -headers {Accept-Encoding gzip}]
    http::wait $token
    set response [http::data $token]
    set status [http::status $token]
    http::cleanup $token

    if {[string is true -strict $::respond_to_channel_questions]} {
        if {$status == "ok"} {
            after $::reply_delay [list displayMessageChunks $response $target $nick]
        } else {
            putlog "Error with my brain connection: $status"
        }
    }
}

proc displayMessageChunks {response target nick} {
    set maxLength 400 ;
    set responseLength [string length $response]

    if {$responseLength <= $maxLength} {
        displayMessage $response $target $nick
    } else {
        set chunks [expr {ceil(double($responseLength) / $maxLength)}]

        for {set i 0} {$i < $chunks} {incr i} {
            set startIndex [expr {$i * $maxLength}]
            set endIndex [expr {min($responseLength, ($i + 1) * $maxLength)}]
            set chunk [string range $response $startIndex $endIndex]

            after $::reply_delay [list putnow "PRIVMSG $target :$chunk"]
            vwait ::reply_ready
        }
    }
}

proc displayMessage {response target nick} {
    set cleanedResponse [regsub -all {\[Collection\]} $response {}]
    set cleanedResponse [regsub -all {\[Your Name\]} $cleanedResponse "$nick"]
    set cleanedResponse [string trim $cleanedResponse]
    set reply [json::json2dict $cleanedResponse]
    set replyText [dict get $reply "reply"]
    set responseText [format "%s: %s" $nick $replyText]
    putlog "Response displayed on $target: $responseText"
    putnow "PRIVMSG $target :$responseText"
    set ::reply_ready 1
}

proc displayPrivateMessageChunks {response nick} {
    set maxLength 400 ;
    set responseLength [string length $response]

    if {$responseLength <= $maxLength} {
        displayPrivateMessage $response $nick
    } else {
        set chunks [expr {ceil(double($responseLength) / $maxLength)}]

        for {set i 0} {$i < $chunks} {incr i} {
            set startIndex [expr {$i * $maxLength}]
            set endIndex [expr {min($responseLength, ($i + 1) * $maxLength)}]
            set chunk [string range $response $startIndex $endIndex]

            after $::reply_delay [list putnow "PRIVMSG $nick :$chunk"]
            vwait ::reply_ready
        }
    }
}

proc displayPrivateMessage {response nick} {
    set cleanedResponse [regsub -all {\[Collection\]} $response {}]
    set cleanedResponse [regsub -all {\[Your Name\]} $cleanedResponse $nick]
    set cleanedResponse [string trim $cleanedResponse]
    set reply [json::json2dict $cleanedResponse]
    set replyText [dict get $reply "reply"]
    putlog "Response displayed on $nick: $replyText"
    putnow "PRIVMSG $nick :$replyText"
    set ::reply_ready 1
}

putlog "Pajus OpenAI Bot Script Loaded Correct"
