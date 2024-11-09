const express = require('express');
const {
    createRoom,
    viewAllPublicRooms,
    viewRoomDetails,
    requestToJoinRoom,
    handleJoinRequest,
    viewJoinRequests,
    addFriendToRoom,
  } = require('../controllers/roomController');

  
  
const router = express.Router();
const authenticate = require('../middleware/authMiddleware'); 

router.post('/create', authenticate, createRoom);
router.get('/public', authenticate, viewAllPublicRooms);
router.get('/:roomId', authenticate, viewRoomDetails);

router.post('/:roomId/request-join', authenticate, requestToJoinRoom);

router.post('/:roomId/handle-request/:userId', authenticate, handleJoinRequest);
router.get('/:roomId/join-requests', authenticate, viewJoinRequests);
router.post('/:roomId/add-friend', authenticate, addFriendToRoom);

module.exports = router;
