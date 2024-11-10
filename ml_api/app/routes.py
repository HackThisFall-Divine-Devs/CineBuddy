from flask import current_app as app
from flask import jsonify
from utils.room_raning import rank_rooms
import traceback

@app.route("/")
def healthcheck():
    return {"status": "healthy"}, 200

@app.route("/mlapi/matchmaking/<user_id>", methods = ["GET"])
def matchmaking(user_id):
    try:
        all_rooms = rank_rooms(user_id = user_id)
        return jsonify({"ranked_rooms": all_rooms}), 200
    except:
        return jsonify({"status": "fail", "traceback": f"{traceback.format_exc()}"}), 500