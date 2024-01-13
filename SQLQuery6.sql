SELECT * FROM orders;
SELECT * FROM customer;
SELECT * FROM salesman;

--1
CREATE VIEW EmpDetail AS
SELECT s.name AS salesman_name, s.commission
FROM salesman s
WHERE s.commission BETWEEN 0.11 AND 0.13 AND RIGHT(s.name, 1) = 'N';

SELECT * FROM EmpDetail;

--2
CREATE NONCLUSTERED INDEX index_city ON customer (city ASC, grade DESC);

SELECT * FROM sys.indexes WHERE name = 'index_city';

--3
CREATE VIEW CustomerGradeCount AS
SELECT grade, COUNT(*) AS customer_count
FROM customer
GROUP BY grade;

SELECT * FROM CustomerGradeCount;

--4
CREATE VIEW TopSalesmanForHighestOrder AS
WITH MaxOrderPerDay AS (
    SELECT ord_date, MAX(purch_amt) AS highest_order_amount
    FROM orders
    GROUP BY ord_date
)
SELECT o.ord_date, c.salesman_id, s.name AS salesman_name, o.purch_amt AS highest_order_amount
FROM orders o
INNER JOIN customer c ON o.customer_id = c.customer_id
INNER JOIN salesman s ON c.salesman_id = s.salesman_id
INNER JOIN MaxOrderPerDay m ON o.ord_date = m.ord_date AND o.purch_amt = m.highest_order_amount;

SELECT * FROM TopSalesmanForHighestOrder;

--5
CREATE VIEW HighCommissionSalesmenInRome AS
SELECT s.salesman_id, s.name AS salesman_name, s.commission, s.city
FROM salesman s
WHERE s.city = 'Rome' AND s.commission > 0.12;

SELECT * FROM HighCommissionSalesmenInRome;

--6
CREATE CLUSTERED INDEX index_ID ON customer (customer_id);

SELECT * FROM sys.indexes WHERE name = 'index_ID';
