-- Read commeted
begin;
update archaeologists set arch_salary = arch_salary +1::money
where arch_salary < 2500::money;
select * from archaeologists for update;
commit;
rollback;

--Repeatable read
begin transaction isolation level Repeatable Read;
insert into findings (arch_id, item_id, finding_type, finding_place, finding_data, finding_condition)
values
(2, 4, 'Ruins', 'Egypt', '2022-05-12', 'good');
select * from findings;