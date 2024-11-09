

const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  username: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
    unique: true,
  },
  password: {
    type: String,
    required: true,
  },
  platforms: {
    type: [String],
    default: [],
  },
  listOfMovies: {
    type: [String],
    default: [],
  },
  genre: {
    type: [String],
    default: [],
  },
  others: {
    type: [String],
    default: [],
  },
   joinedRooms: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Room' }],
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

const User = mongoose.model("User", userSchema);

module.exports = User;
