const mongoose = require('mongoose');

const roomSchema = new mongoose.Schema({
  groupName: { type: String, required: true },  
  movieName: { type: String, required: true }, 
  public: { type: Boolean, default: true }, 
  timePreference: {
    type: String,
    enum: ['morning', 'noon', 'evening', 'late night'],  
    required: true,
  },
  timezone: {
    type: String,
    enum: ['IST', 'GMT'], 
    required: true,
  },
  date: { type: Date, required: true },  
  membersLimit: {
    type: Number,
    required: true,
    validate: {
      validator: function(value) {
        return (this.type === 'dating' && value <= 2) || (this.type === 'friend' && value <= 10);
      },
      message: 'Max limit for dating group is 2 members, and for friend group, it is 10 members.',
    },
  },
  joinedMembers: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }],
  pendingRequests: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }],
  ageGroup: { 
    type: String, 
    enum: ['12-18','18-25', '25-35', '35+'], 
    required: true 
  },  
  genderPreference: {
    type: String,
    enum: ['anyone', 'only girls', 'only boys'],
    default: 'anyone',
  },
  languagePreference: {
    type: [String],
    enum: ['English', 'Hindi', 'Spanish', 'French', 'German', 'Others'],
    default: ['English'],  
  },

  type: { type: String, enum: ['dating', 'friend'], required: true }, 
  createdBy: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true }, 
  genre: {
    type: String,
    enum: ['horror', 'comedy', 'action', 'romantic', 'thriller', 'drama', 'sci-fi', 'documentary'],
    required: true,
  },
  movie: { type: mongoose.Schema.Types.ObjectId, ref: 'Movie' }, 
  createdAt: { type: Date, default: Date.now },  
});

const Room = mongoose.model('Room', roomSchema);

module.exports = Room;
