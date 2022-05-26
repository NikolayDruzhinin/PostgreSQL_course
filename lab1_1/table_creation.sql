create table archaeologists (
            arch_id serial primary key,
            arch_name varchar(50) NOT NULL,
            arch_salary money NOT NULL,
            arch_qualification varchar(50) NOT NULL,
            arch_specialization varchar(50) NOT NULL
        );
        
        create table items (
            item_id serial primary key,
            item_value money NOT NULL,
            item_era varchar(50) NOT NULL,
            item_name varchar(50) NOT NULL,
            item_owner varchar(50) NOT NULL
        );
        
        create table findings (
            finding_id serial primary key,
            foreign key (arch_id) references archaeologists (arch_id),
            foreign key (item_id) references items (item_id),
            finding_type varchar(50) NOT NULL,
            finding_place varchar(50) NOT NULL,
            finding_data date NOT NULL,
            finding_condition varchar(50) NOT NULL
        );