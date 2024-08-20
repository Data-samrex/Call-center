use Callcenterdb;

--(1)Display first name, last name and phone number of customers who have their numbers end with ‘0’.
SELECT Firstname, LastName, Phone
FROM Customers
WHERE Phone LIKE '%0'

-- (2) Display all employees in Customer Service, HR, Marketing department.
SELECT *
FROM Employees
WHERE Department IN ('Customer Service', 'HR', 'Marketing');


--(3)Find all orders that are fully activated with the activation status completed
SELECT *
FROM Orders_and_Services
WHERE [Activation Status] = 'completed';


--(4)Find the most frequently ordered plan and give details about the plan ie plan name,  monthly fee, data allowance, talkime and text 
-- and arrange form the most frequent
SELECT mp.PlanID, mp.PlanName, mp.MonthlyFee, mp.Data_Allowance, 
       mp.Talktime_Allowance, mp.Textmessage_Allowance, COUNT(*) AS order_count
FROM Orders_and_Services ot
INNER JOIN Mobile_plan mp ON ot.PlanID = mp.PlanID
GROUP BY mp.PlanID, mp.PlanName, mp.MonthlyFee, mp.Data_Allowance, 
         mp.Talktime_Allowance, mp.Textmessage_Allowance
ORDER BY order_count DESC

--(5)Find the most recent order for each customer and display their fullname
SELECT c.CustomerID, CONCAT(cu.FirstName, ' ' ,cu.LastName) AS [Full Name] , o.OrderID, o.[Activation Date:]
FROM Orders_and_Services o
INNER JOIN Customers cu ON o.CustomerID = cu.CustomerID
INNER JOIN (
  SELECT cus.CustomerID, MAX([Activation Date:]) AS max_date
  FROM Orders_and_Services os
  INNER JOIN Customers cus ON os.CustomerID = cus.CustomerID  
  GROUP BY cus.CustomerID
) c ON o.CustomerID = c.CustomerID
AND o.[Activation Date:] = c.max_date;


-- (6)Find all employees who have made a successful transaction, the plan name and the amount paid upfront during the transactions.
SELECT e.EmployeeID, e.Frist_name, e.Last_name, p.PlanName, SUM(t.Upfront_payment) AS Total_Upfront_Payment
FROM Employees e
INNER JOIN Transactions t ON e.EmployeeID = t.EmployeeID
INNER JOIN Products pr ON t.ProductID = pr.ProductID
INNER JOIN Mobile_plan p ON pr.PlanID = p.PlanID  
WHERE t.payment_status = 'processed'  
GROUP BY e.EmployeeID, e.Frist_name, e.Last_name, p.PlanName
ORDER BY Total_Upfront_Payment DESC;

--  (7)Find all customers with their details, plan name, and upfront payment details for completed and processing orders.

SELECT c.CustomerID, c.FirstName, c.LastName, p.PlanName,
       t.Upfront_payment, t.Remaining_bal, o.[Activation Status]
FROM Customers c
INNER JOIN Orders_and_Services o ON c.CustomerID = o.CustomerID
INNER JOIN Transactions t ON o.CustomerID = t.CustomerID  
INNER JOIN Mobile_plan p ON o.PlanID = p.PlanID  
WHERE o.[Activation Status] IN ('completed', 'processing')
ORDER BY c.CustomerID, o.[Activation Status];

--(8) Calulate the monthly total revenue from each transation
SELECT
  o.CustomerID,  
  SUM(o.Quantity * mp.MonthlyFee) AS total_revenue
FROM Orders_and_Services o
INNER JOIN Mobile_plan mp ON o.PlanID = mp.PlanID
GROUP BY o.CustomerID; 

