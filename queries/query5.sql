SELECT media.name,res.name, res.trackCounter 
FROM mediatype AS media 
LEFT OUTER JOIN	(SELECT track.mediaTypeId,genre.Name, COUNT(*) AS trackCounter 
				 FROM track JOIN genre ON track.genreId = genre.genreId
				 GROUP BY genre.Name) AS res 
		    ON res.mediaTypeId =  media.mediaTypeId
WHERE res.trackCounter > 50