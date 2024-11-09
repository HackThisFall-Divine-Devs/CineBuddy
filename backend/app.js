require('dotenv').config();
require('./room-cleaner/roomDissolve.js'); 
const express = require('express');
const connectDB = require('./database/db.js');



const app = express();
app.use(express.json());
connectDB();



const userRoutes = require('./routes/userRoutes');
const roomRoutes = require('./routes/roomRoutes');


app.use('/api/users', userRoutes);
app.use('/api/rooms', roomRoutes);


const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
