from flask import Flask, request, jsonify
import openai
import json

app = Flask(__name__)

# Set your OpenAI ! Important !
openai.api_key = 'Entry Your API Key here'

# True = onlyLan ( 127.0.0.1 ); False = Listen at ex.IP use ( 0.0.0.0 ) def port 5000 
isOnlyLan = True

@app.route('/chat', methods=['GET', 'POST'])
def chat():
  # Handle Get or Post method ( Should work for both )
    if request.method == 'GET':
     
        message = request.args.get('message', '')
    elif request.method == 'POST':
        data = request.get_json()
        message = data['message']
    else:
        return jsonify({'error': 'Invalid request method'})

    # I have set the prompt in json in seperate file ( so you will have to create one and set prompt there ) otherweis change code to read prompt here. 
    with open('prompts.json') as file:
        prompts = json.load(file)

    prompt = prompts['scenario1'].format(message=message)

       # max_tokens  Adjust the desired response length
       # n  Adjust the number of responses
       # stop Set custom stop sequence if needed
       # temperature Adjust the creativity of the responses
    response = openai.Completion.create(
        engine='text-davinci-003',
        prompt=prompt,
        max_tokens=100, 
        n=1, 
        stop=None,
        temperature=0.7, 
        top_p=1.0,
        frequency_penalty=0.0,
        presence_penalty=0.0
    )
  
    reply = response.choices[0].text.strip()
    return jsonify({'reply': reply})

if __name__ == '__main__':
    if isOnlyLan:
        app.run(host='127.0.0.1', port=5000)
    else:
        app.run(host='0.0.0.0', port=5000)
