const Room = require('../models/roomModel');
const User = require('../models/userModel'); 
const Movie = require('../models/movieModel'); 

//  Create  Room 
exports.createRoom = async (req, res) => {
  const {
    groupName,
    movieName,
    public,
    timePreference,
    timezone,
    date,
    membersLimit,
    ageGroup,
    genderPreference,
    languagePreference,
    type,
    genre,
    otherDetails,
    movieData

  } = req.body;

  try {
    const userId = req.user.id; 



   
    let movie = await Movie.findOne({ title: movieName });

    if (!movie) {
   
      movie = new Movie({
        adult: movieData.adult,
        backdropPath: movieData.backdropPath,
        genre: movieData.genre,  
        id: movieData.id,
        originalLanguage: movieData.originalLanguage,
        originalTitle: movieData.originalTitle,
        overview: movieData.overview,
        popularity: movieData.popularity,
        posterPath: movieData.posterPath,
        releaseDate: movieData.releaseDate,
        title: movieData.title,
        video: movieData.video,
        voteAverage: movieData.voteAverage,
        voteCount: movieData.voteCount,
      });

      await movie.save();
      console.log('Movie added!!');
    }

    const room = new Room({
      groupName,
      movieName,
      public,
      timePreference,
      timezone,
      date,
      membersLimit,
      ageGroup,
      genderPreference,
      languagePreference,
      type,
      genre,
      otherDetails,
      movie: movie._id,
      createdBy: userId, 
    });

   
    const createdRoom = await room.save();

   
    return res.status(201).json({
      success: true,
      room: createdRoom,
      movie: movie,
    });
  } catch (error) {
    console.error(error);
    return res.status(500).json({
      success: false,
      message: 'Error creating the room',
    });
  }
};



// View all the Public Rooms
exports.viewAllPublicRooms = async (req, res) => {
    try {
      
      const rooms = await Room.find({ public: true })
        .populate('joinedMembers', 'username email') 
        .populate('createdBy', 'username email') 
        .populate({
          path: 'movie',  
          model: 'Movie',
        });  
  
      if (!rooms || rooms.length === 0) {
        return res.status(200).json({
          success: true,
          message: 'No public rooms yet!',
          rooms: [],
        });
      }

      
      return res.status(200).json({
        success: true,
        rooms,
      });
    } catch (error) {
      console.error(error);
      return res.status(500).json({
        success: false,
        message: 'Error fetching public rooms',
      });
    }
  };


// View details of a particular room

exports.viewRoomDetails = async (req, res) => {
    const { roomId } = req.params;  // Extract roomId from the route params
  
    try {
    
      const room = await Room.findById(roomId)
      .populate('joinedMembers', 'username email')
      .populate('createdBy', 'username email')
      .populate({
        path: 'movie',  
        model: 'Movie', 
      });
 
  
      if (!room) {
        return res.status(404).json({
          success: false,
          message: 'Room not found',
        });
      }
  
     
      if (room.public) {
       
        return res.status(200).json({
          success: true,
          room,
        });
      } else {
        // If the room is private, check if the user is the creator or a member
        const userId = req.user.id; 
  
        
        if (!room.joinedMembers.includes(userId) && room.createdBy.toString() !== userId) {
          return res.status(403).json({
            success: false,
            message: 'You do not have permission to view this room',
          });
        }
  
        // If the user is the creator or a member, show the room details
        return res.status(200).json({
          success: true,
          room,
        });
      }
    } catch (error) {
      console.error(error);
      return res.status(500).json({
        success: false,
        message: 'Error fetching the room details',
      });
    }
  };



// Request to join Room
  exports.requestToJoinRoom = async (req, res) => {
    const { roomId } = req.params; 
    const userId = req.user.id;    
  
    try {
     
      const room = await Room.findById(roomId);
  
      if (!room) {
        return res.status(404).json({ success: false, message: 'Room not found' });
      }
  
     
      if (room.joinedMembers.includes(userId)) {
        return res.status(400).json({ success: false, message: 'You are already a member of this room' });
      }
  
      if (room.pendingRequests.includes(userId)) {
        return res.status(400).json({ success: false, message: 'You have already requested to join this room' });
      }
  
  
      room.pendingRequests.push(userId);
      await room.save();
  
      return res.status(200).json({ success: true, message: 'Join request sent successfully' });
    } catch (error) {
      console.error(error);
      return res.status(500).json({ success: false, message: 'Error sending join request' });
    }
  };
  



  // Approve or Deny the Request by admin

  exports.handleJoinRequest = async (req, res) => {
    const { roomId, userId } = req.params; 
    const { action } = req.body;          
    const currentUserId = req.user.id;    
  
    try {
      const room = await Room.findById(roomId);
  
      if (!room) {
        return res.status(404).json({ success: false, message: 'Room not found' });
      }

if (room.createdBy.toString() !== currentUserId) {
    return res.status(403).json({ success: false, message: 'You are not authorized to approve requests for this room' });
  }

  if (!room.pendingRequests.includes(userId)) {
    return res.status(400).json({ success: false, message: 'This user has not requested to join' });
  }

  if (action === 'approve') {
   
    room.joinedMembers.push(userId);
    room.pendingRequests = room.pendingRequests.filter(reqId => reqId.toString() !== userId);

    await User.findByIdAndUpdate(userId, { $addToSet: { joinedRooms: roomId } });
  
  } else if (action === 'deny') {
   
    room.pendingRequests = room.pendingRequests.filter(reqId => reqId.toString() !== userId);
  } else {
    return res.status(400).json({ success: false, message: 'Invalid action' });
  }

  await room.save();

  return res.status(200).json({ success: true, message: `Request ${action}d successfully` });
} catch (error) {
  console.error(error);
  return res.status(500).json({ success: false, message: 'Error handling join request' });
}
};




// View join requests for a room 
exports.viewJoinRequests = async (req, res) => {
    const { roomId } = req.params;
    const currentUserId = req.user.id; 
  
    try {
      const room = await Room.findById(roomId)
        .populate('pendingRequests', 'username email') 
        .populate('createdBy', 'username email');     
  
      if (!room) {
        return res.status(404).json({ success: false, message: 'Room not found' });
      }
  

      if (room.createdBy._id.toString() !== currentUserId) {
        return res.status(403).json({
          success: false,
          message: 'You are not authorized to view join requests for this room',
        });
      }
  
      
      return res.status(200).json({
        success: true,
        pendingRequests: room.pendingRequests,
      });
    } catch (error) {
      console.error(error);
      return res.status(500).json({ success: false, message: 'Error fetching join requests' });
    }
  };



// Add Friends to the Group/ Room by admin of the roomm
exports.addFriendToRoom = async (req, res) => {
  const { roomId } = req.params;
  const { friendId } = req.body;  
  const currentUserId = req.user.id;

  try {
      const room = await Room.findById(roomId)
      .populate('joinedMembers', 'username email')
      .populate('createdBy', 'username email')
      .populate({
          path: 'movie',
          model: 'Movie',
      });

      if (!room) {
          return res.status(404).json({ success: false, message: 'Room not found' });
      }


      if (room.joinedMembers.includes(friendId)) {
        return res.status(400).json({
            success: false,
            message: 'This person is already a member of the room',
        });
    }
      
      if (room.createdBy.toString() !== currentUserId) {
          return res.status(403).json({
              success: false,
              message: 'You do not have permission to add friends to this room',
          });
      }

     
      const friendObjectId = mongoose.Types.ObjectId(friendId);

      const isAlreadyMember = room.joinedMembers.some(
          (member) => member._id.toString() === friendObjectId.toString()
      );

      if (isAlreadyMember) {
          return res.status(400).json({
              success: false,
              message: 'This person is already a member of the room',
          });
      }

     
      room.joinedMembers.push(friendObjectId);

     
      await room.save();

      await User.findByIdAndUpdate(friendId, { $addToSet: { joinedRooms: roomId } });

      return res.status(200).json({
          success: true,
          message: 'Friend added to the room',
          room,
      });
  } catch (error) {
      console.error(error);
      return res.status(500).json({ success: false, message: 'Error adding friend to the room' });
  }
};
  