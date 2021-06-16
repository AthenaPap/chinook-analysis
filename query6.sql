SELECT res2.invoiceid, total FROM invoice JOIN	
(SELECT res1.trackid, res1.invoiceid,genreid, res1.genreCtr, res1.Quantity, res1.quan1 FROM
    (SELECT track.trackid, res.invoiceid,genreid, COUNT(DISTINCT genreid) AS genreCtr, res.Quantity, res.quan1  FROM track JOIN
		(SELECT  trackid, invoiceid, Quantity, UnitPrice AS quan1 
		 FROM invoiceline 
		 WHERE invoiceid IN (SELECT invoiceid 
							 FROM invoice 
							where billingcity = 'New York') 
		 ) AS res
	 ON track.trackid = res.trackid
	 GROUP BY invoiceid) AS res1
WHERE res1.genreCtr > 1) AS res2
ON invoice.invoiceid = res2.InvoiceId