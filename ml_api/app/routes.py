from flask import current_app as app
import llm.gemini_pipe

@app.route("/")
def healthcheck():
    return {"status": "healthy"}, 200

