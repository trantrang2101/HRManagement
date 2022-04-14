create database QHVinh
go
use QHVinh
go
create table [user](
	id int not null primary key,
	name nvarchar(100) not null,
	gender bit default 1,
	roleID int,
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
	publicAt datetime default getDate(),
	isTask bit default 0,
	deadline datetime null
);
create table task_work(
	id int foreign key references notice(id),
	userid int foreign key references [user](id),
	work nvarchar(255) not null,
	mark int default -1,
	comment text,
	doneAt datetime default getDate()
);
insert into [user](id,name,roleID,gender) values (0,'admin',0,1)
insert into login values(0,'1')