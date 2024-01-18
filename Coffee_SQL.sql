-- look at the data we have
select *
from df_arabica
where ICO_Number is null

-- clean the data
-- remove unused columns (the first column, lot number, ico number, producer, in country partner, owner, status, defects, certification address, contact)
alter table df_arabica
drop column Lot_Number, ICO_Number, Producer, In_Country_Partner, Owner, Status, Defects, Certification_Address, Certification_Contact

select *
from df_arabica

-- clean Tanzania and Hawaii
select Country_of_Origin, replace (replace(Country_of_Origin, ', United Republic Of', ' '), 'United States (Hawaii)', 'Hawaii') as Origin_Country
from df_arabica

alter table df_arabica
add Origin_Country Nvarchar(255);

update df_arabica
set Origin_Country = replace (replace(Country_of_Origin, ', United Republic Of', ' '), 'United States (Hawaii)', 'Hawaii')

alter table df_arabica
drop column Country_of_Origin

select *
from df_arabica


-- clean mill column (replace yes with blank)
select *, replace (Mill, 'yes', ' ') as mill_location
from df_arabica

alter table df_arabica
add mill_location Nvarchar(255);

update df_arabica
set mill_location = replace (Mill, 'yes', ' ')

alter table df_arabica
drop column Mill

select *
from df_arabica

-- make average for range value of altitude
update df_arabica
set Altitude = trim (Altitude)

update df_arabica
set Altitude = REPLACE (REPLACE(Altitude, '%A%', '-'), '%~%' ,'-')

alter table df_arabica
add Altitude1 int, Altitude2 int;

update df_arabica
set Altitude1 = PARSENAME(REPLACE(Altitude, '-', '.'), 2), 
Altitude2 = PARSENAME(REPLACE(Altitude, '-', '.'), 1)

update df_arabica
set Altitude1 = Altitude2
where Altitude1 is null

alter table df_arabica
add avg_altitude int;

update df_arabica
set avg_altitude = (Altitude1 + Altitude2)/2

select *
from df_arabica

-- extract only the first word of region and standardize alphabet of region column (small alphabet)
select *
from df_arabica

alter table df_arabica
add Region1 nvarchar(255), Region2 nvarchar(255);

update df_arabica
set Region1 = PARSENAME(REPLACE(Region, ',', '.'), 2), 
Region2 = PARSENAME(REPLACE(Region, ',', '.'), 1)
where Region like '%,%'

alter table df_arabica
drop column Region2

update df_arabica
set Region1 = trim(Region1)

select Region1, concat (upper(left(Region1,1)), 
lower(right(Region1,len(Region1)-1))) as region_clean
from df_arabica

update df_arabica
set Region1 = concat (upper(left(Region1,1)), 
lower(right(Region1,len(Region1)-1)))

-- remove number of bag and bag weight, replace with total weight
select *
from df_arabica

select Bag_Weight, replace(Bag_Weight, 'kg', ' ') as bagweight
from df_arabica

update df_arabica
set Bag_Weight = replace(Bag_Weight, 'kg', ' ')

alter table df_arabica
add total_weight int;

update df_arabica
set total_weight = (1.0*Number_of_Bags*Bag_Weight)

-- remove grading date, replace with grading year (only use year of grading)
select Grading_Date, right(Grading_Date, 4) as Grading_Year
from df_arabica

alter table df_arabica
add Grading_Year int;

update df_arabica
set Grading_Year = right(Grading_Date, 4)

select *
from df_arabica

-- replace data processing and standardize it
select distinct(Processing_Method)
from df_arabica

select distinct(Processing_Method), 
replace(replace(replace(replace(replace(replace(replace(Processing_Method, 'Anaerobico 1000h', 'Washed / Wet'), 'Double Anaerobic Washed', 'Washed / Wet'),
'Double Carbonic Maceration / Natural', 'Natural / Dry'), 'Honey,Mossto', 'Pulped natural / honey'), 'Semi Washed', 'Washed / Wet'), 'SEMI-LAVADO', 'Natural / Dry'),
'Wet Hulling', 'Washed / Wet')
from df_arabica

update df_arabica
set Processing_Method = replace(replace(replace(replace(replace(replace(replace(Processing_Method, 'Anaerobico 1000h', 'Washed / Wet'), 'Double Anaerobic Washed', 'Washed / Wet'),
'Double Carbonic Maceration / Natural', 'Natural / Dry'), 'Honey,Mossto', 'Pulped natural / honey'), 'Semi Washed', 'Washed / Wet'), 'SEMI-LAVADO', 'Natural / Dry'),
'Wet Hulling', 'Washed / Wet')

-- Anaerobico 1000h : Washed / Wet
-- Double Anaerobic Washed : Washed / Wet
-- Double Carbonic Maceration / Natural : Natural / Dry
-- Honey,Mossto : Pulped natural / honey
-- Semi Washed : Washed / Wet
-- SEMI-LAVADO : Natural / Dry
-- Wet Hulling : Washed / Wet

-- standardize decimal values
select *
from df_arabica

alter table df_arabica
add Aroma_clean decimal (3,2),
Flavor_clean decimal (3,2),
Aftertaste_clean decimal (3,2),
Acidity_clean decimal (3,2),
Body_clean decimal (3,2),
Balance_clean decimal (3,2),
Overall_clean decimal (3,2),
Total_cup_points_clean decimal (4,2), 
Moisture_percentage_clean decimal (4,2);


update df_arabica
set  Aroma_clean = Aroma,
Flavor_clean = Flavor,
Aftertaste_clean = Aftertaste,
Acidity_clean = Acidity,
Body_clean = Body,
Balance_clean = Balance,
Overall_clean = Overall,
Total_cup_points_clean = Total_Cup_Points,
Moisture_percentage_clean = Moisture_Percentage

alter table df_arabica
drop column Aroma, Flavor, Aftertaste, Acidity, Body, Balance, Overall, Total_Cup_Points, Moisture_Percentage

-- standardize color
select distinct(Color)
from df_arabica

update df_arabica
set Color = replace(replace(replace(replace(replace(replace(replace(Color, 'browish-green', 'brownish-green'), 'greenish', 'green'), 'pale yellow', 'yellow'),
'yello-green','yellow-green'), 'yellow green', 'yellow-green'), 'yellow- green', 'yellow-green'), 'yellowish', 'yellow')

-- browish-green = brownish-green
-- greenish = green
-- pale yellow = yellow
-- yello-green = yellow-green
-- yellow green = yellow-green
-- yellow- green = yellow-green
-- yellowish = yellow


-- Question
-- 1. Which country of origin and company produces the most coffee?
select Company, count (Company) as count_company
from df_arabica
group by Company
order by count_company desc

select Origin_Country, count(Origin_Country) as count_country
from df_arabica
group by Origin_Country
order by count_country desc


-- 2. What company produces the highest total weight of coffee?
select Company, sum(total_weight) as sum_total_weight
from df_arabica
group by Company, total_weight
order by total_weight desc


-- 3. What processing methods produce the lowest and highest total cup points?
select distinct concat(first_value(Processing_Method) over (order by Total_cup_points_clean), 
' - ',
first_value(Total_cup_points_clean) over(order by Total_cup_points_clean)) as lowest_total_cup_points,
concat(first_value(Processing_Method) over (order by Total_cup_points_clean desc), 
' - ',
first_value(Total_cup_points_clean) over(order by Total_cup_points_clean desc)) as highest_total_cup_points
from df_arabica

-- 4. what processing method produces the highest moisture?
with data_cte as
(select Processing_Method, Moisture_percentage_clean,rank() over (order by Moisture_percentage_clean desc) as rnk
from df_arabica)

select Processing_Method, Moisture_percentage_clean as highest_moisture
from data_cte
where rnk = 1


-- 5. What is the detailed information about the best total cup points coffee?
with besttotalcup_cte as
(select *, rank() over(order by Total_cup_points_clean desc) as rnk
from df_arabica
)
select *
from besttotalcup_cte
where rnk = 1


-- 6. What varieties and processing methods produce the lowest acidity?
with acidity_cte as
(select Variety, Processing_Method, Acidity_clean, rank() over (order by Acidity_clean) as rnk
from df_arabica)

select Variety, Processing_Method, Acidity_clean as lowest_acidity
from acidity_cte
where rnk = 1


-- 7. Which coffee has the highest number of category one and two defect?
select distinct concat(first_value(Company) over (order by Category_One_Defects desc), ' - ',
first_value(Category_One_Defects) over (order by Category_One_Defects desc)) as highest_category_one_defects,
concat(first_value(Company) over (order by Category_Two_Defects desc), ' - ',
first_value(Category_Two_Defects) over (order by Category_Two_Defects desc)) as highest_category_two_defects
from df_arabica


-- 8. What color has the highest total cup points?
with highestcolor_cte as
(select Color, Total_cup_points_clean, rank() over (order by Total_cup_points_clean desc) as rnk
from df_arabica
)

select Color, Total_cup_points_clean as highest_total_cup_point
from highestcolor_cte
where rnk = 1

-- 9. What moisture and processing methods produce the most category one and two defect?
select distinct concat (first_value (Processing_Method) over ( order by Category_One_Defects desc), ' - ',
first_value (Moisture_percentage_clean) over ( order by Category_One_Defects desc), '% ', ' - ',
first_value (Category_One_Defects) over ( order by Category_One_Defects desc)) as highest_category_one_defect,
concat (first_value (Processing_Method) over ( order by Category_Two_Defects desc), ' - ',
first_value (Moisture_percentage_clean) over ( order by Category_Two_Defects desc), '% ', ' - ',
first_value (Category_Two_Defects) over ( order by Category_Two_Defects desc)) as highest_category_two_defect
from df_arabica


-- 10. Does each variety have the same coffee color?
select Variety, Processing_Method,Color
from df_arabica
where Variety <> 'NULL'
group by Variety, Processing_Method, Color


-- 11. What are the popular methods used?
select distinct (Processing_Method), count(Processing_Method) as count
from df_arabica
where Processing_Method <> 'NULL'
group by Processing_Method
order by count(Processing_Method) desc


-- 12. What certification bodies have the highest and lowest total cup points?
select distinct concat (first_value (Certification_Body) over (order by Total_cup_points_clean), ' - ',
first_value(Total_cup_points_clean) over (order by Total_cup_points_clean)) as lowest_total_cup_point, 
concat (first_value (Certification_Body) over (order by Total_cup_points_clean desc), ' - ',
first_value(Total_cup_points_clean) over (order by Total_cup_points_clean desc)) as highest_total_cup_point
from df_arabica
