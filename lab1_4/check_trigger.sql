begin ;
insert into findings 
(arch_id, item_id, finding_type, finding_place, finding_data, finding_condition)
values
(2, 4, 'Ruins', 'Egypt', '2022-05-12', 'good!!!'),
(2, 4, 'Ruins', 'Egypt', '20222-05-12', 'good');;
commit;
rollback;
select * from findings;

