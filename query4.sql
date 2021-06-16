SELECT E.FirstName, E.LastName, COALESCE(C.Counter, 0) as Counter
FROM employee AS E
LEFT OUTER JOIN ( SELECT SupportRepID, COUNT(*) AS Counter
				  FROM customer 
                  GROUP BY SupportRepID  ) AS C 
			ON C.SupportRepID = E.EmployeeId