const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  Uid: { type: String, required: true, unique: true },
  username: { type: String, required: true },
  email: { type: String, required: true },
  platforms: { type: [String], default: [] },
  listOfMovies: { type: [String], default: [] },
  genre: { type: [String], default: [] }, 
  createdAt: { type: Date, default: Date.now },
});

const User = mongoose.model('User', userSchema);

module.exports = User;
