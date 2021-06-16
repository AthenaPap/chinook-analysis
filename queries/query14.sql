SELECT Artist.ArtistId,
       Artist.Name,
       COUNT(Track.Name) AS SongCounter 
  FROM Artist 
  JOIN Album ON Album.ArtistId = Artist.ArtistId 
  JOIN Track ON Album.AlbumId = Track.AlbumId 
  JOIN Genre ON Track.GenreId = Genre.GenreId 
 WHERE Genre.Name = 'Rock' 
GROUP BY Artist.ArtistId,
       Artist.Name,
       Genre.Name 
ORDER BY SongCounter DESC 
 LIMIT 10;