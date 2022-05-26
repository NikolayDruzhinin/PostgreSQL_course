create or replace function my_func() 
returns trigger as $$
	begin
		if (new.finding_data > now()) then
			raise exception '% incorrect date', new.finding_data;
		end if;
		
		if (new.finding_condition != 'average' or
		   new.finding_condition != 'good' or
		   new.finding_condition != 'bad') 
		then
		    raise exception '% incorrect finding condition', new.finding_condition;
		end if;
	end;
$$ LANGUAGE plpgsql;

create trigger test_trigger 
before insert or update on findings
for each row 
execute function my_func();