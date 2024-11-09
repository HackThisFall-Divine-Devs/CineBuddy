import google.generativeai as genai
from output_parsers import RoomRecommendation
import os

GEMINI_API_KEY = os.environ.get("GEMINI_API_KEY", "")



PROMPT = """
You are a friendly Movie Room Recommender Bot for the "CineBuddy" App!\n\
CineBuddy is an app that allows people to create rooms to watch movie together online.\n\
Your are given a detail of the history of the rooms a user has been to.\n\
Your Job is to predict the room preferences of the user.\n\

Here is the User's History of visited rooms. Give your prediction.\n\
{}
"""

genai.configure(api_key = GEMINI_API_KEY)
MODEL = genai.GenerativeModel("gemini-1.5-flash")


def generate_preference(user_history):

    res = MODEL.generate_content(
        PROMPT.format(user_history),
        generation_config = genai.GenerationConfig(
            response_mime_type = "application/json",
            response_schema = RoomRecommendation
        )
    )

    

    return res


user_history = [
{
    "ageGroup": "18to25",
    "languagePreference": "English",
    "genre": "action",
    "timePreference": "morning",
    "genderPreference": "female"

},

{
    "ageGroup": "26to40",
    "languagePreference": "English",
    "genre": "emotional",
    "timePreference": "afternoon",
    "genderPreference": "female"
}
]

if __name__ == "__main__":
    from dotenv import load_dotenv
    load_dotenv()
    preference = generate_preference(user_history)
    print(preference)