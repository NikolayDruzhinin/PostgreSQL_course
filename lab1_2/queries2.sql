-- 3
select *
from items
where item_id in (select item_id
				 from findings
				 where finding_condition='good'
				 )
order by item_name;
-- Добавить оконные функции
-- имена таких археологов, которые нашли только 2 находки