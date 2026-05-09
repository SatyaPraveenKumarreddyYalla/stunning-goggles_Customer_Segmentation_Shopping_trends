use project_shopping_trends;
show tables;
select * from shopping_table;
select * from shopping_table;
select * from std;
-- Check null values
SELECT *
FROM shopping_table
WHERE 
	Customer_ID IS NULL
   AND Age IS NULL
   AND Gender IS NULL
   AND Item_Purchased IS NULL
   AND Category IS NULL
   AND Purchase_Amount_USD IS NULL
   AND Location IS NULL
   AND Size IS NULL
   AND Color IS NULL
   AND Season IS NULL
   AND Review_Rating IS NULL
   AND Subscription_Status IS NULL
   AND Payment_Method IS NULL
   AND Shipping_Type IS NULL
   AND Discount_Applied IS NULL
   AND Promo_Code_Used IS NULL
   AND Previous_Purchases IS NULL
   AND Preferred_Payment_Method IS NULL
   AND Frequency_of_Purchases IS NULL;

-- Remove null values
SELECT * FROM shopping_table WHERE 
customer_id IS NOT NULL
AND 
Age IS NOT NULL
   AND Gender IS NOT NULL
   AND Item_Purchased IS NOT NULL
   AND Category IS NOT NULL
   AND Purchase_Amount_USD IS NOT NULL
   AND Location IS NOT NULL
   AND Size IS NOT  NULL
   AND Color IS NOT  NULL
   AND Season IS NOT  NULL
   AND Review_Rating IS NOT  NULL
   AND Subscription_Status IS NOT  NULL
   AND Payment_Method IS NOT  NULL
   AND Shipping_Type IS NOT  NULL
   AND Discount_Applied IS NOT  NULL
   AND Promo_Code_Used IS NOT  NULL
   AND Previous_Purchases IS NOT  NULL
   AND Preferred_Payment_Method IS NOT  NULL
   AND Frequency_of_Purchases IS NOT  NULL;

-- Updation of Null values in column though the case clause
SELECT 
    IFNULL(
        Age, 
        ROUND((SELECT AVG(Age) FROM shopping_table))
    ) AS Age
FROM shopping_table;
SELECT 
    IFNULL(
        Customer_ID, 
        ROUND((SELECT AVG(Customer_ID) FROM shopping_table))
    ) AS Customer_ID
FROM shopping_table;
SELECT *,
	CASE
		WHEN GENDER IS NULL  AND Age >= 40 THEN 'Male'
        WHEN GENDER IS NULL AND Age<=39 THEN 'Female'
        ELSE GENDER
	END AS Gender
FROM shopping_table;

SELECT *, 
    IFNULL(
        Purchase_Amount_USD, 
        ROUND((SELECT AVG(Purchase_Amount_USD) FROM shopping_table))
    ) AS Purchase_Amount_USD
FROM shopping_table;

SELECT *,
	CASE
		WHEN Item_Purchased IS NULL AND Gender = 'Male' Then 'Shirt'
        WHEN Item_Purchased IS NULL AND Gender = 'Female' THEN 'Lipstick'
        ELSE Item_Purchased
	END AS Item_Purchased
FROM shopping_table;

SELECT *,
	CASE
		WHEN Category IS NULL  AND Item_Purchased = 'Shirt' THEN 'Clothing'
        WHEN Category IS NULL AND Item_Purchased = 'Lipstick' THEN 'Makeup'
        ELSE Category
	END AS Category
FROM shopping_table;

SELECT *,CASE 
WHEN Location IS NULL THEN 
            (SELECT Location
             FROM (
                 SELECT Location
                 FROM shopping_table
                 WHERE Location IS NOT NULL
                 GROUP BY Location
                 ORDER BY COUNT(*) DESC
                 LIMIT 1
             ) AS temp)
        ELSE Location
    END AS Location
FROM shopping_table;

SELECT *,CASE 
WHEN Size IS NULL THEN 
            (SELECT Size
             FROM (
                 SELECT Size
                 FROM shopping_table
                 WHERE Size IS NOT NULL
                 GROUP BY Size
                 OrDER BY COUNT(*) DESC
                 LIMIT 1
             ) AS temp)
        ELSE Size
    END AS Size
FROM shopping_table;

SELECT *,CASE 
WHEN Color IS NULL THEN 
            (SELECT Color
             FROM (
                 SELECT Color
                 FROM shopping_table
                 WHERE Color IS NOT NULL
                 GROUP BY Color
                 ORDER BY COUNT(*) DESC
                 LIMIT 1
             ) AS temp)
        ELSE Color
    END AS Color
FROM shopping_table;

SELECT *,CASE 
WHEN Season IS NULL THEN 
            (SELECT Season
             FROM (
                 SELECT Season
                 FROM shopping_table
                 WHERE Season IS NOT NULL
                 GROUP BY Season
                 ORDER BY COUNT(*) DESC
                 LIMIT 1
             ) AS temp)
        ELSE Season
    END AS Season
FROM shopping_table;

SELECT *,CASE 
WHEN Review_Rating IS NULL THEN 
            (SELECT Review_Rating
             FROM (
                 SELECT Review_Rating
                 FROM shopping_table
                 WHERE Review_Rating IS NOT NULL
                 GROUP BY Review_Rating
                 ORDER BY COUNT(*) DESC
                 LIMIT 1
             ) AS temp)
        ELSE Review_Rating
    END AS Review_Rating
FROM shopping_table;
SELECT 
    *,
    COALESCE(
        Shipping_Type,
        (
            SELECT Shipping_Type
            FROM (
                SELECT Shipping_Type
                FROM shopping_table
                WHERE Shipping_Type IS NOT NULL
                GROUP BY Shipping_Type
                ORDER BY COUNT(*) DESC
                LIMIT 1
            ) t
        )
    ) AS Cleaned_Shipping_Type
FROM shopping_table;

-- Customer Gender
SELECT Gender,count(*) Customer_ID
FROM shopping_table
GROUP BY Gender;

-- Customer item Purchased Category in location
SELECT Item_Purchased,Category, Location, COUNT(*) AS total_count
FROM shopping_table
GROUP BY Item_Purchased,Category, Location;

-- Season Wise purcahse amount,review rating,payment method
-- SELECT 
	-- Category,Season,Purchase_Amount_USD,
	-- Payment_Method,Shipping_Type,Review_Rating, Count(*) AS Highest_Season
-- FROM 
	-- shopping_table
-- order  by Category,Season,Purchase_Amount_USD,
-- Payment_Method,Shipping_Type,Review_Rating

SELECT 
    Season,
    COUNT(*) AS Total_Orders,
    SUM(Purchase_Amount_USD) AS Revenue,
    AVG(Review_Rating) AS Avg_Rating
FROM shopping_table
GROUP BY Season
ORDER BY Revenue DESC;
-- Subscription Status over Age Group
SELECT 
    IFNULL(Age, 0) AS Age,
    IFNULL(Subscription_Status, 'Unknown') AS Subscription_Status,
    COUNT(*) AS Total_Customers
FROM shopping_table
GROUP BY Age, Subscription_Status;

-- Which Age Wise total PUrchases
SELECT 
	Age,
    COUNT(*) AS Total_Purchases,
    SUM(Purchase_Amount_USD) AS Total_Revenue
FROM shopping_table
GROUP BY Age
ORDER BY Total_Purchases DESC;

-- Seasonal Purchase  All  Age
SELECT 
    COALESCE(Season, 'Unknown') AS Season,
    COALESCE(Age, 0) AS Age,
    COUNT(*) AS total_orders,
    SUM(Purchase_Amount_USD) AS Revenue
FROM shopping_table
GROUP BY Season, Age
ORDER BY Season, Revenue DESC;

-- Impact of Discount_Applied
SELECT 
    Discount_Applied,
    SUM(Purchase_Amount_USD) AS Revenue_By_Discount
FROM shopping_table
GROUP BY Discount_Applied;
 
 -- PROMO CODEimpact on revenuePOover orders
 SELECT 
    Promo_Code_Used,
    COUNT(*) AS Item_Purchase,
    SUM(Purchase_Amount_USD) AS Revenue
FROM shopping_table
GROUP BY Promo_Code_Used;
Select * FROM shopping_table;
-- Previous Purchase Behavior (Customer Retention)
SELECT 
    Previous_Purchases,
    MAX(Item_Purchased) AS Item_Purchased,
    COUNT(*) AS Total_Count,
    AVG(Purchase_Amount_USD) AS AVG_Purchase_Orders
FROM shopping_table
GROUP BY Previous_Purchases;
 
    

-- JOIN two shoping_table and std table
SELECT
	s.Customer_ID,s.Age,
    s.Gender,s.Item_Purchased,
    s.Category,s.Purchase_Amount_USD,
    s.Location,s.Size,
    s.Color,s.Season,
    s.review_Rating,
    s.subscription_Status,s.Payment_Method,
    s.Shipping_type,s.Discount_Applied,
    s.Promo_Code_Used,s.Previous_Purchases,
    s.Preferred_Payment_Method,s.Frequency_of_Purchases
FROM shopping_table s
INNER JOIN std t
ON s.Customer_ID = t.CustomerID;

-- TOTAL REVENUE BY GENDER
SELECT 
	s.Gender,COUNT(distinct s.Customer_ID) AS TOTAL_Customer,
    SUM(t.PurchaseAmountUSD) AS total_revenue,
    AVG(t.PurchaseAmountUSD) AS avg_purchase
FROM shopping_table s
JOIN std t 
ON s.customer_ID = t.customerID
GROUP BY s.gender
ORDER BY total_revenue DESC;

-- Customer Segmentation
SELECT 
    CASE 
        WHEN s.Shipping_type = 'Standard' THEN 'Normal Spenders'
        WHEN s.Shipping_type = 'Express' THEN 'Highly Spenders'
        ELSE 'Low Spenders'
    END AS customer_segment,
    COUNT(*) AS total_customers,
    SUM(t.PurchaseAmountUSD) AS total_revenue,
    AVG(t.PurchaseAmountUSD) AS avg_spend
FROM shopping_table s
JOIN std t 
ON s.customer_ID = t.customerID
GROUP BY customer_segment
ORDER BY total_revenue DESC;

-- Customer Income VS Spending(Level of Customers)
SELECT 
    sub.*,
    @rank := @rank + 1 AS Payment_Rank
FROM (
    SELECT 
        s.Preferred_Payment_Method,
        COUNT(*) AS Customer_Count,
        AVG(t.PurchaseAmountUSD) AS AVG_Purchase,
        SUM(t.PurchaseAmountUSD) AS TOTAL_Revenue
    FROM shopping_table s
    JOIN std t 
        ON s.Customer_ID = t.CustomerID
    GROUP BY s.Preferred_Payment_Method
    ORDER BY Customer_Count DESC
) sub,
(SELECT @rank := 0) r;

-- Product Category Performance
SELECT
	t.Category,
    COUNT(*) AS Total_Orders,
    SUM(t.PurchaseAmountUSD) AS Revenue,
    AVG(t.PurchaseAmountUSD) AS Avg_Order_Value
FROM std t
GROUP BY t.Category
ORDER BY Revenue DESC;

-- Age Group Analysis
SELECT 
    Age_Group,
    COUNT(*) AS Total_Customers,
    SUM(PurchaseAmountUSD) AS Total_Revenue
FROM (
    SELECT 
        CASE
            WHEN s.Age <= 19 THEN 'YOUNGSTERS'
            WHEN s.Age BETWEEN 20 AND 35 THEN 'ADULTS'
            ELSE 'SENIORS'
        END AS Age_Group,
        t.PurchaseAmountUSD
    FROM shopping_table s
    JOIN std t 
        ON s.Customer_ID = t.CustomerID
) sub
GROUP BY Age_Group
ORDER BY Total_Revenue DESC;
        
        