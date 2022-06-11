create table alumnos(
numcontrol number (9) primary key,
apellidoPat varchar (20),
apellidoMat varchar (20),
nombre varchar (20),
edad number (3),
genero varchar (10)
);

create table bitacora(
usuario varchar (30),
fecha date,
operacion varchar (10),
tabla varchar (10),
numcontrol number (9),
old_edad number (3),
new_edad number (3)
);

drop table alumnos;
drop table bitacora;
select * from alumnos;
select * from bitacora;
delete from alumnos;
delete from bitacora;

create or replace trigger ingresar_alumnos
before insert
on alumnos
for each row
begin
insert into bitacora values(user,sysdate,'insert','alumnos',:new.numcontrol,:old.edad,:new.edad);
end ingresar_alumnos;

insert into alumnos values(18130534,'Arellano','Sanchez','Juan Jesus',22,'Masculino');
insert into alumnos values(18130533,'Arellano','Ramirez','Hector',22,'Masculino');
insert into alumnos values(18130568,'Lopez','Flores','Johan Ismael',22,'Masculino');
insert into alumnos values(17130033,'Gonzalez','Ibarra','Jose Luis',23,'Masculino');
insert into alumnos values(17130015,'Castellanos','Barron','Francisco Eduardo',23,'Masculino');
insert into alumnos values(17130016,'Castellanos','Barron','Carla',23,'Femenino');

create or replace trigger actualizar_alumnos
before update
on alumnos
for each row
begin
insert into bitacora values(user,sysdate,'update','alumnos',:new.numcontrol,:old.edad,:new.edad);
end actualizar_alumnos;

update alumnos set edad = 23 where numcontrol = 18130534;
select * from bitacora where numcontrol = 18130534;

create or replace trigger eliminar_alumnos
before delete 
on alumnos
for each row
begin
insert into bitacora values(user,sysdate,'delete','alumnos',:old.numcontrol,:old.edad,:new.edad);
end eliminar_alumnos;

delete from alumnos where numcontrol = 18130535;
select * from bitacora where numcontrol = 17130015;
---------------------------------------------------------------------------------------------------
select index_name, index_type, uniqueness
from user_indexes
where table_name='ALUMNOS';
  
create unique index alumnos_nombre
on alumnos(nombre); 

alter table alumnos
add constraint co_alumnos_nombre
unique (nombre);

insert into alumnos values(17130018,'Castellanos','Barron','Hector',23,'Masculino');

create index alumnos_edad
on alumnos(edad); 

insert into alumnos values(17130019,'Adame','Flores','Jesus',23,'Femenino');

create index alumnos_apellidos
on alumnos(apellidoPat,apellidoMat); 

select index_name,column_name,column_position
from user_ind_columns
where table_name='ALUMNOS';

select *from user_objects
where object_type='INDEX'; 

alter index SYS_C007805 monitoring usage;

select * from v$object_usage where table_name = 'ALUMNOS';

select * from alumnos where numcontrol = 18130534;
select * from alumnos where nombre = 'Juan Jesus';

alter index SYS_C007805 nomonitoring usage;

SELECT LAST_ANALYZED,table_name FROM ALL_INDEXES WHERE table_name='ALUMNOS';

Execute DBMS_STATS.gather_schema_stats('JUAN');

SELECT index_name, blevel,
DECODE(blevel,0,'OK BLEVEL',1,'OK BLEVEL',2,
'OK BLEVEL',3,'OK BLEVEL',4,'OK BLEVEL','BLEVEL HIGH') OK
FROM dba_indexes where table_name='ALUMNOS';

ALTER INDEX alumnos_nombre REBUILD;
ALTER INDEX SYS_C007805 REBUILD;

drop index alumnos_edad;
drop index alumnos_nombre;

select constraint_name, constraint_type, index_name
from user_constraints
where index_name='ALUMNOS_NOMBRE';
  
alter table alumnos
drop constraint co_alumnos_nombre;

select *from user_constraints where table_name='ALUMNOS';

select * from v$logfile;

ALTER SYSTEM SWITCH LOGFILE;

archive log list;

select * from user_sys_privs;

conn system as sysdba;


drop trigger actualizar_precio;
drop trigger eliminar_articulo;
drop trigger ingresar_articulo;
