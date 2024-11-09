const User = require("../models/userModel");

// register usr
async function registerUser(req, res) {
  try {
    const { username, platforms, listOfMovies, genre, others } = req.body;
    const firebaseUid = req.user.uid; 

    let user = await User.findOne({ firebaseUid });
    if (user) {
      return res.status(400).send("User already registered");
    }

    user = new User({
      firebaseUid,
      username,
      email: req.user.email,
      platforms: platforms || [],
      listOfMovies: listOfMovies || [],
      genre: genre || [],
      others: others || [], 
      createdAt: new Date(),
    });

    //usr
    console.log(User);

    await user.save();
    res.status(201).send("User registered successfully");
  } catch (error) {
    console.error("Error registering user:", error);
    res.status(500).send("Error registering user");
  }
}

//
module.exports = { registerUser };
