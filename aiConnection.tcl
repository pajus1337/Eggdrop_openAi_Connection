package require http
package require tls

set author "Pajus"

http::register https 443 [list ::tls::socket -autoservername true]

bind pub - "!q" q_command

proc q_command {nick uhost handle target args} {
    set message [join $args " "]
    set encodedMessage [::http::formatQuery "message" $message]

    # Construct the URL with the encoded message parameter
    set url "https://webhook_adress.com$encodedMessage"

    # Sending GET request to the external server
    set token [http::geturl $url]
    http::wait $token

    set response [http::data $token]
    set status [http::status $token]

    http::cleanup $token

    if {$status == "ok"} {
        displayMessageChunks $response $target
    } else {
        putnow "PRIVMSG $target :Error with my brain connection: $status"
    }
}

proc displayMessageChunks {response target} {
    set maxLength 400  ;# Adjust the maximum length as needed
    set responseLength [string length $response]

    if {$responseLength <= $maxLength} {
        displayMessage $response $target
    } else {
        set chunks [expr {ceil(double($responseLength) / $maxLength)}]

        for {set i 0} {$i < $chunks} {incr i} {
            set startIndex [expr {$i * $maxLength}]
            set endIndex [expr {min($responseLength, ($i + 1) * $maxLength)}]
            set chunk [string range $response $startIndex $endIndex]

            putnow "PRIVMSG $target :$chunk"
        }
    }
}

proc displayMessage {response target} {
    set cleanedResponse [regsub -all {\[Collection\]} $response {}]
    set cleanedResponse [regsub -all {\[Your Name\]} $cleanedResponse "Your Name"]
    putnow "PRIVMSG $target :$cleanedResponse"
}


proc script_loaded {} {
    global author
    putlog "Script loaded successfully."
    putlog "Author: $author"
}

register script_loaded
