const mongoose = require('mongoose');

const movieSchema = new mongoose.Schema({
  adult: { type: Boolean, required: true }, 
  backdropPath: { type: String, required: true }, 
  genre: [{ type: String, required: true }], 
  id: { type: Number, required: true, unique: true },  
  originalLanguage: { type: String, required: true },  
  originalTitle: { type: String, required: true }, 
  overview: { type: String, required: true },  
  popularity: { type: Number, required: true },  
  posterPath: { type: String, required: true },  
  releaseDate: { type: String, required: true },  
  title: { type: String, required: true }, 
  voteAverage: { type: Number, required: true },  
  voteCount: { type: Number, required: true }, 
}, { timestamps: true });  

const Movie = mongoose.model('Movie', movieSchema);

module.exports = Movie;
