SELECT genre.name, COUNT(genre.GenreId) as numOfTracks 
from track 
LEFT JOIN genre ON track.GenreId = genre.GenreId
GROUP BY genre.GenreId
ORDER BY COUNT(track.GenreId) DESC 