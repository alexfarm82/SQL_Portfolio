--First, I was curious about the different types of prescribers.

SELECT part_d.state, prscrbr_type, count(prscrbr_type)
FROM part_d
GROUP BY part_d.state, prscrbr_type
ORDER BY prscrbr_type;


--Took a peak at Florida's results

SELECT part_d.state, prscrbr_type, count(prscrbr_type)
FROM part_d
WHERE part_d.state = 'FL'
GROUP BY part_d.state, prscrbr_type
ORDER BY prscrbr_type;


---Looked into the distinct zipcodes on the registry

SELECT zipcode, COUNT(zipcode)
FROM part_d
GROUP BY zipcode;


-- Added Florida again

SELECT zipcode, COUNT(zipcode)
FROM part_d
WHERE part_d.state = 'FL'
GROUP BY zipcode;


--How many prescribers from Florida are Nurse Practioners and registered in Sarasota

SELECT *
FROM part_d
WHERE prscrbr_type = 'Nurse Practitioner' AND city = 'Sarasota';


--How many male and female prescribers

SELECT DISTINCT(prscrbr_gndr), COUNT (*) 
FROM part_d
GROUP BY prscrbr_gndr;


--get the total cost of prescribed drugs of 2022

SELECT SUM(tot_drug_cst)
FROM part_d;


--Retrieve the total cost of drug cost per state

SELECT part_d.state, SUM(tot_drug_cst) as state_cost
FROM part_d
GROUP BY part_d.state 
ORDER BY state_cost ASC; 


--How much per dentist

SELECT part_d.state, SUM(tot_drug_cst) as state_cost
FROM part_d
WHERE prscrbr_type = 'Dentist'
GROUP BY part_d.state 
ORDER BY state_cost ASC; 


--How many cardiologist in NY had 30 day fills 


SELECT prscrbr_type, COUNT(tot_30day_fills) as monthly_fills
FROM part_d
WHERE prscrbr_type = 'Cardiology' 
	OR prscrbr_type = 'Cardiac Surgery'
	AND part_d.state = 'NY'
GROUP BY prscrbr_type 
ORDER BY monthly_fills ASC; 