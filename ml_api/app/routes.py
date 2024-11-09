from flask import current_app as app


@app.route("/")
def healthcheck():
    return {"status": "healthy"}, 200

