
--check data load
select * from online_retail;

--find different invoice count
select "InvoiceNo", count(*) as invoices
from online_retail
group by "InvoiceNo";
--25900 different invoice numbers with multiple counts

--total invoices
select sum(invoices)
from (
	select "InvoiceNo", count(*) as invoices
	from online_retail
	group by "InvoiceNo") as tot_inv;
--1625727 total invoices, but each invoice is listed seperately with each individual stockcode

--find the highest/lowest/average
select 
	min("Quantity"),
	max("Quantity"),
	avg("Quantity"),
from online_retail;
-- -80995	80995	9.5522495474332406

--return different stockcode numbers
select "StockCode", count(*) as the_stock
from online_retail
group by "StockCode";
--stock returned a smaller number of 4070 different codes

--how many items were ordered
select sum("Quantity")
from online_retail;
--15529350

--how many different descriptions are there
select distinct("Description"), "Quantity"
from online_retail
group by "Description", "Quantity";
--44938 [multiple duplicate descriptions]

--since stockcodes are used several times over find actual count of different items
SELECT DISTINCT ON ("StockCode", "Description") "StockCode", "Description"
FROM online_retail
ORDER BY "StockCode", "Description"
LIMIT 10;
--5752 distinct descriptions
/*
"10002"	"INFLATABLE POLITICAL GLOBE "
"10002"	
"10080"	"check"
"10080"	"GROOVY CACTUS INFLATABLE"
"10080"	
"10120"	"DOGGY RUBBER"
"10123C" "HEARTS WRAPPING TAPE "
"10123C"	
"10123G"	
"10124A" "SPOTS ON RED BOOKCOVER TAPE"*/

--there is no total sale column so create one
select "InvoiceNo", "StockCode", "Quantity", "UnitPrice", "Quantity" * "UnitPrice" as sale_total
from online_retail
group by "InvoiceNo", "StockCode", "Quantity", "UnitPrice"
limit 10;
--536638 total rows
/*
"536365"	"21730"	6	4.25	25.50
"536365"	"22752"	2	7.65	15.30
"536365"	"71053"	6	3.39	20.34
"536365"	"84029E"	6	3.39	20.34
"536365"	"84029G"	6	3.39	20.34
"536365"	"84406B"	8	2.75	22.00
"536365"	"85123A"	6	2.55	15.30
"536366"	"22632"	6	1.85	11.10
"536366"	"22633"	6	1.85	11.10
"536367"	"21754"	3	5.95	17.85*/

--get item count and price
select "StockCode", sum("Quantity") as quant, sum("UnitPrice") as price
from online_retail
group by "StockCode"
limit 10;

/*"StockCode"	"quant"	"price"
"10002"	3111	231.45
"10080"	1485	27.12
"10120"	579	18.90
"10123C"	-39	5.85
"10123G"	-114	0
"10124A"	48	6.30
"10124G"	51	5.04
"10125"	3888	242.43
"10133"	8325	387.48
"10134"	-57	0
*/

--get total sales per per item per invoice
select "InvoiceNo", quant*price as tot_sale
from
	(select "InvoiceNo", "StockCode", sum("Quantity") as quant, sum("UnitPrice") as price
	from online_retail
	group by "InvoiceNo", "StockCode") per_instance
limit 15;
/*
"536365"	229.50
"536365"	137.70
"536365"	183.06
"536365"	183.06
"536365"	183.06
"536365"	198.00
"536365"	137.70
"536366"	99.90
"536366"	99.90
"536367"	160.65
"536367"	160.65
"536367"	286.20
"536367"	89.10
"536367"	179.10
"536367"	133.65 */

--MONTHLY totals of items sold per invoice
SELECT DISTINCT("InvoiceNo"), to_char("InvoiceDate", 'YYYY-MM') AS monthly, "Quantity"*"UnitPrice" as total
FROM online_retail
GROUP BY "InvoiceNo", monthly, total
ORDER BY monthly;

