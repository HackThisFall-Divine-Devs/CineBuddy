# CineBuddy 🍿 
Because movies are better with company🤗

It's friday night, your'e all set for to binge your favourite movie🥳  
But all friends bail last minute!
<p align = "center">
<img src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExdDFoNWN5dWxsaWJtMXRjZ2RlNXBhYno0bHQ4bWFxMDkyM2o0YjE5aCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/hECJDGJs4hQjjWLqRV/giphy.webp">
</p>

You want the excitement of sharing the experience—the laughs, the gasps, the “wait, what?” moments.  
Well guess what? CineBuddy has got you covered😎   
  
In just a few clicks, you can join or create a movie group with others who want to watch the same film, at the same time. No awkward scheduling, no cancellations. Just instant movie magic, shared with new friends or fellow fans.

When the credits roll, the group vanishes—no clutter, no hassle, just a shared experience.

<div style="display: flex; flex-direction: row">
  <img src = "https://github.com/user-attachments/assets/9c25784e-caf0-4caf-b614-7a02e84cc878" width = "40%"> 
  <img src = "https://github.com/user-attachments/assets/163034ee-aea7-424d-bd23-dec8a2d092b6" width = "40%">
</div>


# 📸 Clicks
<div style="display: flex; flex-direction: row; overflow-x: scroll">
  <img src = "https://github.com/user-attachments/assets/cdcde4d3-e8e8-4cac-8a5f-0daaf523eea7" width = "30%">
  <img src = "https://github.com/user-attachments/assets/4391e6e2-9fe9-4af5-90dd-626502862f98" width = "30%">
  <img src = "https://github.com/user-attachments/assets/1423c7f6-48bb-4463-8d2e-5f78793c0f56" width = "30%">
  <img src = "https://github.com/user-attachments/assets/b7a702d5-118b-4b59-b561-4979a4e3df43" width = "30%">
  <img src = "https://github.com/user-attachments/assets/c837ce71-55b7-420e-b341-5abf93a1b4a2" width = "30%">
  <img src = "https://github.com/user-attachments/assets/7d34331e-5638-4137-907a-bab2915ca661" width = "30%">
  <img src = "https://github.com/user-attachments/assets/e4ddabb2-e9d3-44f8-a26f-2d4b0fc5b027" width = "30%">
  <img src = "https://github.com/user-attachments/assets/cdc9f1be-ddcb-4543-aa79-c4fa40f69dcb" width = "30%">
  <img src = "https://github.com/user-attachments/assets/1f37f0b6-27dd-4998-900c-0b1c2da6ebf5" width = "30%">




</div> 


# ⚙ Features
- **Create or Join a Group**:
  Users can form a group of any size (e.g., a cozy circle of 5 or a large public gathering) and select the movie they’d like to watch, along with a preferred showtime.
- **Open to All or Invite-Only**:
  Want to watch only with your friends or as a date? We got you covered! Groups can be made public or kept private.  If someone else wants to watch the same movie at the same time, they can easily request to join the group.
- **GenAI based Matchmaking**:
  Facing difficulty in finding the group that will suit you? Worry not as our Google's Gemini Based GenAI agent takes care of matchmaking for you!
  
  
# 💻 Tech Stack:
![NodeJS](https://img.shields.io/badge/node.js-6DA55F?style=for-the-badge&logo=node.js&logoColor=white) ![MongoDB](https://img.shields.io/badge/MongoDB-%234ea94b.svg?style=for-the-badge&logo=mongodb&logoColor=white) ![Express.js](https://img.shields.io/badge/express.js-%23404d59.svg?style=for-the-badge&logo=express&logoColor=%2361DAFB)  
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)  
![GeminiAPI](https://img.shields.io/badge/Google%20Gemini-8E75B2.svg?style=for-the-badge&logo=Google-Gemini&logoColor=white)  
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54) ![Flask](https://img.shields.io/badge/flask-%23000.svg?style=for-the-badge&logo=flask&logoColor=white)  
![Postman](https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=postman&logoColor=white)



# ✨ Gemini API in Action!
Google's very own `gemini-1.5-flash` LLM model, enabled by **Gemini API** is the brains of the matchmaking feature of our application.  

The LLM evaluates each user's profile and room joining history to predict what type of room the user would prefer to join again.  

With these preferences all rooms are ranked and the user is recommended the room of their liking.  

With Gemini API's structured output generation mechanism, the implementation of the system was much simpler cleaner and more importantly faster!  

When compared with the traditional methods of manually extracting recent context for the model, Gemini API's grounding feature makes it exponentially easy for the model to look throught the internet for recent and relavant information while recommending movies for users.   

To view our implementation of the matchmaking feature using Gemini API✨ head on over to `ml_api/llms/`!  



# 📃API Documentation
Backend API hosted at [![Vercel](https://img.shields.io/badge/vercel-%23000000.svg?style=for-the-badge&logo=vercel&logoColor=white)](https://cine-buddy-backend.vercel.app)  
Machine Learning API hosted at [![Render](https://img.shields.io/badge/Render-%46E3B7.svg?style=for-the-badge&logo=render&logoColor=white)](https://cinebuddy.onrender.com/)  
Few important API endpoints:  
  
**All Public Rooms**  
*Description*: List all public rooms 
```
/api/rooms/public
```

**Room Details**  
*Description*: Detail of a given room with id: `room_id`
```
/api/rooms/{room_id}
```

**Room Search**  
*Description*: Search movies based on date and title
```
/api/rooms/search
```

**ML Matchmaking with Gemini API**  
*Description*: Find relavant rooms for the given user with id `user_id`
```
/mlapi/matchmaking/{user_id}
```



# 🎁 Sponsor tracks we are part of!
<img src = "https://github.com/user-attachments/assets/58bf8369-6e9e-4dbe-a6a7-afe7b7f4e52e" height="100px"> <img src = "https://github.com/user-attachments/assets/adad5efd-d553-413f-b28a-f21636f41f98" height="100px"> <img src = "https://github.com/user-attachments/assets/677a5c28-0cc1-4c0e-9637-ea6c6efe5e69" height="100px"> <img src = "https://github.com/user-attachments/assets/3ecea176-a9ca-4501-b92e-fe4b5d3bccde" height="100px"> <img src = "https://github.com/user-attachments/assets/eff62dbf-f092-444f-92e2-3aa64b677101" height="100px">






# 🤝 Collaborators
- Akarsh Jain [![LinkedIn](https://img.shields.io/badge/LinkedIn-%230077B5.svg?logo=linkedin&logoColor=white)](https://www.linkedin.com/in/akarshjain158/) [![LinkedIn](https://img.shields.io/badge/Github-%230077B5.svg?logo=github&logoColor=white)](https://github.com/akarsh-jain-790) 
- Sunidhi Jain [![LinkedIn](https://img.shields.io/badge/LinkedIn-%230077B5.svg?logo=linkedin&logoColor=white)](https://www.linkedin.com/in/sunidhi-jain-b71866284/) [![LinkedIn](https://img.shields.io/badge/Github-%230077B5.svg?logo=github&logoColor=white)](https://github.com/SUNIDHI-JAIN125)
- Aditya R [![LinkedIn](https://img.shields.io/badge/LinkedIn-%230077B5.svg?logo=linkedin&logoColor=white)](https://www.linkedin.com/in/adityarags/) [![LinkedIn](https://img.shields.io/badge/Github-%230077B5.svg?logo=github&logoColor=white)](https://github.com/adityarags)
