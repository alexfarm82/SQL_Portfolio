--an hr analysis on data found at

--1. employee count by department
SELECT "Department", COUNT("EmpID") as headcount
FROM hr_analysis
GROUP BY "Department";
/*
"Department"	"headcount"
"Production       "	209
"Admin Offices"	9
"Executive Office"	1
"IT/IS"	50
"Sales"	31
"Software Engineering"	11 */

--2. avg. employee tenure in  years
SELECT "Department", AVG(DATE_PART('year',"DateofTermination") - DATE_PART('year', "DateofHire")) AS avg_stay
FROM hr_analysis
WHERE "DateofTermination" IS NOT NULL
GROUP BY "Department";
/*
"Department"	"avg_stay"
"Admin Offices"	1
"IT/IS"	1.5
"Software Engineering"	3.75
"Sales"	2.6
"Production       "	3.674698795180723 */

--3. compensation analysis
SELECT "Department", AVG("Salary") AS avg_salary,
	MIN("Salary") AS min_salary,
	MAX("Salary") AS max_salary
FROM hr_analysis
GROUP BY "Department";
/*
"Department"	"avg_salary"	"min_salary"	"max_salary"
"Production       "	59953.545454545455	45046	170500
"Admin Offices"	71791.888888888889	49920	106367
"Executive Office"	250000.000000000000	250000	250000
"IT/IS"	97064.640000000000	50178	220450
"Sales"	69061.258064516129	55875	180000
"Software Engineering"	94989.454545454545	77692	108987 */

--4. employee demographics - gender
SELECT "Sex", COUNT("EmpID") AS demo_count
FROM hr_analysis
GROUP BY "Sex";
/*
"Sex"	"demo_count"
"F"	176
"M "	135 */

--5. employee demographics - diversity
SELECT "RaceDesc", COUNT("EmpID") AS heritage
FROM hr_analysis
GROUP BY "RaceDesc";
/*
"RaceDesc"	"heritage"
"Hispanic"	1
"American Indian or Alaska Native"	3
"Two or more races"	11
"Asian"	29
"White"	187
"Black or African American"	80 */

--6. employee demographics - ethnicity
SELECT "HispanicLatino", COUNT("EmpID") AS ethnicity
FROM hr_analysis
GROUP BY "HispanicLatino";
/*
"HispanicLatino"	"ethnicity"
"No"	282
"no"	1
"Yes"	27
"yes"	1 */

--7. perfomance rating
SELECT "PerformanceScore", COUNT("EmpID") AS perf_count
FROM hr_analysis
GROUP BY "PerformanceScore";
/*
"PerformanceScore"	"perf_count"
"PIP"	13
"Fully Meets"	243
"Needs Improvement"	18
"Exceeds"	37  */

--8. average engagement score
SELECT "Department", AVG("EngagementSurvey") AS engagement
FROM hr_analysis
GROUP BY "Department";
/*
"Department"	"engagement"
"Production       "	4.1295693779904306
"Admin Offices"	4.3933333333333333
"Executive Office"	4.8300000000000000
"IT/IS"	4.1540000000000000
"Sales"	3.8187096774193548
"Software Engineering"	4.0618181818181818  */

--9. turnover rate
SELECT DATE_PART('YEAR', "DateofTermination") AS exit_year,
	COUNT("EmpID") AS total_exits
FROM hr_analysis
GROUP BY exit_year; 
/*
"exit_year"	"total_exits"
	207
2015	23
2016	22
2011	3
2012	8
2014	13
2010	1
2017	8
2018	13
2013	13  */

--10. retiremrent eligibility
SELECT "EmpID", years_of_service
FROM
	(SELECT "EmpID", DATE_PART('year', CURRENT_DATE) - DATE_PART('year', "DateofHire") AS years_of_service
	FROM hr_analysis) AS emp_term
WHERE years_of_service >=15;
/* the longest employment term is 17 years so technically no one is qualified for retirement benefits
"EmpID"	"years_of_service"
10088	15
10238	15
10164	16
10268	16
10013	17
10301	15  */