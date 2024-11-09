const userPreferences = {};

router.post('/submit-preferences', async (req, res) => {
  const {
    userId,
    genre, 
    language,  
    time,  
    date,  
    ageGroup, 
    genderPreference,  
    roomType  
  } = req.body;

  
  if (!['horror', 'comedy', 'action', 'romantic', 'thriller', 'drama', 'sci-fi', 'documentary'].includes(genre)) {
    return res.status(400).json({ success: false, message: 'Invalid genre' });
  }

  if (!Array.isArray(language) || !language.every(lang => ['English', 'Hindi', 'Spanish', 'French', 'German', 'Others'].includes(lang))) {
    return res.status(400).json({ success: false, message: 'Invalid language preference' });
  }

  if (!['morning', 'noon', 'evening', 'late night'].includes(time)) {
    return res.status(400).json({ success: false, message: 'Invalid time preference' });
  }

  if (isNaN(new Date(date).getTime())) {
    return res.status(400).json({ success: false, message: 'Invalid date format' });
  }

  if (!['12-18', '18-25', '25-35', '35+'].includes(ageGroup)) {
    return res.status(400).json({ success: false, message: 'Invalid age group' });
  }

  if (!['anyone', 'only girls', 'only boys'].includes(genderPreference)) {
    return res.status(400).json({ success: false, message: 'Invalid gender preference' });
  }

  if (!['dating', 'friend'].includes(roomType)) {
    return res.status(400).json({ success: false, message: 'Invalid room type' });
  }

 
  userPreferences[userId] = {
    genre,
    language,
    time,
    date: new Date(date),
    ageGroup,
    genderPreference,
    roomType
  };

  return res.status(200).json({ success: true, message: 'Preferences saved successfully' });
});
