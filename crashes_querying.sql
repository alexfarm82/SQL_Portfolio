/* link to dataset
https://catalog.data.gov/dataset/motor-vehicle-collisions-crashes/resource/b5a431d2-4832-43a6-9334-86b62bdb033f*/


--how many occurrences in 2022?
SELECT COUNT(*) 
FROM crashes 
WHERE crash_date >= '2022-01-01' AND crash_date <= '2022-12-31';
--69404 crashes in 2022

--how many in the manhattan borough?
SELECT COUNT(*) 
FROM crashes 
WHERE borough = 'MANHATTAN';
--131632 total crashes in the Manhattan borough

--leading cause of accidents
SELECT cause_vehicle_1, COUNT(*) AS total_a 
FROM crashes 
GROUP BY cause_vehicle_1 
ORDER BY total_a DESC 
LIMIT 1;
--Driver Inattention/Distraction caused 258545 accidents

--the average number of accidents per month
SELECT AVG(total_b) AS average 
FROM (SELECT COUNT(*) AS total_b 
      FROM crashes 
      GROUP BY DATE_TRUNC('month', crash_date)) AS monthly_counts;
--12192.732558139535

--how many sedans are the main vehicle of accident
SELECT COUNT(*) 
FROM crashes 
WHERE vehicle_1_type = 'Sedan';
--493178

--how many persons injured
SELECT SUM(persons_injured) 
FROM crashes;
--336464
--how many killed
SELECT SUM(persons_killed) 
FROM crashes;
--1554

--the most accidents in one month
SELECT MAX(total_c) AS most
FROM (SELECT COUNT(*) AS total_c 
      FROM crashes 
      GROUP BY DATE_TRUNC('month', crash_date)) AS monthly_counts;
--21373
--what month was it
SELECT DATE_TRUNC('month', crash_date) AS busiest_month, COUNT(*) AS accident_count
FROM crashes
GROUP BY busiest_month
ORDER BY accident_count DESC
LIMIT 1;
--2017-06-01 00:00:00-04
--which month has the least
SELECT DATE_TRUNC('month', crash_date) AS calmest_month, COUNT(*) AS accident_count
FROM crashes
GROUP BY calmest_month
ORDER BY accident_count ASC
LIMIT 1;
--"2012-07-01 00:00:00-04"	only 1

--how many accidents per borough
SELECT borough, COUNT(*) AS amt_crshs
FROM crashes
GROUP BY  borough;
/*
"BRONX"	110164
"BROOKLYN"	218584
"MANHATTAN"	131632
"QUEENS"	186285
"STATEN ISLAND"	25246
"[null]"	376664 */

--what are the counts for the street locations
SELECT on_street, cross_street, off_street, COUNT (*) AS strt_counts
FROM crashes
GROUP BY on_street, cross_street, off_street;
/* 279010 different spots, many along the same strip of road. the majority of the off street column rendered null*/
SELECT off_street, COUNT(*)
FROM crashes
WHERE off_street IS NULL
GROUP BY off_street;
-- there are 792888 [null] entries for the off_street column

--
SELECT COALESCE(borough, 'N/A') AS nan_b,
       COALESCE(on_street, 'N/A') AS nan_on,
	   COALESCE(cross_street, 'N/A') AS nan_cross,
       COALESCE(off_street, 'N/A') AS nan_off,
       COALESCE(cause_vehicle_1, 'N/A') AS nan_1c,
	   COALESCE(cause_vehicle_2, 'N/A') AS nan_2c,
       COALESCE(cause_vehicle_3, 'N/A') AS nan_3c,
       COALESCE(cause_vehicle_4, 'N/A') AS nan_4c,
	   COALESCE(cause_vehicle_5, 'N/A') AS nan_5c,
       COALESCE(vehicle_1_type, 'N/A') AS nan_v1,
	   COALESCE(vehicle_2_type, 'N/A') AS nan_v2,
       COALESCE(vehicle_3_type, 'N/A') AS nan_v3,
       COALESCE(vehicle_4_type, 'N/A') AS nan_v4,
	   COALESCE(vehicle_5_type, 'N/A') AS nan_v5,
	   COUNT(*) AS null_counts
FROM crashes
GROUP BY 
	   COALESCE(borough, 'N/A'),
       COALESCE(on_street, 'N/A'),
	   COALESCE(cross_street, 'N/A'),
       COALESCE(off_street, 'N/A'),
       COALESCE(cause_vehicle_1, 'N/A'),
	   COALESCE(cause_vehicle_2, 'N/A'),
       COALESCE(cause_vehicle_3, 'N/A'),
       COALESCE(cause_vehicle_4, 'N/A'),
	   COALESCE(cause_vehicle_5, 'N/A'),
       COALESCE(vehicle_1_type, 'N/A'),
	   COALESCE(vehicle_2_type, 'N/A'),
       COALESCE(vehicle_3_type, 'N/A'),
       COALESCE(vehicle_4_type, 'N/A'),
	   COALESCE(vehicle_5_type, 'N/A');
--870548 ROWS CHANGED