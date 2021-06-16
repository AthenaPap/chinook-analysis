select track.Name,composer, milliseconds, bytes, unitprice from track 
	join genre on track.genreId = genre.GenreId and genre.Name = 'Jazz'
    where track.Name not in
(select distinct result.JazzTracks  from invoiceLine 
inner join
(select trackId, track.Name as JazzTracks from track 
	join genre on track.genreId = genre.GenreId and genre.Name = 'Jazz') as result  
on invoiceLine.trackId =result.trackId)