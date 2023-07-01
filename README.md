<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
    <h1>Eggdrop OpenAI Chat Bot + API Server in Python</h1>
</head>

<body>
  <p>This project implements a eggdrop chat bot that uses the OpenAI API to generate responses based on user input. It consists of two scripts: <code>aiConnection.tcl</code> and <code>OpenAIChatAPI.py</code>.</p>
  <h2>Screenshot</h2>
  <img src="https://github.com/pajus1337/Eggdrop_openAi_Connection/assets/74528115/b48b1c9b-1306-43cb-81c0-ef54f04f8bee" alt="SparkBuddy Screenshot">

  <h2>Prerequisites</h2>
  <p>Before running the scripts, make sure you have the following:</p>

  <ul>
    <li>For <code>aiConnection.tcl</code>:</li>
    <ul>
      <li>Tcl interpreter</li>
      <li>Packages: <code>http</code>, <code>tls</code>, <code>json</code></li>
    </ul>
    <br>
    <li>For <code>OpenAIChatAPI.py</code>:</li>
    <ul>
      <li>Python 3.x</li>
      <li>Required packages: <code>flask</code>, <code>openai</code>, <code>json</code>, <code>logging</code></li>
    </ul>
  </ul>
<h2>Setup</h2>

<h3>aiConnection.tcl</h3>
<ol>
  <li>Make sure you have the Tcl interpreter installed on your system.</li>
  <li>Install the required packages by running the following commands:
    <pre><code>tclsh
tcl::pkg::install http tls json
    </code></pre>
  </li>
</ol>

<p>Script should be added to the Eggdrop configuration file (eggdrop.conf). Here's an example:</p>

<pre><code># Add the following line to your eggdrop.conf file
source scripts/aiConnection.tcl
</code></pre>

<p>After adding the script, it is recommended to restart your Eggdrop bot using the ".restart" command to ensure the changes take effect.</p>

<h3>OpenAIChatAPI.py</h3>
<ol>
  <li>Make sure you have Python installed on your system.</li>
  <li>Install the required Python packages by running the following command:
    <pre><code>pip install flask openai</code></pre>
  </li>
  <li>Set your OpenAI API key in the `OpenAIChatAPI.py` script. Replace `'API_Key'` with your actual OpenAI API key.</li>
  <li>Create a file named `prompts.json` and populate it with the following content:
    <pre><code>{
  "scenario1": [
    {
      "role": "system",
      "content": "Edit the content here"
    },
    {
      "role": "user",
      "content": "{message}"
    }
  ]
}
    </code></pre>
  </li>
  <li>Save the `OpenAIChatAPI.py` and `prompts.json` files in the same directory.</li>
  <li>To start the API server, run the following command in the terminal:
    <pre><code>python OpenAIChatAPI.py</code></pre>
    The server will start running on either `http://127.0.0.1:5000` (for LAN-only access) or `http://0.0.0.0:5000` (for access from the internet).</li>
  <li>Optionally, you can enable or disable logging for debugging purposes by modifying the <code>logging.basicConfig</code> line in the script.</li>
</ol>

<h2>Usage</h2>
<p>Once you have completed the setup, you can interact with the chatbot through the Eggdrop bot. The bot will listen for messages starting with its nickname and forward them to the OpenAI Chat API server. The server will generate a response and send it back to the bot, which will then display the response in the channel or send it as a private message.</p>

<p>To use the chatbot, simply address a message to the bot's nickname, followed by your question or statement. For example, if the bot's nickname is "SparkBuddy", you can send a message like:</p>

<pre><code>SparkBuddy: How are you?</code></pre>

<p>The bot will process the message, send it to the OpenAI Chat API server, and display or send the generated response.</p>

<p>The `prompts.json` file contains the conversation prompts used by the chatbot. You can customize the prompts by editing the content of the `scenario1` section in the file. The `{message}` placeholder in the user role content will be replaced with the user's message during runtime.</p>

<p>It is important to note that the OpenAI Chat API requires an active internet connection to function properly. Ensure that your server has internet access for the chatbot to work as expected.</p>

<p>Feel free to customize the chatbot behavior by modifying the `OpenAIChatAPI.py` script, 
  adjusting parameters such as temperature and max tokens, or modifying the conversation prompts.</p>
  
  <h2>Configuration</h2>
  <p>Both scripts provide configuration options that you can modify:</p>

  <h3>aiConnection.tcl</h3>
  <ul>
    <li><code>respond_to_private_messages</code>: Set to 1 to enable responding to private messages, or 0 to disable.</li>
    <li><code>respond_to_channel_questions</code>: Set to 1 to enable responding to channel questions, or 0 to disable.</li>
    <li><code>reply_delay</code>: Time delay in milliseconds before sending a reply.</li>
  </ul>

  <h3>OpenAIChatAPI.py</h3>
  <ul>
    <li><code>openai.api_key</code>: Set your OpenAI API key.</li>
    <li><code>isOnlyLan</code>: Set to <code>True</code> to allow connections only via the local network, or <code>False</code> to allow connections via the internet.</li>
    <li><code>temperature</code>: Adjust the temperature parameter for controlling the creativity of the responses.</li>
    <li><code>max_tokens</code>: Adjust the maximum number of tokens in the generated response.</li>
  </ul>

  <p>Feel free to modify these configuration options to customize the behavior of the chat bot according to your needs. :-)</p>

  <h2>License</h2>
  <p>This project is licensed under the <a href="https://opensource.org/licenses/MIT">MIT License</a>. Feel free to modify and adapt the code according to your requirements.</p>

  <h2>Acknowledgments</h2>
  <p>This project utilizes the OpenAI Chat API. Make sure to review and comply with OpenAI's usage guidelines and policies.</p>
</body>

</html>
