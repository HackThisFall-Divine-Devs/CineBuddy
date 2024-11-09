const express = require("express");
const { registerUser, loginUser, getAllUsers } = require("../controllers/userController");
const authMiddleware = require("../middleware/authMiddleware");

const router = express.Router();


router.post("/register", registerUser);


router.post("/login", loginUser);

router.get("/all", authMiddleware, getAllUsers); 

router.get("/profile", authMiddleware, (req, res) => {
  res.send(`User ID: ${req.user.id}`);
});

module.exports = router;
