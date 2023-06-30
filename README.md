# Eggdrop_openAi_Connection
Eggdrop TCL Script allowing communication with open AI over http : 


this is a more elaborate version, which comes very close to the so-called final version.

- This time I changed the bot trigger from !q to nickbot - on IRC channels.
- Messages sent to the bot on a private message are immediately recognised as a trigger.
- I added additional options which allow to regionalize functions of the script.  ( such as trigger on prv, irc channel ) 

The prompt as well as the final communication with openAI is done with an additional script, which in this case is written in python (however, it is possible to do your own code here) -> My own python code is available, which is only limited to localhost connection (in order to exclude misuse by third parties).
In addition, however, it is possible to listen on 0.0.0.0 (here, however, I do not guarantee the security of the code, because the current work on the whole has not yet taken this into account). -> Maybe this will change in the future, 
Please feel free to cooperate.
