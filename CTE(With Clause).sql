-- Q1) Print the number from 1 to 10 without using any built-in function
with recursive number as (select 1 as n
                          union
                          select n + 1
                          from number
                          where n < 10)
select *
from number;


--Q2) Find the hierarchy of employee under a given name 'Asha' using recursion
create table dvdrental.public.emp_details
(
    id          serial primary key,
    name        varchar(100),
    manager_id  integer,
    salary      integer,
    designation varchar
);

insert into dvdrental.public.emp_details(name, manager_id, salary, designation)
values ('shriprad', null, 10000, 'CEO'),
       ('satya', 5, 1400, 'S/W engg'),
       ('Jila', 5, 500, 'Data Analyst'),
       ('David', 5, 1800, 'Data Scientist'),
       ('Michael', 7, 30000, 'Manager'),
       ('Aravind', 7, 42000, 'Architect'),
       ('Asha', 1, 4200, 'CTO'),
       ('Maryam', 1, 3500, 'Manager'),
       ('reshma', 8, 2000, 'Business Analyst'),
       ('Akshay', 8, 2500, 'Java Analyst');

with recursive emp_hierarchy as (select id,name,manager_id,salary,designation, 1 as level
                                 from emp_details
                                 where name = 'Asha'
                                 union
                                 select E.id,E.name,E.manager_id,E.salary,E.designation, H.level + 1 AS level
                                 from emp_hierarchy H
                                          join emp_details E on H.id = E.manager_id)
select H.id,H.name,H.manager_id,H.salary,H.designation,H.level,E.name as manager_name
from emp_hierarchy H
         join emp_details E on E.id = H.manager_id;

-- Q3) Find the hierarchy of managers for the given employee "David"
select * from emp_details;

with recursive emp_hierarchy as (select id,name,manager_id,salary,designation, 1 as level
                                 from emp_details
                                 where name = 'David'
                                 union
                                 select E.id,E.name,E.manager_id,E.salary,E.designation, H.level + 1 AS level
                                 from emp_hierarchy H
                                          join emp_details E on H.manager_id = E.id)
select H.id,H.name,H.manager_id,H.salary,H.designation,H.level,E.name as manager_name
from emp_hierarchy H
         join emp_details E on E.id = H.manager_id;
