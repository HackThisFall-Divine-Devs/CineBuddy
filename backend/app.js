require('dotenv').config();
const express = require('express');
const admin = require('firebase-admin');
const connectDB = require('./database/db.js');

admin.initializeApp({
  credential: admin.credential.cert({
    projectId: process.env.FIREBASE_PROJECT_ID,
    privateKey: process.env.FIREBASE_PRIVATE_KEY.replace(/\\n/g, '\n'),
    clientEmail: process.env.FIREBASE_CLIENT_EMAIL,
  }),
});

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
