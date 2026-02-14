create database blinkit;
use blinkit;
select * from `blinkit grocery data`;

ALTER TABLE `blinkit grocery data`
CHANGE COLUMN `ï»¿Item Fat Content` `Item Fat Content` TEXT;

update `blinkit grocery data` set `Item Fat Content`=
case when `Item Fat Content` in('LF','low fat') then 'Low Fat'
when `Item Fat Content`='reg' then 'Regular'
else `Item Fat Content`
end;

select distinct(`Item Fat Content`) from `blinkit grocery data`;
-- 1.KPI-Total Sales
select cast(sum(`Total Sales`)/1000000 AS Decimal(10,2)) as 'Total sales' from `blinkit grocery data`;
-- 2.KPI-Average Sales
select avg(`Total Sales`) from `blinkit grocery data`;
select cast(avg(`Total Sales`) as decimal(10,0)) as 'Total Sales' from `blinkit grocery data`;
-- 3.Number of items
select count(*) as 'TotalItem' from `blinkit grocery data`;
-- 4 Average Rating 
select avg(Rating) as 'Average Rating' from `blinkit grocery data`;

-- 1.Total sales by low fat
select `Item Fat Content`,
cast(sum(`Total Sales`)as decimal(10,2)) as 'Total Sales',
cast(avg(`Total Sales`) as decimal(10,0)) as 'Total Sales',
count(*) as 'TotalItem',
avg(Rating) as 'Average Rating' 
 from `blinkit grocery data`
 group by `Item Fat Content`
 order by `Total Sales`;

-- 2.Total sales by item type
select `Item Type`,
cast(sum(`Total Sales`)as decimal(10,2)) 'Sales by Item' ,
cast(avg(`Total Sales`) as decimal(10,0)) as 'Total Sales',
count(*) as 'Total item'
 from `blinkit grocery data` group by `Item Type`;

-- 3.Fat content by outlet for total sales
select `Outlet Location Type`,`Item Fat Content`,
cast(sum(`Total Sales`)as decimal(10,2)) 'Sales by Item' ,
cast(avg(`Total Sales`) as decimal(10,0)) as 'Total Sales',
count(*) as 'Total item'
 from `blinkit grocery data` group by `Outlet Location Type`,`Item Fat Content`;

-- 4.total sales by outlet establishment
select `Outlet Establishment Year`,sum(`Total Sales`) as 'Total sales per establishment' 
from `blinkit grocery data` 
group by `Outlet Establishment Year`
 order by 'Total sales per establishment';


-- 1.Sales percentage by outlize size
select `Outlet Size` ,sum(`Total Sales`)as 'Total sales' ,
cast(sum(`Total Sales`)*100.0 / sum(sum(`Total Sales`)) over() as decimal (10,3)) as Sales_Percentage
 from `blinkit grocery data`
 group by `Outlet Size`
 order by `Total Sales`;

-- 2.Sales by outlet Location
select `Outlet Location Type`,
cast(sum(`Total Sales`) as decimal(10,2))as Sales_by_location 
from `blinkit grocery data`
group by `Outlet Location Type`;

-- 3.
select `Outlet Location Type`,
cast(sum(`Total Sales`)as decimal(10,2)) 'Sales by Item' ,
cast(sum(`Total Sales`)*100.0 / sum(sum(`Total Sales`)) over() as decimal (10,3)) as Sales_Percentage,
cast(avg(`Total Sales`) as decimal(10,0)) as 'Average Sales',
count(*) as 'Total item'
from  `blinkit grocery data`
group by `Outlet Location Type`
order by 'Sales by Item';