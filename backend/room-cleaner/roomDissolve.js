const cron = require('node-cron');
const Room = require('../models/roomModel');  


cron.schedule('0 0 * * *', async () => {
  console.log('Checking for already streamed rooms...');

  try {
   
    const rooms = await Room.find();

    for (let room of rooms) {
      const roomDate = new Date(room.date);  
      const currentDate = new Date();

    
      if (currentDate > roomDate) {
        await Room.findByIdAndDelete(room._id);  
        console.log(`Room ${room._id} deleted.`);
      }
    }
  } catch (error) {
    console.error('Error checking for expired rooms:', error);
  }
});
