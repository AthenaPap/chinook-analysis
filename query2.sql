SELECT AlbumId, Title 
FROM album INNER JOIN artist
ON album.ArtistId = artist.ArtistId
WHERE Name = 'Led Zeppelin'