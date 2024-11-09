import typing_extensions as T 
import enum

class AgeGroup(enum.Enum):
    UNDER18 = "under18"
    _18TO25 = "18to25"
    _26TO40 = "26to40"
    _40PLUS = "40+"


class TimePreference(enum.Enum):
    MORNING = "morning"
    AFTERNOON = "afternoon"
    NIGHT = "night"
    LATENIGHT = "late night"


class GenderPreference(enum.Enum):
    MALE = "male"
    FEMALE = "female"
    NONBINARY = "non binary"
    ANY = "any"



class RoomRecommendation(T.TypedDict):
    ageGroup: AgeGroup
    languagePreference: list[str]
    genre: str
    timePreference: TimePreference
    genderPreference: GenderPreference