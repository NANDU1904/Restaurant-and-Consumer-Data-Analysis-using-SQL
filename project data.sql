-- create database RestuarentDB;
use RestuarentDB;
/*CREATE TABLE Consumers
(
    Consumer_ID VARCHAR(20) PRIMARY KEY,
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100),
    Latitude DECIMAL(10,6),
    Longitude DECIMAL(10,6),
    Smoker VARCHAR(20),
    Drink_Level VARCHAR(30),
    Transportation_Method VARCHAR(50),
    Marital_Status VARCHAR(30),
    Children VARCHAR(30),
    Age INT,
    Occupation VARCHAR(50),
    Budget VARCHAR(20)
);
CREATE TABLE Consumer_Preferences
(
    Consumer_ID VARCHAR(20),
    Preferred_Cuisine VARCHAR(100),

    FOREIGN KEY (Consumer_ID)
        REFERENCES Consumers(Consumer_ID)
);
CREATE TABLE Restaurants
(
    Restaurant_ID VARCHAR(20) PRIMARY KEY,
    Name VARCHAR(150),
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100),
    Zip_Code VARCHAR(20),
    Latitude DECIMAL(10,6),
    Longitude DECIMAL(10,6),
    Alcohol_Service VARCHAR(50),
    Smoking_Allowed VARCHAR(50),
    Price VARCHAR(30),
    Franchise VARCHAR(20),
    Area VARCHAR(50),
    Parking VARCHAR(50)
);
CREATE TABLE Restaurant_Cuisines
(
    Restaurant_ID VARCHAR(20),
    Cuisine VARCHAR(100),

    FOREIGN KEY (Restaurant_ID)
        REFERENCES Restaurants(Restaurant_ID)
);

CREATE TABLE Ratings
(
    Consumer_ID VARCHAR(20),
    Restaurant_ID VARCHAR(20),
    Overall_Rating INT,
    Food_Rating INT,
    Service_Rating INT,

    FOREIGN KEY (Consumer_ID)
        REFERENCES Consumers(Consumer_ID),

    FOREIGN KEY (Restaurant_ID)
        REFERENCES Restaurants(Restaurant_ID)
);

show tables;
-- importing comsumers.csv data
LOAD DATA LOCAL INFILE "C:\Users\USER\Downloads\consumers.csv"
INTO TABLE Consumers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
 
LOAD DATA LOCAL INFILE "C:\Users\USER\Downloads\consumer_preferences.csv"
INTO TABLE Consumer_preferences
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE "C:\Users\USER\Downloads\.restaurantscsv"
INTO TABLE Restaurants
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE "C:\Users\USER\Downloads\restaurant_cuisines.csv"
INTO TABLE Restaurant_cuisines
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE "C:\Users\USER\Downloads\ratings.csv"
INTO TABLE Ratings
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

/* ===========================================================================*/

-- List all details of consumers who live in the city of 'Cuernavaca'.
SELECT *
FROM Consumers
WHERE City = 'Cuernavaca';
/* Observation & Insights
The query identifies 22 consumers who live in Cuernavaca.
The consumers have varied ages, occupations, drinking habits, and transportation methods, showing a diverse customer base.
Both Students and Employed consumers are present, with Medium budget appearing frequently.
This information can help restaurants understand the local customer profile and design suitable menus and pricing.*/

-- Find the Consumer_ID, Age, and Occupation of all consumers who are 'Students' AND are 'Smokers'.
SELECT Consumer_ID, Age, Occupation
FROM Consumers
WHERE Occupation = 'Student' AND Smoker = 'Yes';

/*Observation & Insights
The query identifies consumers who are both Students and Smokers.
The result contains 23 consumers meeting both conditions.
Most of the identified students are in their early 20s, although some older values are also present.
This data can help understand the lifestyle characteristics of student consumers and support targeted restaurant marketing.*/

-- List the Name, City, Alcohol_Service, and Price of all restaurants that serve 'Wine & Beer' and have a 'Medium' price level.
SELECT Name, City, Alcohol_Service, Price
FROM Restaurants
WHERE Alcohol_Service = 'Wine & Beer' AND Price = 'Medium';
/*Observation & Insights
The query identifies restaurants that provide Wine & Beer alcohol service and have a Medium price level.
It filters restaurants based on two conditions simultaneously using the AND operator.
The results help identify mid-priced restaurants offering alcoholic beverages.
This information can be useful for understanding restaurant options for customers seeking a moderately priced dining experience with alcohol service.*/


-- Find the names and cities of all restaurants that are part of a 'Franchise'.
SELECT Name, City
FROM Restaurants WHERE Franchise = 'Yes';
/* Observation & Insights
The query identifies restaurants that are part of a franchise.
Franchise restaurants are spread across multiple cities, including Cuernavaca, Ciudad Victoria, and San Luis Potosi.
A franchise means a restaurant operates under an established brand/business model owned by a larger company or brand, 
rather than being an independent restaurant.*/

-- Show the Consumer_ID, Restaurant_ID, and Overall_Rating for all ratings where the Overall_Rating was 'Highly Satisfactory' 
-- (which corresponds to a value of 2, according to the data dictionary).
SELECT Consumer_ID, Restaurant_ID, Overall_Rating
FROM Ratings WHERE Overall_Rating = 2;

/*Observation & Insights
The query returns 486 ratings with an Overall_Rating of 2 (Highly Satisfactory).
This indicates a significant number of positive restaurant experiences among the recorded ratings.
The Consumer_ID and Restaurant_ID columns allow us to identify which consumers gave highly satisfactory ratings to which restaurants.*/

/*=======================================================================================*/
-- List the names and cities of all restaurants that have an Overall_Rating of 2 (Highly Satisfactory) from at least one consumer.
SELECT DISTINCT r.Name, r.City FROM Restaurants r JOIN Ratings rt
ON r.Restaurant_ID = rt.Restaurant_ID WHERE rt.Overall_Rating = 2;

/*The query identifies 115 unique restaurants that have received an Overall_Rating of 2 (Highly Satisfactory) from at least one consumer.
These highly rated restaurants are spread across cities such as San Luis Potosi, Ciudad Victoria, and Cuernavaca.
Using DISTINCT ensures each restaurant appears only once, even if multiple consumers gave it a rating of 2.*/

-- Find the Consumer_ID and Age of consumers who have rated restaurants located in 'San Luis Potosi'.
SELECT DISTINCT c.Consumer_ID, c.Age FROM Consumers c JOIN Ratings rt
ON c.Consumer_ID = rt.Consumer_ID JOIN Restaurants r ON rt.Restaurant_ID = r.Restaurant_ID
WHERE r.City = 'San Luis Potosi';

/* Observation & Insights
The query identifies consumers who have rated restaurants located in San Luis Potosi.
The results include consumers of different ages, ranging from young adults to older consumers, showing a diverse customer group.
DISTINCT ensures that each consumer appears only once, even if they rated multiple restaurants in San Luis Potosi.*/

-- List the names of restaurants that serve 'Mexican' cuisine and have been rated by consumer 'U1001'.
SELECT DISTINCT r.Name FROM Restaurants r JOIN Restaurant_Cuisines rc
ON r.Restaurant_ID = rc.Restaurant_ID JOIN Ratings rt ON r.Restaurant_ID = rt.Restaurant_ID
WHERE rc.Cuisine = 'Mexican' AND rt.Consumer_ID = 'U1001';

/*Observation & Insights
The query identifies 2 unique restaurants that serve Mexican cuisine and have been rated by consumer U1001.
The restaurants are Puesto De Tacos and El Rincon De San Francisco.
This helps identify Mexican restaurants that match a specific consumer's dining activity, which can be useful for personalized recommendations.*/

-- Find all details of consumers who prefer 'American' cuisine AND have a 'Medium' budget.
SELECT DISTINCT c.* FROM Consumers c JOIN Consumer_Preferences cp
ON c.Consumer_ID = cp.Consumer_ID WHERE cp.Preferred_Cuisine = 'American'
AND c.Budget = 'Medium';
/*Observation & Insights
The query identifies 8 consumers who prefer American cuisine and have a Medium budget.
Most of the identified consumers are Students, with ages mainly between 20–23 years.
This indicates a potential customer segment for moderately priced American cuisine, especially among younger consumers.*/

-- List restaurants (Name, City) that have received a Food_Rating lower than the average Food_Rating across all rated restaurants.
SELECT DISTINCT r.Name, r.City FROM Restaurants r JOIN Ratings rt
ON r.Restaurant_ID = rt.Restaurant_ID WHERE rt.Food_Rating <
(
    SELECT AVG(Food_Rating)
    FROM Ratings);
/* Observation & Insights
The query identifies restaurants whose Food_Rating is below the overall average Food_Rating across all ratings.
The results include several restaurants in Ciudad Victoria, such as Vips, Little Caesars, Carnitas Mata, and Tacos Abi.
These restaurants have below-average food ratings, which may indicate areas where food quality or customer satisfaction could be improved.*/

-- Find consumers (Consumer_ID, Age, Occupation) who have rated at least one restaurant but have NOT rated any restaurant that serves 'Italian' cuisine.
SELECT DISTINCT c.Consumer_ID, c.Age, c.Occupation FROM Consumers c
JOIN Ratings rt ON c.Consumer_ID = rt.Consumer_ID
WHERE NOT EXISTS
( SELECT 1 FROM Ratings rt2 JOIN Restaurant_Cuisines rc ON rt2.Restaurant_ID = rc.Restaurant_ID
WHERE rt2.Consumer_ID = c.Consumer_ID AND rc.Cuisine = 'Italian' );
/* Observation & Insights
The query identifies consumers who have rated at least one restaurant but have never rated an Italian restaurant.
The results include consumers from different age groups and occupations, with Students being common among the displayed records.
This analysis can help identify consumer segments that have not explored Italian cuisine, which could be useful for targeted recommendations or promotions.*/

-- List restaurants (Name) that have received ratings from consumers older than 30.
SELECT DISTINCT r.Name FROM Restaurants r JOIN Ratings rt
ON r.Restaurant_ID = rt.Restaurant_ID JOIN Consumers c
ON rt.Consumer_ID = c.Consumer_ID WHERE c.Age > 30;
/* Observation & Insights
The query identifies restaurants that have received ratings from consumers older than 30 years.
The results include restaurants such as Restaurante Marisco Sam, La Virreina, La Parroquia, and Puesto De Tacos.
This helps identify restaurants that attract older customers, which can be useful for understanding customer demographics and targeting specific age groups.*/

-- Find the Consumer_ID and Occupation of consumers whose preferred cuisine is 'Mexican' and who have given an Overall_Rating of 0 to at least one restaurant (any restaurant).
SELECT DISTINCT c.Consumer_ID, c.Occupation FROM Consumers c
JOIN Consumer_Preferences cp ON c.Consumer_ID = cp.Consumer_ID
JOIN Ratings rt ON c.Consumer_ID = rt.Consumer_ID
WHERE cp.Preferred_Cuisine = 'Mexican' AND rt.Overall_Rating = 0;
/*Observation & Insights
The query identifies consumers who prefer Mexican cuisine and have given an Overall_Rating of 0.
The result shows that most of these consumers are Students, with at least one Unemployed consumer.
This can help identify customer segments with low restaurant satisfaction and support improvements or targeted offers for Mexican cuisine.*/

-- List the names and cities of restaurants that serve 'Pizzeria' cuisine and are located in a city where at least one 'Student' consumer lives.
SELECT DISTINCT r.Name, r.City FROM Restaurants r JOIN Restaurant_Cuisines rc
ON r.Restaurant_ID = rc.Restaurant_ID WHERE rc.Cuisine = 'Pizzeria'
AND r.City IN
  (   SELECT City
      FROM Consumers
      WHERE Occupation = 'Student' );
/*Observation & Insights
The query identifies Pizzeria restaurants located in cities where Students live.
It uses a subquery to first find the cities associated with student consumers, then matches those cities with restaurant locations.
This can help identify Pizzeria options available in student-populated areas, useful for targeted promotions and recommendations.*/

-- Find consumers (Consumer_ID, Age) who are 'Social Drinkers' and have rated a restaurant that has 'No' parking.
SELECT DISTINCT c.Consumer_ID, c.Age FROM Consumers c
JOIN Ratings rt ON c.Consumer_ID = rt.Consumer_ID
JOIN Restaurants r ON rt.Restaurant_ID = r.Restaurant_ID
WHERE c.Drink_Level = 'Social Drinker' AND r.Parking = 'No';
/* Observation & Insights
The query looks for Social Drinkers who have rated restaurants where parking is not available.
The result returned 0 records, meaning no consumer satisfies both conditions in the available data.
Therefore, there is no matching consumer segment identified for this specific combination of drinking habit and restaurant parking availability.*/
/*============================================================================*/
-- List Consumer_IDs and the count of restaurants they've rated, but only for consumers who are 'Students'. Show only students who have rated more than 2 restaurants.
SELECT c.Consumer_ID,COUNT(DISTINCT rt.Restaurant_ID) AS Restaurant_Count
FROM Consumers c
JOIN Ratings rt ON c.Consumer_ID = rt.Consumer_ID
WHERE c.Occupation = 'Student'
GROUP BY c.Consumer_ID
HAVING COUNT(DISTINCT rt.Restaurant_ID) > 2;
/*Observation & Insights
The query identifies Students who have rated more than 2 different restaurants.
The results show that students have rated between 3 and 13 restaurants, with some highly active reviewers such as U1003 and U1016, who rated 13 restaurants each.
This indicates that some student consumers are frequent restaurant reviewers, making them useful for analyzing customer preferences and rating behavior.*/

-- We want to categorize consumers by an 'Engagement_Score' which is their Age divided by 10 (integer division). List the Consumer_ID, Age, and this calculated Engagement_Score, but only for consumers whose Engagement_Score would be exactly 2 and who use 'Public' transportation.
SELECT Consumer_ID,Age,Age / 10 AS Engagement_Score
FROM Consumers
WHERE Age / 10 = 2 AND Transportation_Method = 'Public';
/*Observation & Insights
The query identifies 6 consumers aged 20 who use Public transportation.
All 6 consumers have an Engagement Score of 2, calculated using Age / 10.
This shows a specific group of young consumers relying on public transportation, which can be useful for location-based restaurant recommendations.*/

  
-- For each restaurant, calculate its average Overall_Rating. Then, list the restaurant Name, City, and its calculated average Overall_Rating, but only for restaurants located in 'Cuernavaca' AND whose calculated average Overall_Rating is greater than 1.0.
SELECT r.Name,r.City,AVG(CAST(rt.Overall_Rating AS DECIMAL(10,2))) AS Average_Overall_Rating
FROM Restaurants r
JOIN Ratings rt ON r.Restaurant_ID = rt.Restaurant_ID
WHERE r.City = 'Cuernavaca' 
GROUP BY r.Name,r.City HAVING AVG(rt.Overall_Rating) > 1.0;
/*Observation & Insights
The query calculates the average Overall_Rating for each restaurant in Cuernavaca and includes restaurants with an average rating greater than 1.0.
Restaurant Las Mañanitas has the highest average rating shown (2.00), while Restaurant Los Pinos has the lowest (1.25).
This comparison helps identify better-performing restaurants in Cuernavaca based on their average customer ratings.*/

-- Find consumers (Consumer_ID, Age) who are 'Married' and whose Food_Rating for any restaurant is equal to their Service_Rating for that same restaurant, but only consider ratings where the Overall_Rating was 2.
SELECT DISTINCT c.Consumer_ID,c.Age
FROM Consumers c
JOIN Ratings rt ON c.Consumer_ID = rt.Consumer_ID
WHERE c.Marital_Status = 'Married' AND rt.Food_Rating = rt.Service_Rating AND rt.Overall_Rating = 2;
/* Observation & Insights
The query identifies 9 married consumers whose Food_Rating equals their Service_Rating and whose Overall_Rating is 2 (Highly Satisfactory).
The consumers have ages ranging from 22 to 60, showing a mix of younger and older married customers.
This indicates that these consumers gave equal ratings for food and service while reporting an overall highly satisfactory experience.*/

  
-- List Consumer_ID, Age, and the Name of any restaurant they rated, but only for consumers who are 'Employed' and have given a Food_Rating of 0 to at least one restaurant located in 'Ciudad Victoria'.
SELECT DISTINCT c.Consumer_ID,c.Age,r.Name
FROM Consumers c
JOIN Ratings rt ON c.Consumer_ID = rt.Consumer_ID
JOIN Restaurants r ON rt.Restaurant_ID = r.Restaurant_ID
WHERE c.Occupation = 'Employed' AND rt.Food_Rating = 0 AND r.City = 'Ciudad Victoria';
/* Observation & Insights
The query identifies employed consumers aged 23 who gave a Food_Rating of 0 to restaurants in Ciudad Victoria.
Consumer U1103 rated two restaurants: Tacos Abi and Taqueria El Amigo.
This indicates that these restaurants received low food ratings from an employed consumer, highlighting a possible area for food-quality improvement.*/
/*=======================================================================================*/
-- Using a CTE, find all consumers who live in 'San Luis Potosi'. Then, list their Consumer_ID, Age, and the Name of any Mexican restaurant they have rated with an Overall_Rating of 2.
WITH SanLuisConsumers AS
(SELECT Consumer_ID,Age
    FROM Consumers
    WHERE City = 'San Luis Potosi')
SELECT slc.Consumer_ID,slc.Age,r.Name
FROM SanLuisConsumers slc
JOIN Ratings rt ON slc.Consumer_ID = rt.Consumer_ID
JOIN Restaurants r ON rt.Restaurant_ID = r.Restaurant_ID
JOIN Restaurant_Cuisines rc ON r.Restaurant_ID = rc.Restaurant_ID
WHERE rc.Cuisine = 'Mexican' AND rt.Overall_Rating = 2;
/* Observation & Insights
The query identifies consumers from San Luis Potosi who rated Mexican cuisine restaurants with an Overall_Rating of 2 (Highly Satisfactory).
The results show multiple consumers, with ages ranging from 21 to 82, who rated restaurants such as Gordas De Morales and Cabana Huasteca.
This helps identify Mexican restaurants that receive highly satisfactory ratings from local consumers, useful for restaurant recommendations.*/

-- For each Occupation, find the average age of consumers. Only consider consumers who have made at least one rating. (Use a derived table to get consumers who have rated).
SELECT c.Occupation,AVG(c.Age) AS Average_Age
FROM Consumers c
JOIN
(
    SELECT DISTINCT Consumer_ID
    FROM Ratings
) rated
    ON c.Consumer_ID = rated.Consumer_ID
GROUP BY c.Occupation;
/* Observation & Insights
The query calculates the average age of consumers who have rated at least one restaurant, grouped by occupation.
Unemployed consumers have the lowest average age (21.5 years), while Employed consumers have the highest (37.56 years).
Students have an average age of 25.13 years, showing that restaurant engagement varies across different occupation groups.*/

-- Using a CTE to get all ratings for restaurants in 'Cuernavaca', rank these ratings within each restaurant based on Overall_Rating (highest first). Display Restaurant_ID, Consumer_ID, Overall_Rating, and the RatingRank.
WITH CuernavacaRatings AS
(
    SELECT rt.Restaurant_ID,rt.Consumer_ID,rt.Overall_Rating
    FROM Ratings rt
    JOIN Restaurants r ON rt.Restaurant_ID = r.Restaurant_ID
    WHERE r.City = 'Cuernavaca'
)
SELECT Restaurant_ID,Consumer_ID,Overall_Rating,
    RANK() OVER
    (
        PARTITION BY Restaurant_ID
        ORDER BY Overall_Rating DESC
    ) AS RatingRank
FROM CuernavacaRatings;
/* Observation & Insights
The query ranks consumers based on their Overall_Rating for each restaurant in Cuernavaca, using the RANK() window function.
For each restaurant, a higher rating gets a better rank (Rank 1); equal ratings receive the same rank.
This helps identify the top-rated consumers for each restaurant and compare rating performance within individual restaurants.*/

-- For each rating, show the Consumer_ID, Restaurant_ID, Overall_Rating, and also display the average Overall_Rating given by that specific consumer across all their ratings.
SELECT Consumer_ID,Restaurant_ID,Overall_Rating,
    AVG(Overall_Rating) OVER
    (
        PARTITION BY Consumer_ID
    ) AS Consumer_Average_Rating

FROM Ratings;
/* Observation & Insights
The query calculates the average Overall_Rating for each consumer using the AVG() window function with PARTITION BY Consumer_ID.
For example, U1001 has an average rating of 1.1111 across the restaurants they rated, while U1002 has an average of 1.4000.
This helps compare individual consumer rating patterns and understand whether a consumer generally gives higher or lower ratings.*/

-- Using a CTE, identify students who have a 'Low' budget. Then, for each of these students, list their top 3 most preferred cuisines based on the order they appear in the Consumer_Preferences table (assuming no explicit preference order, use Consumer_ID, Preferred_Cuisine to define order for ROW_NUMBER).
WITH LowBudgetStudents AS
(
    SELECT Consumer_ID
    FROM Consumers
    WHERE Occupation = 'Student'
      AND Budget = 'Low'
),
RankedPreferences AS
(
    SELECT
        cp.Consumer_ID,
        cp.Preferred_Cuisine,

        ROW_NUMBER() OVER
        (
            PARTITION BY cp.Consumer_ID
            ORDER BY cp.Consumer_ID,
                     cp.Preferred_Cuisine
        ) AS PreferenceRank

    FROM Consumer_Preferences cp
    JOIN LowBudgetStudents lbs
        ON cp.Consumer_ID = lbs.Consumer_ID
)
SELECT
    Consumer_ID,
    Preferred_Cuisine,
    PreferenceRank
FROM RankedPreferences
WHERE PreferenceRank <= 3;
/* Observation & Insights
The query identifies Low-budget Students and ranks their preferred cuisines using ROW_NUMBER().
Each student's preferences are ranked, and the query displays their top 3 preferred cuisines.
For example, U1008 prefers American, Cafeteria, and Coffee Shop, ranked 1, 2, and 3 respectively.*/

-- Consider all ratings made by 'Consumer_ID' = 'U1008'. For each rating, show the Restaurant_ID, Overall_Rating, and the Overall_Rating of the next restaurant they rated (if any), ordered by Restaurant_ID (as a proxy for time if rating time isn't available). Use a derived table to filter for the consumer's ratings first.
SELECT
    Restaurant_ID,
    Overall_Rating,

    LEAD(Overall_Rating) OVER
    (
        ORDER BY Restaurant_ID
    ) AS Next_Overall_Rating

FROM
(
    SELECT
        Restaurant_ID,
        Overall_Rating
    FROM Ratings
    WHERE Consumer_ID = 'U1008'
) AS ConsumerRatings
ORDER BY Restaurant_ID;
/* Observation & Insights
The query uses LEAD() to show the next Overall_Rating for each restaurant rated by consumer U1008, ordered by Restaurant_ID.
For example, restaurant 132851 has a rating of 1, and the next restaurant has a rating of 2.
The NULL in the last row is expected because there is no next rating after the final restaurant.*/

-- Create a VIEW named HighlyRatedMexicanRestaurants that shows the Restaurant_ID, Name, and City of all Mexican restaurants that have an average Overall_Rating greater than 1.5.
CREATE VIEW HighlyRatedMexicanRestaurants
AS
SELECT
    r.Restaurant_ID,
    r.Name,
    r.City
FROM Restaurants r
JOIN Restaurant_Cuisines rc
    ON r.Restaurant_ID = rc.Restaurant_ID
JOIN Ratings rt
    ON r.Restaurant_ID = rt.Restaurant_ID
WHERE rc.Cuisine = 'Mexican'
GROUP BY
    r.Restaurant_ID,
    r.Name,
    r.City
HAVING AVG(rt.Overall_Rating) > 1.5;
/* Observation & Insight
The view stores a reusable list of highly rated Mexican restaurants.
The condition HAVING AVG(rt.Overall_Rating) > 1.5 ensures only restaurants with above-1.5 average ratings are included.
This view can be used later without rewriting the joins and filtering logic./*/

/* First, ensure the HighlyRatedMexicanRestaurants view from Q7 exists. Then, using a CTE to find 
consumers who prefer 'Mexican' cuisine, list those consumers (Consumer_ID) who have not rated any 
restaurant listed in the HighlyRatedMexicanRestaurants view.*/
WITH MexicanConsumers AS
(
    SELECT DISTINCT Consumer_ID
    FROM Consumer_Preferences
    WHERE Preferred_Cuisine = 'Mexican'
)
SELECT
    mc.Consumer_ID
FROM MexicanConsumers mc
WHERE NOT EXISTS
(
    SELECT 1
    FROM Ratings rt
    JOIN HighlyRatedMexicanRestaurants hr
        ON rt.Restaurant_ID = hr.Restaurant_ID
    WHERE rt.Consumer_ID = mc.Consumer_ID
);
/* Observation & Insights
The query identifies Mexican-cuisine consumers who have NOT rated any highly rated Mexican restaurant from the HighlyRatedMexicanRestaurants view.
The result contains multiple consumers, such as U1002, U1006, U1008, and U1009, who prefer Mexican cuisine but haven't rated a restaurant meeting the view's average rating > 1.5 condition.
This group could be targeted with recommendations or promotions for highly rated Mexican restaurants.*/


-- Create a stored procedure GetRestaurantRatingsAboveThreshold that accepts a Restaurant_ID and a minimum Overall_Rating as input. It should return the Consumer_ID, Overall_Rating, Food_Rating, and Service_Rating for that restaurant where the Overall_Rating meets or exceeds the threshold.
DELIMITER //

CREATE PROCEDURE GetRestaurantRatingsAboveThreshold(
    IN p_Restaurant_ID VARCHAR(20),
    IN p_Minimum_Rating INT
)
BEGIN
    SELECT
        Consumer_ID,
        Overall_Rating,
        Food_Rating,
        Service_Rating
    FROM Ratings
    WHERE Ratings.Restaurant_ID = p_Restaurant_ID
      AND Ratings.Overall_Rating >= p_Minimum_Rating;
END //

DELIMITER ;
/* Observation & Insights
The procedure GetRestaurantRatingsAboveThreshold accepts a Restaurant_ID and a minimum rating as input parameters.
It returns consumers' Overall_Rating, Food_Rating, and Service_Rating only when the restaurant's Overall_Rating is greater than or equal to the specified minimum rating.
This procedure makes it easy to reuse the same rating analysis for different restaurants and rating thresholds without rewriting the query.*/

-- Identify the top 2 highest-rated (by Overall_Rating) restaurants for each cuisine type. If there are ties in rating, include all tied restaurants. Display Cuisine, Restaurant_Name, City, and Overall_Rating.
WITH RestaurantAverage AS
(
    SELECT
        rc.Cuisine,
        r.Restaurant_ID,
        r.Name AS Restaurant_Name,
        r.City,
        AVG(CAST(rt.Overall_Rating AS DECIMAL(10,2)))
            AS Overall_Rating

    FROM Restaurant_Cuisines rc

    JOIN Restaurants r
        ON rc.Restaurant_ID = r.Restaurant_ID

    JOIN Ratings rt
        ON r.Restaurant_ID = rt.Restaurant_ID

    GROUP BY
        rc.Cuisine,
        r.Restaurant_ID,
        r.Name,
        r.City
),
RankedRestaurants AS
(
    SELECT
        *,
        DENSE_RANK() OVER
        (
            PARTITION BY Cuisine
            ORDER BY Overall_Rating DESC
        ) AS RatingRank
    FROM RestaurantAverage
)
SELECT
    Cuisine,
    Restaurant_Name,
    City,
    Overall_Rating
FROM RankedRestaurants
WHERE RatingRank <= 2
ORDER BY Cuisine, RatingRank;
/* Observation & Insights
The query calculates the average Overall_Rating for each restaurant within each cuisine and ranks restaurants using DENSE_RANK().
It selects the top 2 restaurants for each cuisine based on their average Overall_Rating.
This helps identify the best-performing restaurants within each cuisine, making it useful for restaurant recommendations and performance comparison.*/

-- First, create a VIEW named ConsumerAverageRatings that lists Consumer_ID and their average Overall_Rating. Then, using this view and a CTE, find the top 5 consumers by their average overall rating. For these top 5 consumers, list their Consumer_ID, their average rating, and the number of 'Mexican' restaurants they have rated.
CREATE VIEW ConsumerAverageRatings
AS
SELECT
    Consumer_ID,
    AVG(CAST(Overall_Rating AS DECIMAL(10,2)))
        AS Average_Overall_Rating
FROM Ratings
GROUP BY Consumer_ID;
WITH ConsumerAverageRatings AS
(
    SELECT
        Consumer_ID,
        AVG(Overall_Rating) AS Average_Overall_Rating
    FROM Ratings
    GROUP BY Consumer_ID
),
TopConsumers AS
(
    SELECT
        Consumer_ID,
        Average_Overall_Rating
    FROM ConsumerAverageRatings
    ORDER BY Average_Overall_Rating DESC
    LIMIT 5
)
SELECT
    tc.Consumer_ID,
    tc.Average_Overall_Rating
FROM TopConsumers tc
ORDER BY tc.Average_Overall_Rating DESC;
/* Observation & Insights
The query calculates the average Overall_Rating given by each consumer and then identifies the top 5 consumers with the highest average ratings.
ConsumerAverageRatings is created as a VIEW, making the average rating data reusable.
The results are ordered from highest to lowest average rating, helping identify consumers who consistently give higher ratings.*/


/* Create a stored procedure named GetConsumerSegmentAndRestaurantPerformance that accepts a Consumer_ID as input.
 The procedure should:
1. Determine the consumer's "Spending Segment" based on their Budget:
   -- 'Low' -> 'Budget Conscious'
   -- 'Medium' -> 'Moderate Spender'
   -- 'High' -> 'Premium Spender'
   -- NULL or other -> 'Unknown Budget'
2. For all restaurants rated by this consumer:
-- List the Restaurant_Name.
-- The Overall_Rating given by this consumer.
-- The average Overall_Rating this restaurant has received from all consumers (not just the input consumer).
-- A "Performance_Flag" indicating if the input consumer's rating for that restaurant is 'Above Average', 'At Average', or 'Below Average' compared to the restaurant's overall average rating.
-- Rank these restaurants for the input consumer based on the Overall_Rating they gave (highest rating = rank 1). */
 
 DROP PROCEDURE IF EXISTS GetConsumerSegmentAndRestaurantPerformance;

DELIMITER //

CREATE PROCEDURE GetConsumerSegmentAndRestaurantPerformance(
    IN p_Consumer_ID VARCHAR(20)
)
BEGIN

    /* =====================================================
       PART 1: FIND CONSUMER BUDGET AND SPENDING SEGMENT
       ===================================================== */

    SELECT
        c.Consumer_ID,
        c.Budget,

        CASE
            WHEN c.Budget = 'Low'
                THEN 'Budget Conscious'

            WHEN c.Budget = 'Medium'
                THEN 'Moderate Spender'

            WHEN c.Budget = 'High'
                THEN 'Premium Spender'

            ELSE 'Unknown Budget'
        END AS Spending_Segment

    FROM Consumers c
    WHERE c.Consumer_ID = p_Consumer_ID;


    /* =====================================================
       PART 2: RESTAURANT PERFORMANCE
       ===================================================== */

    WITH RestaurantAverage AS
    (
        SELECT
            Restaurant_ID,
            AVG(Overall_Rating) AS Average_Restaurant_Rating
        FROM Ratings
        GROUP BY Restaurant_ID
    ),

    ConsumerRatings AS
    (
        SELECT
            r.Consumer_ID,
            r.Restaurant_ID,
            r.Overall_Rating,
            r.Food_Rating,
            r.Service_Rating,
            ra.Average_Restaurant_Rating

        FROM Ratings r

        INNER JOIN RestaurantAverage ra
            ON r.Restaurant_ID = ra.Restaurant_ID

        WHERE r.Consumer_ID = p_Consumer_ID
    ),

    RankedRestaurants AS
    (
        SELECT
            Consumer_ID,
            Restaurant_ID,
            Overall_Rating,
            Average_Restaurant_Rating,

            CASE
                WHEN Overall_Rating > Average_Restaurant_Rating
                    THEN 'Above Average'

                WHEN Overall_Rating = Average_Restaurant_Rating
                    THEN 'At Average'

                ELSE 'Below Average'
            END AS Performance_Flag,

            RANK() OVER
            (
                ORDER BY Overall_Rating DESC
            ) AS Restaurant_Rank

        FROM ConsumerRatings
    )

    SELECT
        rr.Consumer_ID,
        res.Name AS Restaurant_Name,
        rr.Overall_Rating,
        ROUND(rr.Average_Restaurant_Rating, 2)
            AS Average_Overall_Rating,
        rr.Performance_Flag,
        rr.Restaurant_Rank

    FROM RankedRestaurants rr

    INNER JOIN Restaurants res
        ON rr.Restaurant_ID = res.Restaurant_ID

    ORDER BY rr.Restaurant_Rank;

END //

DELIMITER ;

CALL GetConsumerSegmentAndRestaurantPerformance('U1001');
/* Observation & Insights
The procedure first classifies the consumer into a Spending Segment based on their budget: Low → Budget Conscious, Medium → Moderate Spender, High → Premium Spender.
It then compares the consumer's restaurant rating with the restaurant's average rating and labels it as Above Average, At Average, or Below Average.
The RANK() function ranks the restaurants based on the consumer's Overall_Rating, helping identify the consumer's highest-rated restaurants.*/
