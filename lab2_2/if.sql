create or replace function raise_salary(key_ int, summ money) returns void as
$$
begin 
	loop
		update archaeologists set arch_salary = arch_salary + summ where arch_id = key_;
		
		if not found then
			raise notice 'Key is not found!';
		end if;
       	
		return;
	end loop;
end;
$$
language plpgsql;

select raise_salary(1, 50::money);
select raise_salary(11, 50::money);
		