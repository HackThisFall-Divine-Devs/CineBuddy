const express = require('express');
const Room = require('../models/roomModel');
const {
  createRoom,
  viewAllPublicRooms,
  viewRoomDetails,
  requestToJoinRoom,
  handleJoinRequest,
  viewJoinRequests,
  addFriendToRoom,
  startStream,
} = require('../controllers/roomController');

const router = express.Router();
const authenticate = require('../middleware/authMiddleware'); 


router.get('/search', authenticate, async (req, res) => {
  const { movieName, date } = req.query;
  const query = {};

  if (movieName) {
    query.movieName = { $regex: movieName, $options: 'i' };
  }

  if (date) {
    query.date = new Date(date);
  }

  try {
    const rooms = await Room.find(query)
      .populate('createdBy', 'username email')
      .populate('joinedMembers', 'username email')
      .populate('movie');
    res.status(200).json({ success: true, rooms });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, message: 'Error fetching rooms' });
  }
});

router.post('/create', authenticate, createRoom);
router.get('/public', authenticate, viewAllPublicRooms);
router.get('/:roomId', authenticate, viewRoomDetails);
router.post('/:roomId/request-join', authenticate, requestToJoinRoom);
router.post('/:roomId/handle-request/:userId', authenticate, handleJoinRequest);
router.get('/:roomId/join-requests', authenticate, viewJoinRequests);
router.post('/:roomId/add-friend', authenticate, addFriendToRoom);
router.post('/:roomId/start-stream', authenticate, startStream);


module.exports = router;
