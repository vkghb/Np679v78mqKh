from flask import Flask
import os

app = Flask(__name__)

@app.route('/')
def home():
    return 

if __name__ == "__main__":
    # O Koyeb define a variável de ambiente PORT. Usamos a porta que ele nos der.
    port = int(os.environ.get("PORT", 8080))
    app.run(host='0.0.0.0', port=port)
