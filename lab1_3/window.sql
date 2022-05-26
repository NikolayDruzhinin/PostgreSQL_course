select arch_name, arch_salary, arch_qualification,
rank() over (partition by arch_qualification order by arch_salary) as rank,
max(arch_salary) over () as max_salary
from archaeologists;