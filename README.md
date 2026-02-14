**📊 Blinkit Grocery Sales Analysis Using SQL**
 **SQL-Based Sales Analysis Project | Data Cleaning | KPI Analysis | Window Functions**


**🚀 Project Overview**

This project analyzes the Blinkit Grocery dataset using SQL to extract meaningful business insights.
The primary objective was to:

-Clean inconsistent data
-Calculate key performance indicators (KPIs)
-Perform category-wise and outlet-wise sales analysis
-Compute percentage contribution using window functions
-A sample dataset (1000 rows) has been uploaded for demonstration purposes. The original dataset contains 7000+ records.

**🛠 Tools & Technologies Used**

-MySQL Workbench
-SQL (Aggregate Functions, Window Functions, Data Cleaning)
-GitHub

**🗄 Database Setup**
-create database blinkit;
-use blinkit;
-select * from `blinkit grocery data`;

🧹 **Data Cleaning Process**
1️⃣** Fixed Column Encoding Issue**
The column ï»¿Item Fat Content was renamed properly:

ALTER TABLE `blinkit grocery data`
CHANGE COLUMN `ï»¿Item Fat Content` `Item Fat Content` TEXT;

2️⃣** Standardized Categorical Values**

Inconsistent values like:
-'LF'
-'low fat'
-'reg'

Were standardized to:
-'Low Fat'
-'Regular'

update `blinkit grocery data`
set `Item Fat Content` =
case 
    when `Item Fat Content` in ('LF','low fat') then 'Low Fat'
    when `Item Fat Content` = 'reg' then 'Regular'
    else `Item Fat Content`
end;


**Validation:**

select distinct(`Item Fat Content`)
from `blinkit grocery data`;

📊 **Key Performance Indicators (KPIs)**
🔹** 1. Total Sales (in Millions)**
select cast(sum(`Total Sales`)/1000000 AS Decimal(10,2)) as 'Total sales'
from `blinkit grocery data`;

🔹 **2. Average Sales**
select cast(avg(`Total Sales`) as decimal(10,0)) as 'Total Sales'
from `blinkit grocery data`;

🔹 **3. Total Number of Items**
select count(*) as 'TotalItem'
from `blinkit grocery data`;

🔹 4. **Average Rating**
select avg(Rating) as 'Average Rating'
from `blinkit grocery data`;

📈 **Exploratory Data Analysis**
1️⃣ **Sales by Item Fat Content**

-Total Sales
-Average Sales
-Number of Items
-Average Rating

select `Item Fat Content`,
       cast(sum(`Total Sales`) as decimal(10,2)) as 'Total Sales',
       cast(avg(`Total Sales`) as decimal(10,0)) as 'Average Sales',
       count(*) as 'TotalItem',
       avg(Rating) as 'Average Rating'
from `blinkit grocery data`
group by `Item Fat Content`
order by `Total Sales`;

**2️⃣ Sales by Item Type**
select `Item Type`,
       cast(sum(`Total Sales`) as decimal(10,2)) as 'Sales by Item',
       cast(avg(`Total Sales`) as decimal(10,0)) as 'Average Sales',
       count(*) as 'Total item'
from `blinkit grocery data`
group by `Item Type`;

**3️⃣ Fat Content by Outlet Location**
select `Outlet Location Type`,
       `Item Fat Content`,
       cast(sum(`Total Sales`) as decimal(10,2)) as 'Sales by Item',
       cast(avg(`Total Sales`) as decimal(10,0)) as 'Average Sales',
       count(*) as 'Total item'
from `blinkit grocery data`
group by `Outlet Location Type`,`Item Fat Content`;

**4️⃣ Sales by Outlet Establishment Year**
select `Outlet Establishment Year`,
       sum(`Total Sales`) as 'Total sales per establishment'
from `blinkit grocery data`
group by `Outlet Establishment Year`;

**📊 Percentage Analysis Using Window Functions**
**1️⃣ Sales Percentage by Outlet Size**
select `Outlet Size`,
       sum(`Total Sales`) as 'Total sales',
       cast(sum(`Total Sales`) * 100.0 /
            sum(sum(`Total Sales`)) over() as decimal(10,3)) as Sales_Percentage
from `blinkit grocery data`
group by `Outlet Size`;

**2️⃣ Sales by Outlet Location Type**
select `Outlet Location Type`,
       cast(sum(`Total Sales`) as decimal(10,2)) as Sales_by_location
from `blinkit grocery data`
group by `Outlet Location Type`;

**3️⃣ Complete Sales Performance by Outlet Location**
select `Outlet Location Type`,
       cast(sum(`Total Sales`) as decimal(10,2)) as Sales_by_Item,
       cast(sum(`Total Sales`) * 100.0 /
            sum(sum(`Total Sales`)) over() as decimal(10,3)) as Sales_Percentage,
       cast(avg(`Total Sales`) as decimal(10,0)) as 'Average Sales',
       count(*) as 'Total item'
from `blinkit grocery data`
group by `Outlet Location Type`;

**💡 Key Business Insights**

-Identified which outlet location type contributes the highest revenue.
-Measured percentage contribution of each outlet size.
-Compared performance of Low Fat vs Regular products.
-Analyzed sales distribution across item categories.
-Evaluated performance based on outlet establishment year.

**⚠ Challenges Faced**

-Encountered encoding issue in column name.
-Faced ONLY_FULL_GROUP_BY SQL mode error.
-Learned correct grouping and ordering logic.
-Improved understanding of window functions.

**📚 Skills Demonstrated**

-SQL Data Cleaning
-GROUP BY and Aggregations
-Window Functions
-KPI Calculation
-Business Insight Extraction
-Analytical Thinking
