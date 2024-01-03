-- import the CSV File
copy superstore3 from 'C:\Users\Shivam\Desktop\superstore145.csv'
delimiter ',' csv header;

-- Fetch the data

select * from superstore3;

-- Checking NULL values & Treat it

select * from superstore3
where "Order ID" is null;

delete from superstore3
where "Order ID" is null;

select * from superstore3
where "Postal Code" is null;

update superstore3
set "Postal Code" = 05401
where "Postal Code" is null;

select * from superstore3
where "Postal Code" = 05401;

-- inconsist Dates treat & convert to type date

alter table superstore3
alter column "Order Date" type date
using (
case
when "Order Date" ~ '/' then to_date("Order Date", 'MM/DD/YYYY')
when "Order Date" ~ '-' then to_date("Order Date", 'MM-DD-YYYY')
else to_date("Order Date", 'YYYY-MM-DD')
end
	);
	
alter table superstore3
alter column "Ship Date" type date
using (
case
when "Ship Date" ~ '/' then to_date("Ship Date", 'MM/DD/YYYY')
when "Ship Date" ~ '-' then to_date("Ship Date", 'MM-DD-YYYY')
else to_date("Ship Date", 'YYYY-MM-DD')
end
	);