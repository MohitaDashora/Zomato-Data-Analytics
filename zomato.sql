#----------------------ZOMATO_ANALYTICS_SQL_VERIFICATIONS------------------------

use zomato;

select * from main;
select count(*) from main;

#1.----------no of cities------------------
SELECT COUNT(DISTINCT City) AS NumberOfCities
FROM main;

#2.-------Total Number of Countries------------
SELECT COUNT(DISTINCT CountryName) AS NumberOfCountries
from main
JOIN country ON CountryCode = CountryCode;

#3.--------------no of orders-----------------
SELECT COUNT(RestaurantID) AS TotalOrders
FROM main;

#4.-------------no of cusines---------------
SELECT COUNT(DISTINCT Cuisines) AS TotalCuisines
FROM main;

#5.---------Number of Restaurants by City and Country-----

SELECT 
    CountryName,
    City,
    COUNT(*) AS NumberOfRestaurants
FROM main 
JOIN country  ON CountryCode = CountryID
GROUP BY CountryName, City
ORDER BY NumberOfRestaurants DESC;

#6.--------Restaurants Opened by Year, Quarter, and Month-----------
SELECT 
    `Year Opening` AS Year,
    QUARTER(STR_TO_DATE(CONCAT(`Year Opening`, '-', `Month Opening`, '-01'), '%Y-%m-%d')) AS Quarter,
    `Month Opening` AS Month,
    COUNT(*) AS NumberOfOpenings
FROM main
GROUP BY Year, Quarter, Month
ORDER BY Year, Quarter, Month;

#6.-----------Count of Restaurants by Average Ratings-----------------
SELECT 
    FLOOR(Rating) AS RatingBucket,
    COUNT(*) AS RestaurantCount
FROM main
GROUP BY RatingBucket
ORDER BY RatingBucket;


#7.-----------------no of table bookings--------------------
SELECT 
  Has_Table_booking,
  COUNT(*) * 100.0 / (SELECT COUNT(*) FROM main) AS Percentage
FROM main
GROUP BY Has_Table_booking;


#8.-----------% of Restaurants with Online Delivery------------
SELECT 
  Has_Online_delivery,
  COUNT(*) * 100.0 / (SELECT COUNT(*) FROM main) AS Percentage
FROM main
GROUP BY Has_Online_delivery;

#9.------------Top Cuisines by Count---------------
SELECT 
  Cuisines,
  COUNT(*) AS CuisineCount
FROM main
GROUP BY Cuisines
ORDER BY CuisineCount DESC
LIMIT 10;

#10.--------------Average Rating by City--------------------
SELECT 
  City,
  AVG(Rating) AS AvgRating
FROM main
GROUP BY City
ORDER BY AvgRating DESC;
