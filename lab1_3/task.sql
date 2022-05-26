-- имена таких археологов, которые нашли только 2 находки

select arch_id, arch_name
from archaeologists
where arch_id in (select distinct arch_id
				  from (select arch_id,
	 	 		  count(arch_id) over (partition by arch_id) as count_
				  from findings) as ss
				  where count_ = 2);