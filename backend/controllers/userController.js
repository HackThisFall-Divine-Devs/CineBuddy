const User = require("../models/userModel");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");


async function registerUser(req, res) {
  try {
    const { username, email, password, platforms, listOfMovies, genre, others } = req.body;

    let user = await User.findOne({ email });
    if (user) {
      return res.status(400).json({ message: "User already registered" });
    }

    
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    
    user = new User({
      username,
      email,
      password: hashedPassword, 
      platforms: platforms || [],
      listOfMovies: listOfMovies || [],
      genre: genre || [],
      others: others || [],
      createdAt: new Date(),
    });

    await user.save();

  
    const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, { expiresIn: "24h" });

    res.status(201).json({ message: "User registered successfully", token });
  } catch (error) {
    console.error("Error registering user:", error);
    res.status(500).json({ message: "Error registering user" });
  }
}


async function loginUser(req, res) {
  try {
    const { email, password } = req.body;

   
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(400).json({ message: "Invalid email or password" });
    }

   
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ message: "Invalid email or password" });
    }

   
    const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, { expiresIn: "24h" });

    res.status(200).json({ message: "Login successful", token });
  } catch (error) {
    console.error("Error logging in user:", error);
    res.status(500).json({ message: "Error logging in user" });
  }
}




async function getAllUsers(req, res) {
  try {
    const users = await User.find().select("-password"); 
    res.status(200).json(users);
  } catch (error) {
    console.error("Error fetching users:", error);
    res.status(500).json({ message: "Error fetching users" });
  }
}




async function fetchJoinRequests(req, res) {
  const userId = req.user.id;  

  try {
    
    const user = await User.findById(userId).select('Requests').populate('Requests', 'username email'); 

    if (!user) {
      return res.status(404).json({
        success: false,
        message: 'User not found',
      });
    }

   
    if (user.Requests.length === 0) {
      return res.status(200).json({
        success: true,
        message: 'No join requests found for this user',
        requests: [],
      });
    }

   
    return res.status(200).json({
      success: true,
      requests: user.Requests,
    });
  } catch (error) {
    console.error(error);
    return res.status(500).json({
      success: false,
      message: 'Error fetching join requests',
    });
  }
};


async function JoinStream(req, res) {
  const userId = req.user.id;

  try {
      const user = await User.findById(userId);
      if (!user.jitsiLink) {
          return res.status(404).json({ success: false, message: 'No active stream link available' });
      }

      return res.status(200).json({
          success: true,
          jitsiLink: user.jitsiLink,
      });
  } catch (error) {
      console.error(error);
      return res.status(500).json({ success: false, message: 'Error retrieving stream link' });
  }
};


module.exports = { registerUser,loginUser, getAllUsers,fetchJoinRequests,JoinStream};

