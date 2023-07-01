from flask import Flask, request, jsonify
import openai
import json
import logging

app = Flask(__name__)

# Set your OpenAI API Key here
openai.api_key = 'API_Key'

# Allow connection only via LAN = True or allow connection via the Internet = False
isOnlyLan = True

# Add logging for more debug info / disable if not needed.
logging.basicConfig(level=logging.DEBUG)

@app.route('/chat', methods=['GET', 'POST'])
def chat():
    if request.method == 'GET':
        # Handle GET request
        message = request.args.get('message', '')
    elif request.method == 'POST':
        # Handle POST request
        data = request.get_json()
        message = data['message']
    else:
        return jsonify({'error': 'Invalid request method'})

    # Add User's Message to Conversation
    conversation.append({'role': 'user', 'content': message})

    try:
        # Load prompts from a JSON file
        with open('prompts.json') as file:
            prompts = json.load(file)

        # Get the prompt based on the scenario
        prompt = prompts['scenario1'].copy()
        prompt[-1]['content'] = prompt[-1]['content'].format(message=message)

        # Append prompt to conversation
        conversation.extend(prompt)
    except (FileNotFoundError, json.JSONDecodeError) as e:
        # Handle possible errors
        logging.error(str(e))
        reply = "Sorry, but I don't have time right now. I'll get back to you later."
        return jsonify({'reply': reply})

    # Call the Chat API - Use at least version gpt.3.5
    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",
        messages=conversation,
        # Adjust the temperature
        temperature=0.8,
        # Adjust the max tokens
        max_tokens=80
    )
    reply = response.choices[0].message.content.strip()

    conversation.append({'role': 'assistant', 'content': reply})

    # Log the reply for debugging purposes (can be deactivated)
    logging.debug("Generated Reply: " + reply)

    return jsonify({'reply': reply})

if __name__ == '__main__':
    conversation = []

    if isOnlyLan:
        app.run(host='127.0.0.1')
    else:
        app.run(host='0.0.0.0')
