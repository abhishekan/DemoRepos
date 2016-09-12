create database TestDB

execute sp_helpdb TestDB

drop database TestDB

use TestDB

create table Department
(
	DepartmentID int primary key identity(1,1) not null,
	Name char(30) not null,
	Location char(30) null
)

sp_help Department

insert into Department(Name, Location)
values('HR', 'Pune')

select * from Department

update Department
set Name = 'Sales'
where DepartmentID = 1

create table Employee
(
	EmployeeID int identity,
	Name char(30) not null,
	City char(30) null default 'Pune',
	Phone bigint null unique,
	DepartmentID int
	--adding primary key
	constraint pk_empid primary key(EmployeeID),
	--adding foreign key
	constraint fk_deptid foreign key(DepartmentID) 
	references Department(DepartmentID)
	on delete cascade on update cascade,
	--adding check constraint
	constraint chk_city check(City in('Pune', 'Mumbai'))
)

sp_help Employee

insert into Employee(Name,City,Phone,DepartmentID)
values('Sachin', default, 123, 1)

insert into Employee(Name,City,Phone,DepartmentID)
values('Virat', 'Mumbai', 1234, 1)

update Department
set DepartmentID = 2
where DepartmentID = 1

delete from Department
where DepartmentID = 1

select * from Employee
