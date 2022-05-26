-- 2
select arch_name, arch_salary
from archaeologists
where arch_id in (select arch_id 
	   from findings
	   where finding_place='Italy'
	   ) and arch_salary > 2000::money
order by arch_name;