SELECT playlist.playlistid, playlist.name FROM playlist JOIN
(SELECT res2.playlistid, res2.genres FROM  
(SELECT res1.playlistid, COUNT(distinct res1.genreid) AS genres FROM   
  (SELECT  playlisttrack.playlistid, Playlisttrack.trackid, track.genreid 
      FROM playlisttrack 
	  JOIN track 
      ON track.trackid = playlisttrack.trackid
      WHERE track.genreid IN (SELECT genreid FROM genre WHERE name IN ('Rock','Metal'))) AS res1
GROUP BY playlistid) AS res2
WHERE genres > 1) AS res3
WHERE res3.playlistid = playlist.playlistid