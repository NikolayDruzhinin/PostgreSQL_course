------------------------------- 1 ------------------------------
create role test;
drop role test;
------------------------------- 2 ------------------------------
grant update, select, insert on	archaeologists to test;
grant select(arch_id), update(finding_data) on findings to test;
grant select on items to test;
grant select on old_findings to test;

set role test;
set role postgres;
----------------------------------------------------------------
delete from archaeologists
where arch_salary < 1000::money;

select * from findings;

delete from items
where item_owner = 'Warrior';
------------------------------- 3 ------------------------------
--археологи, которые обнаружили находки до 2000-го года (включить сами находки и даты)
-- Выдать права для test

drop view if exists old_findings;

create view old_findings as 
select arch_name, item_name, finding_data from archaeologists
inner join findings on archaeologists.arch_id = findings.arch_id
inner join items on findings.item_id = items.item_id
where finding_data < '1900-01-01'::date;

select * from old_findings;
----------------------------------------------------------------
-- расположить имена археологов по рангу в соответствии с количеством найденных находок
create view who_get_grant as
select arch_name,
count(arch_id) 

