const express = require('express');
const verifyToken = require('../middleware/authMiddleware');
const userController = require('../controllers/userController');

const router = express.Router();

router.post('/register', verifyToken, userController.registerUser);

module.exports = router;
