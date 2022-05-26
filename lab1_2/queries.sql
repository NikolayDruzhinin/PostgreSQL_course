-- 1
select * 
from archaeologists
where arch_salary > 5000::money
order by arch_name
limit 3;
