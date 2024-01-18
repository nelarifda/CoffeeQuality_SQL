# CoffeeQuality_SQL

**About**

This SQL project was conducted using coffee quality dataset from Kaggle. This dataset contains ID, Country of Origin, Farm Name, Lot Number, Mill, ICO number, Company, Altitude, Region, Producer, Number of Bag, Bag Weight, In-Country Partner, Harvest Year, Grading Date, Owner, Variety, Status, Processing Method, Aroma, Flavor, Aftertaste, Acidity, Body, Balance, Uniformity, Clean Cup, Sweetness, Overall, Defects, Total Cup Points, Moisture Percentage, Category One Defects, Quakers, Color, Category Two Defects, Expiration, Certification Body, Certification Address, and Certification Contact. This project aimed to clean data then glean insightful information from useful dataset about coffee quality.

**Techniques**
1.	Understanding and preparing data

The first step in understanding data was to ingest the dataset and comprehend the meaning of each column as well as the insights it offers. Make a note of the actions and analyses that will be performed.

2.	Data Cleaning

Data cleaning included removed unused columns, replaced some value to get better data understanding, create new column to get average and total about some columns, standardized alphabet value in certain column, replaced and removed some columns, and standardized decimal number. 

3.	Ask questions about the data

Regarding this dataset, the following queries were posed:

1.	Which country of origin and company produces the most coffee?

2.	What company produces the highest total weight of coffee?

3.	What processing methods produce the lowest and highest total cup points?

4.	What processing method produces the highest moisture?

5.	What is the detailed information about the best total cup points coffee?

6.	What varieties and processing methods produce the lowest acidity?

7.	Which coffee has the highest number of category one and two defects?

8.	What color has the highest total cup points?

9.	What moisture and processing methods produce the most category one and two defects?

10.	Does each variety have the same coffee color?

11.	What are the popular methods used?

12.	What certification bodies have the highest and lowest total cup points?

**SQL concepts applied in queries**

Queries used in this project included updating and deleting data, aliasing, join data value, aggregate, common table expression (CTE), string function, and data rank. 

**Summarized insights**

1.	The query showed data about most companies and countries of origin that produce coffee. This data gives information the most productive company and country is Taiwan.

2.	Yhaenu plc has the highest total weight coffee than other companies. This company processed the highest amount of coffee.

3.	Natural/Dry method produced the lowest total cup points while washed/wet method produced the highest total cup points. This result gives insight the best processing method that produced the highest points.

4.	Washed/Wet method also has the highest moisture percentage. This means this coffee is more easily expired because of the high moisture percentage.

5.	The query showed detailed information about the highest total cup points. This data can help producers to process their coffee and get better quality. 

6.	Mundo Novo variety with natural/dry process produced the lowest acidity. This result can help consumers who prefer not acid or acid coffee.

7.	The companies that produced the highest category one and two defects can make improvements to their coffee processing. The company can compare the detailed information about their coffee and other coffee that have better number of defects.

8.	Green color provided the highest total cup points, but the results were also influenced by variety, processing method, etc.

9.	Natural dry process with 10.5% moisture content has the highest category one defects, while washed/wet process with 12.30% moisture content has the highest category two defects. That means the coffee process and moisture content affect the number of coffee defects.

10.	The results showed that every variety has different coffee color, the same processing method also can produce different colors of coffee.

11.	The most popular processing method is washed/wet process. This result can be affected by the highest total cup point produced by this process.

12.	Centro Agroecologico del Café A.C had the lowest total cup points while Japan Coffee Exchange produced the highest total cup points. These results can be used for producers' consideration while choosing certification body. 
