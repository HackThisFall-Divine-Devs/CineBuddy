from llm.gemini_pipe import generate_preference
from llm.output_parsers import RoomRecommendation
import requests
import datetime
import json

import os


AUTH_TOKEN = os.environ.get("BACKEND_API_AUTH_TOKEN", "")

def assignScore(current_room, predictions):
    score = 0
    required_columns = ["ageGroup", "languagePreference", "genre", "timePreference", "genderPreference"]
    for col in required_columns:
        if current_room.get(col, "") == predictions.get(col, ""):
            score += 1
    return score

def sortByScores(all_rooms, predictions):
    scored_rooms = [i[0] for i in sorted([(room, assignScore(room, predictions)) for room in all_rooms], key = lambda x: x[1], reverse = True)]
    return scored_rooms    



def rank_rooms(user_id):
    all_users = requests.get(
        url = "https://cine-buddy-backend.vercel.app/api/users/all",
        headers = {"Authorization": f"Bearer {AUTH_TOKEN}"}
    ).json()

    current_user = [i for i in all_users if i["_id"] == user_id][0]

    user_watch_history = current_user["joinedRooms"]
    



    all_rooms = requests.get(
        url = "https://cine-buddy-backend.vercel.app/api/rooms/public",
        headers = {"Authorization": f"Bearer {AUTH_TOKEN}"}
    ).json().get("rooms")

    required_rooms = [i for i in all_rooms if i["_id"] in user_watch_history]

    candidate_rooms = [i for i in all_rooms if datetime.datetime.fromisoformat(i["date"].replace("Z", "")) >= datetime.datetime.now()]

    if len(required_rooms) == 0:
        return candidate_rooms
    

    llm_format_rooms = [{
        "ageGroup": _["ageGroup"],
        "languagePreference": _["languagePreference"],
        "genre": _["genre"],
        "timePreference": _["timePreference"],
        "genderPreference": _["genderPreference"]
    } for _ in required_rooms]


    llm_res = generate_preference(llm_format_rooms).to_dict()
    predictions = json.loads(llm_res["candidates"][0]["content"]["parts"][0]["text"])
    final_rooms = sortByScores(candidate_rooms, predictions)

    return final_rooms
