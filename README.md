# 🍽️ Restaurant Database Analysis Using SQL

## 📌 Project Overview

This project focuses on designing and analyzing a **Restaurant Database** using SQL and MySQL.

The project stores information about consumers, restaurants, cuisines, consumer preferences, and restaurant ratings. SQL queries are then used to analyze customer behavior, restaurant performance, cuisine preferences, ratings, and spending patterns.

The project demonstrates an end-to-end SQL workflow:

**Database Creation → Table Creation → Data Import → Data Retrieval → Filtering → Joins → Subqueries → Aggregation → CTEs → Window Functions → Views → Stored Procedures**

---

## 🎯 Objectives

- Create a relational restaurant database using MySQL.
- Store consumer and restaurant information in structured tables.
- Import data from CSV files into database tables.
- Analyze consumer demographics and preferences.
- Analyze restaurant ratings and performance.
- Identify customer segments based on budget and preferences.
- Use advanced SQL concepts for data analysis.
- Create reusable SQL views and stored procedures.
- Generate meaningful business insights from restaurant data.

---

## 🗄️ Database Structure

The database used in this project is:

**RestuarentDB**

The project contains the following tables:

1. **Consumers**
2. **Consumer_Preferences**
3. **Restaurants**
4. **Restaurant_Cuisines**
5. **Ratings**

---

## 📊 Database Tables

### 1. Consumers

Stores information about restaurant consumers.

Main columns include:

- Consumer_ID
- City
- State
- Country
- Latitude
- Longitude
- Smoker
- Drink_Level
- Transportation_Method
- Marital_Status
- Children
- Age
- Occupation
- Budget

`Consumer_ID` is the primary key.

---

### 2. Consumer_Preferences

Stores the cuisine preferences of consumers.

Main columns:

- Consumer_ID
- Preferred_Cuisine

`Consumer_ID` is connected to the Consumers table through a foreign key.

---

### 3. Restaurants

Stores information about restaurants.

Main columns include:

- Restaurant_ID
- Name
- City
- State
- Country
- Zip_Code
- Latitude
- Longitude
- Alcohol_Service
- Smoking_Allowed
- Price
- Franchise
- Area
- Parking

`Restaurant_ID` is the primary key.

---

### 4. Restaurant_Cuisines

Stores the cuisine types offered by restaurants.

Main columns:

- Restaurant_ID
- Cuisine

`Restaurant_ID` is connected to the Restaurants table.

---

### 5. Ratings

Stores consumer ratings for restaurants.

Main columns:

- Consumer_ID
- Restaurant_ID
- Overall_Rating
- Food_Rating
- Service_Rating

The table connects consumers and restaurants using foreign keys.

---

## 🔄 Project Workflow

```text
CSV Files
    ↓
Create Database
    ↓
Create Tables
    ↓
Import Data
    ↓
Data Retrieval & Filtering
    ↓
Joins & Subqueries
    ↓
Aggregation & Grouping
    ↓
CTEs
    ↓
Window Functions
    ↓
Views
    ↓
Stored Procedures
    ↓
Business Insights
