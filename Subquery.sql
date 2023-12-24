----Sub query (classified as inner query & outer query---
/*
There are 2 types of sub query
1) Correlated Sub query
        -> First outer query got executed then inner query got executed.
        -> Inner query is depends on a outer query
2) Non-Correlated Sub query
        -> Vice Versa of correlated Sub query.
        2 types of non-correlated sub query
            1) Single Valued Non-correlated sub query.
            2) Multi Valued Non-correlated sub query.
*/

-- Co-Related Sub query
-- Eg.1
select *
from public.customer
where address_id = (select address_id from public.address where address.address_id = customer.address_id);
--Here the outer query is based on inner query.

-- Single Value Non-Correlated sub query.
select *
from public.city
where country_id = (select country_id from public.country where country.country = 'India');

-- Multi Value Non-Correlated Sub query
-- Eg.2
-- Query : To find the 2nd largest maximum amount from payment table
-- Solution 1: Multi Value Non-Correlated Sub query
select p.*
from payment p
where p.amount = (select max(p1.amount)
                  from payment p1
                  where p1.amount <
                        (select max(p2.amount)
                         from payment as p2));

-- Solution 2: The problem with 1st solution is we can not write large number of query to find
-- the 40th largest maximum amount.
select p.*
from payment p
where 2 = (select count(distinct p1.amount)
           from payment p1
           where p1.amount > p.amount);
