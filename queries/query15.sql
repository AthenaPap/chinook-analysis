SELECT BillingCity AS billingCity,
       SUM(Total)  AS InvoiceTotal 
  FROM Invoice 
GROUP BY BillingCity 
ORDER BY InvoiceTotal DESC;