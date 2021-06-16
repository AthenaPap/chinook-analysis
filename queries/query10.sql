SELECT playlist.playlistId, name, result.playlistSize 
FROM playlist 
JOIN 
	(SELECT PlaylistId, COUNT(trackId) AS playlistSize 
	 FROM playlisttrack 
	 GROUP BY playlisttrack.PlaylistId ) AS result 
ON result.PlaylistId = playlist.PlaylistId 
WHERE playlistsize = ( SELECT MAX(res1.playlistSize) FROM
							( SELECT PlaylistId, COUNT(trackId) AS playlistSize 
							  FROM playlisttrack 
							  GROUP BY playlisttrack.PlaylistId) AS res1 )
ORDER BY result.playlistSize 