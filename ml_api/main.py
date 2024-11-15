from flask import Flask
from dotenv import load_dotenv



app = Flask(__name__)

app.app_context().push()

load_dotenv()
from app.routes import *


if __name__ == "__main__":
    app.run()
