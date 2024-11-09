from flask import Flask




app = Flask(__name__)

app.app_context().push()

if __name__ == "__main__":
    from app.routes import *
    app.run(debug = True)
