from flask import Flask
from dotenv import load_dotenv



app = Flask(__name__)

app.app_context().push()

if __name__ == "__main__":
    load_dotenv()
    from app.routes import *
    app.run(debug = True)
