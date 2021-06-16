SELECT E.lastname as EmployeeName, E.birthdate as EmployeeBirthday, M.lastname as ManagerName, M.birthdate as ManagerBirthday FROM EMPLOYEE E
INNER JOIN EMPLOYEE M 
ON e.reportsTo = m.employeeId
AND e.birthdate < m.birthdate