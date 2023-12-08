SELECT (SUM(D.Price) + SUM(PE.Price))/2.0 as Average
FROM DEVICE D, PERIPHERAL PE, EMPLOYEE E
WHERE D.UserID = E.UserID and PE.UserID = E.UserID and E.UserID = 1;
