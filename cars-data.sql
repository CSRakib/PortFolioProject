use cars;
-- Read data
select * from car_dekho;

-- total cars: to get a count of total records
select count(*) from car_dekho;


-- the manager asked how many car will be availabe in 2023
select count(*) from car_dekho where year= 2023;#6

-- the manager asked how many car will be availabe in 2020,2021,2022
select count(*) from car_dekho where year= 2020; #74
select count(*) from car_dekho where year= 2021; #7
select count(*) from car_dekho where year= 2022; #7

-- group by
select count(*) from car_dekho where  year in (2020,2021,2022) group by year;


-- clients asked me to print the total of all cars by year.. I dont see all the details..alter
select year,count(*) as total_car from car_dekho group by year;

-- clients ask to car dealer agent how many deisel cars will there in 2020
select count(*) from car_dekho where year = 2020 and fuel = "Diesel";

-- clients ask to car dealer agent how many deisel cars will there in 2021
select count(*) from car_dekho where year = 2020 and fuel = "petrol";

-- the manager told the employee to give a print all the fuels come by all the year--
select count(*) as petrol from car_dekho where fuel = "petrol" group by year;
select count(*) as Diesel from car_dekho where fuel = "Diesel" group by year;
select count(*) as CNG  from car_dekho where fuel = "CNG" group by year;

-- the manager said there were more  than 100 cars in a given year,which year had more than 100 car;
select year,count(*) from car_dekho group by year having count(*) >100;

-- the manager said to the employee all cars count details between 2015 and 2023; we need complete list;
select count(*) from car_dekho where year between 2015 and 2023;
-- the manager said to the employee all cars  details between 2015 and 2023; we need complete list;
select * from car_dekho where year between 2015 and 2023;