SELECT customer.LastName, invoice.InvoiceDate 
FROM INVOICE JOIN CUSTOMER ON invoice.CustomerId = customer.CustomerId AND customer.Country = 'Canada'
ORDER BY invoice.InvoiceDate DESC 
LIMIT 1