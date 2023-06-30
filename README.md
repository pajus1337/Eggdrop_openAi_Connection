# OpenAI Chat Bot

This project consists of two scripts that work together to create a chat bot ( Eggdrop ) using the OpenAI Chat API.

## Script 1: aiConnection.tcl ( Eggdrop )

This script is written in Tcl and serves as the interface between the IRC bot ( eggdrop ) and the OpenAI Chat API ( python @ linux ) It listens for messages in the chat and sends them to the API for generating a response. The generated response is then displayed back in the chat.

## Script 2: OpenAIChatAPI.py

This script is written in Python and sets up a Flask API that communicates with the OpenAI Chat API. It receives incoming chat messages, sends them to the OpenAI Chat API, and returns the generated response.

## Prerequisites

Before running the scripts, make sure you have the following:

- Tcl interpreter
- Python 3.x
- Required packages: `http`, `tls`, `json`, `flask`, `openai`

## Setup

1. Clone the repository or download the scripts.

2. Set up your OpenAI API credentials by replacing the placeholder `api_key` in the `OpenAIChatAPI.py` script with your own OpenAI API key.

3. Create a `prompts.json` file in the same directory as the `OpenAIChatAPI.py` script and define your chat prompts based on different scenarios. An example `prompts.json` file is provided in the repository.

## Usage

1. Run the `aIconnection.tcl` script using the Tcl interpreter.

2. Run the `OpenAIChatAPI.py` script using the Python interpreter.

3. The chat bot will now listen for incoming messages in the chat and generate responses using the OpenAI Chat API.

## Configuration

In both scripts, there are some configuration options available:

- `respond_to_private_messages`: Set to 1 to enable responding to private messages, or 0 to disable.
- `respond_to_channel_questions`: Set to 1 to enable responding to channel questions, or 0 to disable.
- `reply_delay`: Time delay in milliseconds before sending a reply.

Feel free to modify these configuration options to customize the behavior of the chat bot.

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).

Feel free to modify and adapt the code according to your needs.

## Acknowledgments

- This project utilizes the OpenAI Chat API. Make sure to check and comply with OpenAI's usage guidelines and policies.

Please note that this README is just a template and should be customized accordingly to provide accurate information about your specific implementation.
