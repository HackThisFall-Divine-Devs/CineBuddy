const admin = require('firebase-admin');

async function verifyToken(req, res, next) {
  const idToken = req.headers.authorization?.split('Bearer ')[1];

  if (!idToken) {
    return res.status(401).send('Unauthorized');
  }

  try {
    const Token = await admin.auth().verifyIdToken(idToken);
    req.user = Token;
    next(); 
  } catch (error) {
    console.error('Error verifying token:', error);
    res.status(401).send('Unauthorized: Invalid token');
  }
}

module.exports = verifyToken;
