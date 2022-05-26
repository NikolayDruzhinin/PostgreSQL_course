create or replace function get_all_even_id() returns setof archaeologists as
$body$
declare
	r archaeologists%rowtype;
begin
	for r in
		select * from archaeologists where arch_id % 2 = 0
	loop
		return next r;
	end loop;
	return;
end;
$body$
language plpgsql;

select * from get_all_even_id();