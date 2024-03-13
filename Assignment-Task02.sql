create database raw_material;
use raw_material;
alter table rm modify column rm_id  char(5) primary key;
alter table mapping modify column rm_id char(5);
alter table mapping add foreign key (rm_id) references rm(rm_id);

-- A. To get the total quantity of each rm(raw material) sold in each month.
select rm_id,month(str_to_date(date,'%d-%m-%y')) as month,sum(s.quantity)from sku s left join mapping m on s.sku=m.sku 
group by rm_id,month;

-- B. To get the name of vendors for each SKU
select m.sku,rm.rm_id,vendor_name from mapping m left join rm on m.rm_id=rm.rm_id;

-- C. Get the most used and least used raw material based on the SKU sold
select s.sku,m.rm_id,sum(s.quantity*m.quantity) from sku s left join mapping m on s.sku=m.sku group by s.sku,m.rm_id order by 3 ;
