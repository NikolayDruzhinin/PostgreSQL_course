--+----------------------+-----------------------+----------------------+-----------------------+----------------------+
--|Уровень изоляции	     | «Грязное» чтение      | Неповторяемое чтение |   Фантомное чтение    | Аномалия сериализации|
--+----------------------+-----------------------+----------------------+-----------------------+----------------------+
--| Read uncommited 	 |  Допускается (не PG)  |       Возможно	    |      Возможно         |       Возможно       |
--| Read committed 		 |	Невозможно	         |       Возможно       |	   Возможно	        |       Возможно       |
--| Repeatable read      |	Невозможно	         |       Невозможно     |	Допускается (не PG) |	    Возможно       |
--| Serializable         |	Невозможно	         |       Невозможно	    |      Невозможно	    |       Невозможно     |
--+----------------------+-----------------------+----------------------+-----------------------+----------------------+

-- Read commeted
begin;
update archaeologists set arch_salary = arch_salary + 5::money
where arch_salary < 2500::money;
select * from archaeologists;
commit;
rollback;

--Repeatable read
begin transaction isolation level Repeatable Read;
select *
from findings
where finding_place = 'Egypt';
commit;

--Serializable
begin transaction isolation level Serializable;
