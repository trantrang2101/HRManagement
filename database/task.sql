create database QHVinh
go
use QHVinh
go
create table [user](
	id int identity(1,1) not null primary key,
	name nvarchar(100) not null,
	gender bit default 1,
	dob date,
	roleID int,
);
create table [login](
	username int foreign key references [user](id),
	password nvarchar(10) not null
);
create table [classroom](
	id int identity(1,1) primary key,
	name nvarchar(2)
);
create table classroom_detail(
	classid int foreign key references [classroom](id),
	userid int foreign key references [user](id)
);
create table notice(
	id int identity(1,1) primary key,
	createdBy int foreign key references [user](id),
	title nvarchar(50),
	describe text,
	classid int foreign key references [classroom](id),
	createdAt datetime default getDate()
);
create table task(
	id int foreign key references notice(id),
	deadline datetime,
);
create table task_work(
	userid int foreign key references [user](id),
	work nvarchar(255) not null,
	mark int default -1,
	doneAt datetime default getDate()
);
insert into [user](name,dob,roleID,gender) values ('admin','1920-09-02',0,1)
insert into login values(1,'1')