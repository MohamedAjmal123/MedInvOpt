create database pharmaDB;
use pharmaDB;

create table pharmasales(
        BillDate date,
    TQty int,
    UCPwithoutGST decimal,
    PurGSTPer decimal,
    MRP decimal,
    TotalCost decimal,
    TotalDiscount decimal,
    NetSales decimal,
    ReturnMRP decimal,
    GenericName varchar(300),
    SubCategory varchar(300),
    SubCategoryL3 varchar(300),
    AnonymizedBillNo varchar(300),
    AnonymizedSpecialisation varchar(300)
    );
    drop table pharmasales;
    # Load the data
SHOW VARIABLES LIKE 'secure_file_priv';
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/SAMPLEMIODATA.csv"
INTO TABLE pharmasales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT*FROM pharmasales;

-- Get the number of rows
select count(*) as total_rows from pharmasales;

-- Get the number of columns
select count(*) as total_columns
from pharmasales;


# Total sales
select sum(NetSales) as TotalNetSales from PharmaSales;

# sales by subcategory
select SubCategory, sum(NetSales) as TotalNetSales
from PharmaSales
group by SubCategory;

# monthly sales by subcategory
SELECT 
    YEAR(BillDate) AS Year,
    MONTH(BillDate) AS Month,
    SubCategory,
    SUM(NetSales) AS TotalSales
FROM 
    pharmasales
GROUP BY 
    YEAR(BillDate), MONTH(BillDate), SubCategory
ORDER BY 
    Year, Month, SubCategory;
# yearly sales by subcategory
SELECT 
    YEAR(BillDate) AS Year,
    SubCategory,
    SUM(NetSales) AS TotalSales
FROM 
    pharmasales
GROUP BY 
    YEAR(BillDate), SubCategory
ORDER BY 
    Year, SubCategory;

# monthly demand by sub category
SELECT 
    YEAR(BillDate) AS Year,
    MONTH(BillDate) AS Month,
    SubCategory,
    SUM(TQty) AS TotalQuantity
FROM 
    pharmasales
GROUP BY 
    YEAR(BillDate), MONTH(BillDate), SubCategory
ORDER BY 
    Year, Month, SubCategory;

#yearly demand by sub category
SELECT 
    YEAR(BillDate) AS Year,
    SubCategory,
    SUM(TQty) AS TotalQuantity
FROM 
    pharmasales
GROUP BY 
    YEAR(BillDate), SubCategory
ORDER BY 
    Year, SubCategory;


# Top Selling Products
select GenericName, sum(NetSales) as TotalNetSales
from PharmaSales
group by  GenericName
order by TotalNetSales desc
limit 10;

# Top selling product in each sub category
SELECT 
    SubCategory,
    GenericName,
    SUM(NetSales) AS TotalSales
FROM 
    pharmasales
GROUP BY 
    SubCategory, GenericName
ORDER BY 
    SubCategory, TotalSales DESC;
    
# determine the demand for each product  in each subcategory
SELECT 
    SubCategory,
    GenericName,
    SUM(TQty) AS TotalQuantity
FROM 
    pharmasales
GROUP BY 
    SubCategory, GenericName
ORDER BY 
    SubCategory, TotalQuantity DESC;


# Monthly Sales 
select date_format(BillDate, '%Y-%m') as month, sum(NetSales) as TotalNetSales
from PharmaSales
group by month
order by month;

#Total sales and Total Discount
SELECT SUM(NetSales) AS TotalNetSales, SUM(TotalDiscount) AS TotalDiscount
FROM Pharmasales;

# Average purchase cost per subcategory
select SubCategory, avg(UCPwithoutGST) as AvgPurchaseCost
from Pharmasales
group by SubCategory;

#Total Quantity sold per subcategory
select SubCategory, sum(TQty) as TotalQuantity
from Pharmasales
group by SubCategory;

# profit analysis
select DATE_FORMAT(BillDate, '%Y-%m') as month, sum(NetSales - TotalCost) as Profit
from pharmasales
group by month
order by month;

# profits in subcategory
SELECT
    SubCategory,
    SUM(NetSales - TotalCost) AS TotalProfit
FROM
    pharmasales
GROUP BY
    SubCategory;


# sales by AnonymizedSpecialisation
select AnonymizedSpecialisation, sum(NetSales) as TotalSales
from pharmasales
group by AnonymizedSpecialisation
order by TotalSales desc ;

# Calculate mean standard deviation
select
    avg(TQty) as mean_TQty, 
    stddev(TQty) as stddev_TQty,
    avg(UCPwithoutGST) as mean_UCPwithoutGST, 
    stddev(UCPwithoutGST) as stddev_UCPwithoutGST,
    avg(PurGSTPer) as mean_PurGSTPer, 
    stddev(PurGSTPer) as stddev_PurGSTPer,
    avg(MRP) as mean_MRP, 
    stddev(MRP) as stddev_MRP,
    avg(TotalCost) as mean_TotalCost, 
    stddev(TotalCost) as stddev_TotalCost,
    avg(TotalDiscount) as mean_TotalDiscount, 
    stddev(TotalDiscount) as stddev_TotalDiscount,
    avg(NetSales) as mean_NetSales, 
    stddev(NetSales) as stddev_NetSales,
    avg(ReturnMRP) as mean_ReturnMRP, 
    stddev(ReturnMRP) as stddev_ReturnMRP
from pharmasales;


# Data Quality check 
select count(*) as missing_values
from pharmasales 
where BillDate is null 
or TQty is null 
or UCPwithoutGST is null
or PurGSTPer is null 
or MRP is null
or TotalCost is null
or TotalDiscount is null
or NetSales is null 
or ReturnMRP is null
or GenericName is null
or SubCategory is null 
or SubCategoryL3 is null
or AnonymizedBillNo is null 
or AnonymizedSpecialisation is null;

# Handling Duplicates
#Identify and remove duplicates:

SET SQL_SAFE_UPDATES = 0;

delete from pharmasales
using pharmasales, pharmasales AS duplicate
where pharmasales.AnonymizedBillNo = duplicate.AnonymizedBillNo
   and pharmasales.BillDate = duplicate.BillDate
   and pharmasales.TQty = duplicate.TQty
   and pharmasales.UCPwithoutGST = duplicate.UCPwithoutGST
   and pharmasales.PurGSTPer = duplicate.PurGSTPer
   and pharmasales.MRP = duplicate.MRP
   and pharmasales.TotalCost = duplicate.TotalCost
   and pharmasales.TotalDiscount = duplicate.TotalDiscount
   and pharmasales.NetSales = duplicate.NetSales
   and pharmasales.ReturnMRP = duplicate.ReturnMRP
   and pharmasales.GenericName = duplicate.GenericName
   and pharmasales.SubCategory = duplicate.SubCategory
   and pharmasales.SubCategoryL3 = duplicate.SubCategoryL3
   and pharmasales.AnonymizedSpecialisation = duplicate.AnonymizedSpecialisation;

#Skewness 
select
    (count(*) / ((count(*) - 1) * (count(*) - 2))) *
    sum(power((TQty - (select avg (TQty) from pharmasales)) / (select stddev(TQty) from pharmasales), 3)) as skewness_TQty,
    (count(*) / ((count(*) - 1) * (count(*) - 2))) *
    sum(power((UCPwithoutGST - (select avg (UCPwithoutGST) from pharmasales)) / (select stddev(UCPwithoutGST) from pharmasales), 3)) as skewness_UCPwithoutGST,
    (count(*) / ((count(*) - 1) * (count(*) - 2))) *
    sum(power((PurGSTPer - (select avg (PurGSTPer) from pharmasales)) / (select stddev(PurGSTPer) from pharmasales), 3)) as skewness_PurGSTPer,
	(count(*) / ((count(*) - 1) * (count(*) - 2))) *
    sum(power((MRP - (select avg (MRP) from pharmasales)) / (select stddev(MRP) from pharmasales), 3)) as skewness_MRP,
     (count(*) / ((count(*) - 1) * (count(*) - 2))) *
    sum(power((TotalCost - (select avg (TotalCost) from pharmasales)) / (select stddev(TotalCost) from pharmasales), 3)) as skewness_TotalCost,
    (count(*) / ((count(*) - 1) * (count(*) - 2))) *
    sum(power((NetSales - (select avg (NetSales) from pharmasales)) / (select stddev(NetSales) from pharmasales), 3)) as skewness_NetSales,
    (   count(*) / ((count(*) - 1) * (count(*) - 2))) *
    sum(power((ReturnMRP - (select avg (ReturnMRP) from pharmasales)) / (select stddev(ReturnMRP) from pharmasales), 3)) as skewness_ReturnMRP
from pharmasales;


# kurtosis 
select
    sum(power(TQty - (select avg(TQty) from pharmasales), 4)) / count(TQty) /
    power(sqrt(sum(power(TQty - (select avg(TQty) from pharmasales), 2)) / count(TQty)), 4) as kurtosis_TQty,
    
    sum(power(UCPwithoutGST - (select avg(UCPwithoutGST) from pharmasales), 4)) / count(UCPwithoutGST) /
    power(sqrt(sum(power(UCPwithoutGST - (select avg(UCPwithoutGST) from pharmasales), 2)) / count(UCPwithoutGST)), 4) as kurtosis_UCPwithoutGST,
    
    sum(power(PurGSTPer - (select avg(PurGSTPer) from pharmasales), 4)) / count(PurGSTPer) /
    power(sqrt(sum(power(PurGSTPer- (select avg(PurGSTPer) from pharmasales), 2)) / count(PurGSTPer)), 4) as kurtosis_PurGSTPer,
    
    sum(power(MRP- (select avg(MRP) from pharmasales), 4)) / count(MRP) /
    power(sqrt(sum(power(MRP- (select avg(MRP) from pharmasales), 2)) / count(MRP)), 4) as kurtosis_MRP,
    
    sum(power(TotalCost- (select avg(TotalCost) from pharmasales), 4)) / count(TotalCost) /
    power(sqrt(sum(power(TotalCost- (select avg(TotalCost) from pharmasales), 2)) / count(TotalCost)), 4) as kurtosis_TotalCost,
    
    sum(power(NetSales- (select avg(NetSales) from pharmasales), 4)) / count(NetSales) /
    power(sqrt(sum(power(NetSales- (select avg(NetSales) from pharmasales), 2)) / count(NetSales)), 4) as kurtosis_NetSales,
    
	sum(power(ReturnMRP- (select avg(ReturnMRP) from pharmasales), 4)) / count(ReturnMRP) /
    power(sqrt(sum(power(ReturnMRP- (select avg(ReturnMRP) from pharmasales), 2)) / count(ReturnMRP)), 4) as kurtosis_ReturnMRP
    from pharmasales;
    
    
    # identify outliers
    select BillDate, TQty from pharmasales
where TQty > (select avg(TQty) + 2 * stddev(TQty) from pharmasales);

select BillDate, UCPwithoutGST from pharmasales
where UCPwithoutGST > (select avg(TQty) + 2 * stddev(TQty) from pharmasales); 

select BillDate, PurGSTPer from pharmasales
where PurGSTPer > (select avg(TQty) + 2 * stddev(TQty) from pharmasales);

select BillDate, MRP from pharmasales
where MRP > (select avg(TQty) + 2 * stddev(TQty) from pharmasales);

select BillDate, TotalCost from pharmasales
where TotalCost > (select avg(TQty) + 2 * stddev(TQty) from pharmasales);

select BillDate, NetSales from pharmasales
where NetSales > (select avg(TQty) + 2 * stddev(TQty) from pharmasales);

select BillDate, ReturnMRP from pharmasales
where ReturnMRP > (select avg(TQty) + 2 * stddev(TQty) from pharmasales);





# NORMALIZATION/SCALING 
# MIN MAX SCALING
 select
 (TQty - (SELECT MIN(TQty) FROM pharmasales)) / ((SELECT MAX(TQty) FROM pharmasales) - (SELECT MIN(TQty) FROM pharmasales)) AS Normalized_TQty,
    (UCPwithoutGST - (SELECT MIN(UCPwithoutGST) FROM pharmasales)) / ((SELECT MAX(UCPwithoutGST) FROM pharmasales) - (SELECT MIN(UCPwithoutGST) FROM pharmasales)) AS Normalized_UCPwithoutGST,
    (PurGSTPer - (SELECT MIN(PurGSTPer) FROM pharmasales)) / ((SELECT MAX(PurGSTPer) FROM pharmasales) - (SELECT MIN(PurGSTPer) FROM pharmasales)) AS Normalized_PurGSTPer,
    (MRP - (SELECT MIN(MRP) FROM pharmasales)) / ((SELECT MAX(MRP) FROM pharmasales) - (SELECT MIN(MRP) FROM pharmasales)) AS Normalized_MRP,
    (TotalCost - (SELECT MIN(TotalCost) FROM pharmasales)) / ((SELECT MAX(TotalCost) FROM pharmasales) - (SELECT MIN(TotalCost) FROM pharmasales)) AS Normalized_TotalCost,
    (TotalDiscount - (SELECT MIN(TotalDiscount) FROM pharmasales)) / ((SELECT MAX(TotalDiscount) FROM pharmasales) - (SELECT MIN(TotalDiscount) FROM pharmasales)) AS Normalized_TotalDiscount,
    (NetSales - (SELECT MIN(NetSales) FROM pharmasales)) / ((SELECT MAX(NetSales) FROM pharmasales) - (SELECT MIN(NetSales) FROM pharmasales)) AS Normalized_NetSales,
    (ReturnMRP - (SELECT MIN(ReturnMRP) FROM pharmasales)) / ((SELECT MAX(ReturnMRP) FROM pharmasales) - (SELECT MIN(ReturnMRP) FROM pharmasales)) AS Normalized_ReturnMRP
from pharmasales;







 

    
