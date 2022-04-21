create database QHVinh
go
use QHVinh
go
create table [user](
	id int not null primary key,
	name nvarchar(100) not null,
	gender bit default 1,
	roleID int default 1,
	password nvarchar(10) not null
);
create table [teacher_role](
	id int identity(1,1) primary key,
	name nvarchar(50)
);
create table teacher(
	userid int foreign key references [user](id)  on delete cascade on update cascade,
	roleid int foreign key references [teacher_role](id)  on delete cascade on update cascade
);
create table [classroom](
	id nvarchar(5) primary key
);
create table classroom_detail(
	id nvarchar(5) foreign key references [classroom](id) on delete cascade on update cascade,
	userid int foreign key references [user](id) on delete cascade on update cascade
);
create table notice(
	id int identity(1,1) primary key,
	createdBy int foreign key references [user](id)  on delete cascade on update cascade,
	title nvarchar(255),
	describe nvarchar(max),
	classid nvarchar(5) foreign key references [classroom](id)  on delete cascade on update cascade,
	publicAt datetime default getDate(),
	isTask bit default 0,
	deadline datetime null
);
create table task_work(
	id int foreign key references notice(id)  on delete  NO ACTION on update  NO ACTION,
	userid int foreign key references [user](id)  on delete  NO ACTION on update  NO ACTION,
	work  int identity(1,1) primary key,
	mark int default -1,
	comment text,
	doneAt datetime default getDate()
);
create table work_detail(
	workid int references task_work(work)  on delete  NO ACTION on update  NO ACTION,
	work nvarchar(max)
);
insert into [user](id,name,roleID,gender,password) values (0,N'Phạm Thu Hương',0,0,0),(1901781017,N'Lô Căm Sánh Anh',1,0,'150049')
insert into [teacher_role] (name) values (N'Maths'),(N'Literature'),(N'History'),(N'Geography'),(N'Civic Education'),(N'Physics'),(N'Chemistry'),(N'Biology')
insert into classroom values ('10A1')
insert into classroom_detail values('10A1',1901781017)
INSERT INTO Notice (createdBy,title,describe,classid,publicAt,isTask) VALUES (0,'REGARDING PE - WDU202c','<div class="gmail_default">
 <div class="gmail_default"><span style="font-size:large"><span style="font-family:garamond,&quot;times new roman&quot;,serif"><span style="color:#444444">Dear all,&nbsp;</span></span></span></div>
 
 <div class="gmail_default"><span style="font-size:large"><span style="font-family:garamond,&quot;times new roman&quot;,serif"><span style="color:#444444">&nbsp;A few students had been contacting me regarding the&nbsp;clarification of &quot;How to submit the answer sheet of PE&quot;. I thought I will send an email officially&nbsp;so that it will be helpful&nbsp;for each one of you.&nbsp;</span></span></span></div>
 
 <div class="gmail_default">&nbsp;</div>
 
 <div class="gmail_default"><span style="font-size:large"><span style="font-family:garamond,&quot;times new roman&quot;,serif"><span style="color:#444444">Please note:</span></span></span></div>
 
 <div class="gmail_default">
 <ol>
 	<li><span style="font-size:large"><span style="font-family:garamond,&quot;times new roman&quot;,serif"><span style="color:#444444"><span style="font-family:garamond,times new roman,serif"><span style="font-size:large"><span style="color:#444444">The function to be re-designed will be mentioned clearly&nbsp;in the question paper. If the prototype is required, that will also be mentioned. So you only need to create a&nbsp;</span>prototype<span style="color:#444444">&nbsp;for&nbsp;</span><strong><span style="color:#ff0000">that particular function</span></strong><span style="color:#444444">.&nbsp;</span></span></span></span></span></span></li>
 	<li><span style="font-size:large"><span style="font-family:garamond,&quot;times new roman&quot;,serif"><span style="color:#444444"><span style="font-family:garamond,times new roman,serif"><span style="font-size:large"><span style="color:#444444">I hope you remember&nbsp;how to design a&nbsp;</span><strong><span style="color:#ff0000">sitemap</span></strong><span style="color:#444444">&nbsp;(1 of your assignments in coursera). There might be a question to draw a sitemap for the &quot;re-designed website&quot;.&nbsp;</span></span></span></span></span></span></li>
 	<li><span style="font-size:large"><span style="font-family:garamond,&quot;times new roman&quot;,serif"><span style="color:#444444"><span style="font-family:garamond,times new roman,serif"><span style="font-size:large"><span style="color:#444444">Submission - the entire answer sheet can be made as a&nbsp;</span><strong><span style="color:#ff0000">single PDF</span></strong><span style="color:#444444">. You can write the answers in that&nbsp;</span><strong>and</strong><span style="color:#444444">&nbsp;also at the last, you can copy paste the PROTOTYPE link to it. &nbsp;</span></span></span></span></span></span></li>
 </ol>
 
 <div><span style="font-size:large"><span style="font-family:garamond,&quot;times new roman&quot;,serif"><span style="color:#444444"><span style="color:#444444"><span style="font-family:garamond,times new roman,serif"><span style="font-size:large">In case of any doubts, you can message me on facebook/ email me&nbsp;here.&nbsp;</span></span></span></span></span></span></div>
 
 <div>&nbsp;</div>
 
 <div><span style="font-size:large"><span style="font-family:garamond,&quot;times new roman&quot;,serif"><span style="color:#444444"><span style="color:#444444"><span style="font-family:garamond,times new roman,serif"><span style="font-size:large">Thank you ! All&nbsp;the best!</span></span></span></span></span></span></div>
 
 <div>&nbsp;</div>
 </div>
 </div>
 
 <div>
 <div dir="ltr">
 <div dir="ltr">
 <div style="text-align:start">
 <div><span style="font-size:small"><span style="color:#222222"><span style="font-family:Arial,Helvetica,sans-serif"><span style="background-color:#ffffff"><span style="color:#444444"><span style="font-family:arial black,sans-serif"><strong>Ms. Shruthi T. Gopi</strong></span></span></span></span></span></span></div>
 
 <div><span style="font-size:small"><span style="color:#222222"><span style="font-family:Arial,Helvetica,sans-serif"><span style="background-color:#ffffff"><span style="color:#666666"><span style="font-family:arial,sans-serif"><strong>Graphic Design Lecturer</strong></span></span></span></span></span></span></div>
 
 <div>&nbsp;</div>
 
 <div><span style="font-size:small"><span style="color:#222222"><span style="font-family:Arial,Helvetica,sans-serif"><span style="background-color:#ffffff"><span style="font-family:arial,sans-serif"><span style="color:#cfe2f3">___________________________</span></span></span></span></span></span></div>
 
 <div>&nbsp;</div>
 
 <div><span style="font-size:small"><span style="color:#222222"><span style="font-family:Arial,Helvetica,sans-serif"><span style="background-color:#ffffff"><span style="color:#666666"><span style="font-family:georgia,serif"><strong><span style="background-color:#ffffff">FPT</span>&nbsp;UNIVERSITY</strong></span></span></span></span></span></span></div>
 
 <div><span style="font-size:small"><span style="color:#222222"><span style="font-family:Arial,Helvetica,sans-serif"><span style="background-color:#ffffff"><span style="color:#999999"><span style="font-family:garamond,times new roman,serif"><em>Add: Education zone, Hao High Tech Park,</em></span></span></span></span></span></span></div>
 
 <div><span style="font-size:small"><span style="color:#222222"><span style="font-family:Arial,Helvetica,sans-serif"><span style="background-color:#ffffff"><span style="color:#999999"><span style="font-family:garamond,times new roman,serif"><em>Km 29 Thang Long highway, Thach That ward, Hanoi.</em></span></span></span></span></span></span></div>
 
 <div><span style="font-size:small"><span style="color:#222222"><span style="font-family:Arial,Helvetica,sans-serif"><span style="background-color:#ffffff"><span style="font-family:garamond,times new roman,serif"><em><span style="color:#999999">phone :&nbsp;</span><span style="color:#9fc5e8">+840879384421</span></em></span></span></span></span></span></div>
 </div>
 </div>
 </div>
 </div>
 ','10A1',convert(datetime,'18-06-12 10:34:09',5),0)