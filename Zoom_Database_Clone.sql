#---------Amit Levy ID206841496---------------

create schema Zoom_Database;
use Zoom_Database;
# --------------Table Creation--------------
create table User_Table
(UID int not null auto_increment,
name varchar(50) not null,
Email varchar(50) not null,
password varchar(50) not null,
isPremium boolean,
primary key(UID));

create table Meeting_Table
(MID int not null auto_increment,
Link varchar(50) not null,
Host_ID int not null,
Meeting_Date date, 
Meeting_Name varchar(50),
duration timestamp,
isRecorded boolean,
Meeting_Password varchar(50),
numOfParticipants int,
primary key(MID),foreign key(Host_ID) references User_Table(UID));

create table Meeting_Ops
(MID int not null,
enable_Video boolean,
enable_Mic boolean,
enable_Sharing boolean,
foreign key(MID) references Meeting_Table(MID));

create table Chat
(Chat_ID int not null auto_increment,
MID int not null,
primary key(Chat_ID),
foreign key(MID) references Meeting_Table(MID));

create table Message
(Chat_ID int not null,
sentByID int not null,
sentToID int,
isPrivateMessage boolean,
messageDesc varchar(1000),
meassageTime timestamp,
foreign key(Chat_ID) references Chat(Chat_ID));

create table Invitation
(Link varchar(50),
MID int not null,
UID int not null,
startingDate date,
endingDate date,
isValid boolean,
primary key(Link),
foreign key(MID) references Meeting_Table(MID),
foreign key(UID) references User_Table(UID));

create table ParticipantMeetingTB
(PID int not null,
MID int not null,
primary key(PID,MID));

create table HostMeetingTB
(HID int not null,
MID int not null,
primary key(HID,MID));

# --------------Alter Tables--------------
alter table Meeting_Table 
add unique(Host_ID , link);

alter table HostMeetingTB 
add unique(HID , MID);

alter table Meeting_Table
drop column duration;

alter table Meeting_Table
add column duration time;

# --------------Insertion To Tables--------------

# Inserting colleges lecturers to database
insert into User_Table(Name , Email , password , isPremium) 
values ('Amit' , 'amit.afeka@gmail.com' , 'amit879' , TRUE),
('Omri' , 'Omri.afeka@gmail.com' , 'omri123' , TRUE),
('Igal' , 'Igal@afeka.com' , 'igal1234' , TRUE);

# Inserting colleges students to database
insert into User_Table(Name , Email , password , isPremium)
values ('Tal' , 'tal.afeka@gmail.com' , 'tal879' , false),
('tor' , 'tor.afeka@gmail.com' , 'tor0923' , false),
('Dvir' , 'dvir@afeka.com' , 'dvir5647' , false),
('grigory' , 'grigory.afeka@gmail.com' , 'grigory4324er' , false),
('efrat' , 'efrat@afeka.com' , 'love5647' , false);

# Inserting lectures meetings to database
#MID, Link, Host_ID*, meeting_Date, name,duration, isRecorded, password
insert into Meeting_Table(Link , Host_ID , Meeting_Date , Meeting_Name , duration , isRecorded , Meeting_Password , numOfParticipants)
values ('https://afeka.zoom.us/j/94854094525' , 1 , STR_TO_DATE('06-01-2021', '%d-%m-%Y') , 'Data Structure' , '2' , TRUE , null , 30),
('https://afeka.zoom.us/j/93425895698' , 2 , STR_TO_DATE('07-01-2021', '%d-%m-%Y') , 'Database' , '3' , TRUE , '800811' , 30),
('https://afeka.zoom.us/j/96587172215' , 3 , STR_TO_DATE('08-01-2021', '%d-%m-%Y') , 'Java OOP' , '4' , TRUE , null , 30),
('https://afeka.zoom.us/j/8746258841' , 2 , STR_TO_DATE('16-01-2021', '%d-%m-%Y') , 'C Programming' , '3:0' , false , 845692 , 23);

# Inserting messages between students in a meeting
#Chat_ID ,sentByID ,sentToID ,isPrivateMessage ,messageDesc,meassageTime
insert into Message(Chat_ID ,sentByID ,sentToID ,isPrivateMessage ,messageDesc,meassageTime)
values(1,'1',null,false,'קיצר מתי נגמר הסמסטר הזה?', current_timestamp()),
(1,'2',null,false,'מסתיים ב 14.1.2021', current_timestamp()),
(1,'1','2',true,'תודה רבה', current_timestamp()),
(1,'6',null,false,'such a boring class', '2021-01-16 10:30:11'),
(1,'8','6',true,'אפשר לעשות איתך את המטלה?? משלם לך', '2021-01-16 10:36:41'),
(1,'7','4',true,'שיעור משעמם רצח', '2021-01-16 10:45:45'),
(1,'5',null,false,'למישהו יש קישור לשיעור הבא?', '2021-01-16 10:58:34');

#MID,enable_Video, enable_Mic ,enable_Sharing
insert into meeting_ops(MID,enable_Video, enable_Mic ,enable_Sharing)
values(1 , true , true , true) ,
(2 , true , false , true),
(3 , true , true , false),
(4 , false , false , false);

insert into chat(chat_id,mid)
values(1 , 1),(2 , 2),(3 , 3),(4 , 4);

insert into ParticipantMeetingTB(PID,MID)
values (4 ,1),(5 ,1),(6 ,1),(7 ,1),(8 ,1);

insert into HostMeetingTB(HID,MID)
values (1 ,1),(2 ,2),(3 ,3);

# -----------Workspace Insert-------------
# Inserting Bosses to database
insert into User_Table(Name , Email , password , isPremium) 
values ('Oren' , 'oren@wix.com' , 'oren974' , TRUE),
('Moshe' , 'moshe@wix.com' , '9854762' , TRUE),
('Loren' , 'loren@wix.com' , 'ilovehellokitty' , TRUE);

# Inserting employees to database
insert into User_Table(Name , Email , password , isPremium)
values ('Israel' , 'israelKatz@yahoo.com' , 'kalkla' , false), # 12 - 17
('Benyamin' , 'onlyfansbibi@yahoo.com' , 'headminester' , false),
('Miri' , 'miri@yahoo.com' , 'tarbot' , false),
('Rafi' , 'saar@gmail.com' , '23426534' , false),
('Haim' , 'etgar@gmail.com' , '9715647' , false);

#Candidate for job interview
insert into User_Table(Name , Email , password , isPremium)
values ('Yuval' , 'yuval@walla.com' , 'seekingjob' , false);

# Inserting bussines meeting to database
#MID, Link, Host_ID*, meeting_Date, name,duration, isRecorded, password
insert into Meeting_Table(Link , Host_ID , Meeting_Date , Meeting_Name , duration , isRecorded , Meeting_Password , numOfParticipants)
values ('https://afeka.zoom.us/j/948525' , 9 , STR_TO_DATE('29-01-2021', '%d-%m-%Y') , 'Data Transfer' , '2:00' , TRUE , null , 4),  # 5- 8
('https://afeka.zoom.us/j/9345698' , 10 , STR_TO_DATE('23-02-2021', '%d-%m-%Y') , 'Uploading New App' , '1:00' , TRUE , '44811' , 5),
('https://afeka.zoom.us/j/962215' , 10 , STR_TO_DATE('12-02-2021', '%d-%m-%Y') , 'Exit' , '2:30' , TRUE , null , 6),
('https://afeka.zoom.us/j/87841' , 11 , STR_TO_DATE('12-02-2021', '%d-%m-%Y') , 'Job Interview' , '3:0' , false , 84565 , 2);

insert into chat(chat_id,mid)
values(5 , 5),(6 , 6),(7 , 7),(8 , 8);

# Inserting messages between students in a meeting
#Chat_ID ,sentByID ,sentToID ,isPrivateMessage ,messageDesc,meassageTime
insert into Message(Chat_ID ,sentByID ,sentToID ,isPrivateMessage ,messageDesc,meassageTime)
values(5,'13',null,false,'באיזה תוכנה משתמשים', '2021-01-29 10:30:11'),
(6,'14',null,false,'יש בונוס לחגים?', '2021-01-29 10:31:11'),
(6,'15','14',true,'כן', '2021-01-29 10:32:11'),
(7,'16',null,false,'כמה הם מציעים?', '2021-02-12 12:37:31'),
(7,'10','16',true,'1,788,444,100', '2021-02-12 12:38:31'),
(7,'16','10',true,'מצויין', '2021-02-12 12:39:31'),
(8,'11',null,false,' אתה שומע אותי? ', '2021-02-12 12:39:31');

#MID,enable_Video, enable_Mic ,enable_Sharing
insert into meeting_ops(MID,enable_Video, enable_Mic ,enable_Sharing)
values(5 , true , true , false),
(6 , true , false , false),
(7 , true , true , false),
(8 , true , true , true);

insert into HostMeetingTB(HID,MID)
values (9 ,5),(10 ,6),(10 ,7),(11 ,8);

insert into ParticipantMeetingTB(PID,MID)
values (14 ,5),(15 ,5),(16 ,5),(13 ,5),
(12 ,6),(14 ,6),(15 ,6),(16 ,6),(13 ,6),
(13 ,7),(12 ,7),(14 ,7),(15 ,7),(16 ,7),(17,8);

#Link ,MID ,UID ,startingDate,endingDate ,isValid 
insert into Invitation(link ,MID , uid)
select link, mid , host_id
from meeting_table;
# --------------Updating Tables & Delete--------------
update Invitation
set startingDate = STR_TO_DATE('01-11-2020', '%d-%m-%Y') , endingDate = STR_TO_DATE('01-11-2021', '%d-%m-%Y'), isValid = true
where mid = 1;

update Invitation
set startingDate = STR_TO_DATE('01-11-2020', '%d-%m-%Y') , endingDate = STR_TO_DATE('30-03-2021', '%d-%m-%Y'), isValid = true
where mid = 2;

update Invitation
set startingDate = STR_TO_DATE('01-11-2020', '%d-%m-%Y') , endingDate = STR_TO_DATE('30-03-2021', '%d-%m-%Y'), isValid = true
where mid = 3;

update meeting_table
set meeting_table.numOfParticipants = 
(select count(pid) as numOfParticipants 
from participantmeetingtb where mid = 1) 
where Host_id = 1;

update meeting_table
set meeting_table.duration = '2:0' 
where Host_id = 1;

update meeting_table
set meeting_table.duration = '3:0' 
where meeting_password = 800811;

update meeting_table
set meeting_table.duration = '4:0' 
where Host_id = 3;

update HostMeetingTB
set hid= 1 
where mid = 1;

delete from HostMeetingTB where hid = 1 and mid = 2;

delete from message where message.meassageTime = '2021-01-12 18:24:50';

# --------------Select--------------
# --------General Selection---------
select *
from User_Table;

select *
from ParticipantMeetingTB
order by mid;

select *
from HostMeetingTB;

select * 
from Meeting_Table;

select *
from chat;

select * 
from message;

select * 
from Invitation
ORDER BY mid;

select * 
from meetingLinks;

select * from Students;

select * from Employees order by meetingid;

SELECT * FROM Lecturers;

SELECT * FROM Bosses;

#  --------View Creation---------
create view MeetingLinks as
select MID , Link
from meeting_table;

#create view that shows students
create view Students as
select PID as StudentID , MID as MeetingID
from ParticipantMeetingTB
where MID >= 1 and MID <= 4;

#create view that shows employees
create view Employees as
select PID as EmployeeID , MID as MeetingID
from ParticipantMeetingTB
where MID >= 5 and MID <= 8;

#create view that shows lecturers
create view Lecturers as
select HID as lecturerID , MID as MeetingID
from HostMeetingTB
where MID >= 1 and MID <= 4;

#create view that shows bosses
create view Bosses as
select HID as bossID , MID as MeetingID
from HostMeetingTB
where MID >= 5 and MID <= 8 ;

#  --------Complex Selections---------
# Report on students that find the class boring
select sentbyid as ID , user_table.name as boredStudent , messageDesc 
from Message inner join user_table
where (messageDesc like '%משעמם%' or messageDesc like '%boring%') and (Message.sentbyid = uid);

#show who uses gmail
select  uid ,name , email 
from user_table
where email like '%gmail%';

#show company bosses
select  uid ,name , email 
from user_table
where email like '%wix%';

#show meeting setting for each meeting
select *
from meeting_table , meeting_ops
where meeting_table.mid = meeting_ops.mid;

#show lecturers that teach less than 3 hours
select duration  Meeting_Name , user_table.name
from meeting_table inner join hostmeetingtb inner join user_table
where duration <'3:0' and hostmeetingtb.hid = user_table.uid and meeting_table.mid=hostmeetingtb.mid;

#shows students details
select *
from students inner join user_table
where uid = studentID 
order by meetingid;

#shows employees details
select *
from employees inner join user_table
where uid = EmployeeID
order by meetingid;

#find private messages between employees
select distinct sentbyid , sentToId , messagedesc
from Message 
where isPrivateMessage = 1 and sentByID = any(select EmployeeID from Employees);

#find private messages between students
select distinct sentbyid , sentToId , messagedesc
from Message 
where isPrivateMessage = 1 and sentByID = any(select StudentID from Students);

#show how many time each employee participate in a meeting
select employeeid ,count(meetingId) as TimesParticipateInMeeting
from employees
group by employeeid;

#Boss hosting the most meeting
select bossID , name, max(TimesHosting) as TimesHosting
from (select user_table.name ,bossID , count(meetingid) as TimesHosting
		from bosses inner join user_table
		where bossID = uid
		group by bossid
        order by timeshosting desc) as MostTimeHosting;
        
select employeeID , name, max(TimesChatting) 
from (select employeeID , name , count(chat_id) as TimesChatting
		from Message inner join employees inner join user_table
		where sentByID = employees.employeeid and chat_id = meetingid and uid = employees.employeeid
		group by sentByID
        order by TimesChatting desc) as MostTimeHosting;

#count the number of messages each student wrote
select sentByID ,name ,  count(sentByID)
from Message inner join students inner join user_table
where sentByID = students.StudentID and chat_id = meetingid and uid = students.StudentID
group by sentByID
order by sentbyid;

#count the number of messages each employee wrote
select sentbyid , name , count(chat_id)
from Message inner join employees inner join user_table
where sentByID = employees.employeeid and chat_id = meetingid and uid = employees.employeeid
group by sentByID
order by sentbyid;

#show the messages each student wrote
select chat_id , sentbyid , senttoid , messagedesc
from Message inner join students
where sentByID = students.StudentID and chat_id = meetingid;

#show the messages each employee wrote
select chat_id , sentbyid , senttoid , messagedesc
from Message inner join employees
where sentByID = employees.employeeid and chat_id = meetingid;
