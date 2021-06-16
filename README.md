# chinook-analysis
Source code to query the Chinook Database

# MySql

### Question 01: Find all the albums that their Title contains the word 'Best'.[all fields]
``` 
SELECT * FROM Album
WHERE Title LIKE '%Best' 
```
### Question 02: Find all the albums of Led Zeppelin.

``` 
SELECT AlbumId, Tile 
FROM Album 
INNER JOIN Artist ON album.ArtistId = artist.ArtistId
WHERE Name = 'Led Zeppelin'

``` 
### Question 03: The number of tracks for each genre in descenting order - in terms of crowd.

``` 
SELECT genre.name, COUNT(genre.GenreId) as numOfTracks 
FROM track 
LEFT JOIN genre ON track.GenreId = genre.GenreId
GROUP BY genre.GenreId
ORDER BY COUNT(track.GenreId) DESC 

``` 

### Question 04: For each employee, find the number of customers that he serves.
Display also the employees that don't serve any customer.

```
SELECT E.FirstName, E.LastName, COALESCE(C.Counter, 0) as Counter
FROM employee AS E
LEFT OUTER JOIN ( SELECT SupportRepID, COUNT(*) AS Counter
				          FROM customer 
                  GROUP BY SupportRepID  ) AS C 
			ON C.SupportRepID = E.EmployeeId
```

### Question 05: Combinations of media type and music genre which contain over 50 tracks in descending order
in terms of the number of tracks.

```
SELECT media.name,res.name, res.trackCounter 
FROM mediatype AS media 
LEFT OUTER JOIN	( SELECT track.mediaTypeId,genre.Name, COUNT(*) AS trackCounter 
				          FROM track JOIN genre ON track.genreId = genre.genreId
				          GROUP BY genre.Name) AS res ON res.mediaTypeId =  media.mediaTypeId
WHERE res.trackCounter > 50
```

### Question 06: All orders (invoice) sent to 'New York' and containing tracks belonging to
more than one genre of music.

```
SELECT res2.invoiceid, total FROM invoice JOIN	
  (SELECT res1.trackid, res1.invoiceid,genreid, res1.genreCtr, res1.Quantity, res1.quan1 
    FROM
      (SELECT track.trackid, res.invoiceid,genreid, COUNT(DISTINCT genreid) AS genreCtr, res.Quantity, res.quan1  
       FROM track 
       JOIN
		  ( SELECT  trackid, invoiceid, Quantity, UnitPrice AS quan1 
		    FROM invoiceline 
		    WHERE invoiceid IN (SELECT invoiceid 
							              FROM invoice 
							              WHERE billingcity = 'New York') 
		  ) AS res
	 ON track.trackid = res.trackid
	 GROUP BY invoiceid) AS res1
WHERE res1.genreCtr > 1) AS res2
ON invoice.invoiceid = res2.InvoiceId

```

### Question 07: Customers who have purchased track from all genres of music starting with S.

```
SELECT res2.customerid FROM 
(SELECT  res.customerid, count(res.genreid) AS genreCtr FROM
	(SELECT DISTINCT C.CUSTOMERID, T.GENREID FROM TRACK AS T
		JOIN INVOICELINE IL ON IL.TRACKID = T.TRACKID
		JOIN INVOICE I ON I.INVOICEID = IL.INVOICEID
		JOIN CUSTOMER C ON C.CUSTOMERID = I.CUSTOMERID
	  WHERE T.GENREID IN (	SELECT DISTINCT G.GENREID 
							FROM GENRE G
							WHERE G.NAME LIKE 'S%')) as res
GROUP BY res.customerid) AS res2
WHERE res2.genreCtr = (SELECT count(*) FROM genre WHERE NAME LIKE'S%')

```

### Question 08: Employees that are older than their manager.
Display the employe_lastname, employee_birthdate, manager_lastname, manager_birthdate

```
SELECT E.lastname, E.birthdate, M.lastname, M.birthdate 
FROM EMPLOYEE E
INNER JOIN EMPLOYEE M ON e.reportsTo = m.employeeId
                     AND e.birthdate < m.birthdate
```

### Question 09: Find the customer from Canada with the most recent order.
Display his lastname along with the date of invoice.

```
SELECT customer.LastName, invoice.InvoiceDate 
FROM INVOICE 
JOIN CUSTOMER ON invoice.CustomerId = customer.CustomerId 
               AND customer.Country = 'Canada'
ORDER BY invoice.InvoiceDate DESC 
LIMIT 1

```

### Question 10: The playlist with the most tracks. In case that 2 or more playlists have the same
number of tracks display them all.

```
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
ORDER BY result.playlistSize )
```
### Question 11: Which playlists have tracks that belong both in 'Rock' and 'Metal' genre.

```
SELECT playlist.playlistid, playlist.name FROM playlist JOIN
(SELECT res2.playlistid, res2.genres 
 FROM  
  (SELECT res1.playlistid, COUNT(distinct res1.genreid) AS genres 
   FROM   
    (SELECT  playlisttrack.playlistid, Playlisttrack.trackid, track.genreid 
     FROM playlisttrack 
	   JOIN track ON track.trackid = playlisttrack.trackid
     WHERE track.genreid IN (SELECT genreid 
                             FROM genre 
                             WHERE name IN ('Rock','Metal'))) AS res1
  GROUP BY playlistid) AS res2
  WHERE genres > 1) AS res3
WHERE res3.playlistid = playlist.playlistid


```
### Question 12: Display the Jazz tracks that have not been sold yet.

```
SELECT track.Name,composer, milliseconds, bytes, unitprice 
FROM track 
	JOIN genre ON track.genreId = genre.GenreId and genre.Name = 'Jazz'
    WHERE track.Name NOT IN (SELECT distinct result.JazzTracks  
                             FROM invoiceLine 
                             INNER JOIN (SELECT trackId, track.Name AS JazzTracks 
                                         FROM track 
	                                       JOIN genre ON track.genreId = genre.GenreId AND genre.Name = 'Jazz') AS result  
  ON invoiceLine.trackId =result.trackId)
```
### Question 13: Which countries have the most invoices.
             
```            
SELECT BillingCountry AS billingCountry, COUNT(*) AS Invoices 
FROM Invoice 
GROUP BY BillingCountry 
ORDER BY Invoices DESC
``` 
### Question 14: The artists who have written the most rock music in our dataset. Write a query that returns the 
Artist name and total track count of the top 10 rock bands.  

```
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
 LIMIT 10

```
### Question 15: Which city has the best customers?
```
SELECT BillingCity AS billingCity,
       SUM(Total)  AS InvoiceDollars 
  FROM Invoice 
GROUP BY BillingCity 
ORDER BY InvoiceDollars DESC

```








