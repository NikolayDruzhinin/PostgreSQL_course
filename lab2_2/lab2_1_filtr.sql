create or replace function get_objects(d date, n varchar(50))
returns table(year date, founder varchar(50), item varchar(50)) as $$
	select finding_data, arch_name, item_name from findings
	inner join archaeologists on archaeologists.arch_id = findings.arch_id
	inner join items on findings.item_id = items.item_id
	where finding_data = $1 and arch_name = $2;
$$ language sql;

select get_objects('1924-11-04', 'Nikolas');