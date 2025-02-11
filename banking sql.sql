create database banking;
use banking;
create table customers(
cust_id int primary key,
first_name varchar(50),
last_name varchar(50),
Email varchar(50),
Phonenumber varchar(13),
Address varchar(50));
-- Accounts table
create table accounts(
account_id int primary key,
cust_id int,
account_type varchar(50),
accountnumber varchar(50),
balance int,
accountstatus varchar(40),
constraint fk_cust_id foreign key(cust_id) references customers(cust_id)); 
-- Transaction table
create table transactions(
transa_id int primary key,
account_id int,
transa_date date,
transa_type varchar(30),
amount int,
balance int,
transa_status varchar(40),
constraint fk_account_id foreign key(account_id) references accounts(account_id));
-- Branch table
create table branch(
branch_id int primary key,
branch_name varchar(50),
location varchar(50),
Phonenumber varchar(14));
-- Employee table
create table employee(
emp_id int primary key,
branch_id int,
first_name varchar(50),
last_name varchar(50),
Address varchar(40),
job varchar(50),
Email varchar(50),
Phonenumber varchar(15),
constraint fk_branch_id foreign key(branch_id) references branch(branch_id));

insert into customers (cust_id,first_name,last_name,Email,Phonenumber,Address) 
values(1,'Anbu','merceya','anbumer2000@gmail,com',8745909548,'villupuram'),
(2,'john','micheal','johnmichel2021@gmail.com',9785649302,'pondy'),
(3,'harish','ragaw','harishragaw20001@gmail.com',6369409831,'thiruvanamalai'),
(4,'chandhru','jeeva','chandhru20g@gmail.com',8650437821,'villupuram'),
(5,'amalore','mary','amaloremary1234@gmail.com',7698432106,'pondy'),
(6,'stephy','Ansaleen','stephyansaleen2000@gmail.com',8667696879,'chennai'),
(7,'char','preetha','charu54preetha@gmail.com',7689432109,'velcherry'),
(8,'arokia','raj','arokia294raju@gmail.com',9176640855,'kovalam'),
(9,'anto','jovita','antojovita3000@gmail.com',7696504322,'thiruvanamalai');
select* from customers;
insert into accounts (account_id,cust_id,account_type,accountnumber,balance,accountstatus)
values(102,1,'checking account',65895320143688,5000,'active'),
(103,2,'saving account',3757427591234034,2000,'active'),
(104,3,'business account',886683273112779,1000,'active'),
(105,4,'checking account',9865634148104427,200,'active'),
(106,5,'saving account',475668721989077,3000,'active'),
(107,6,'business account',5879722360822,6000,'inactive'),
(108,7,'saving account',9807322366740830,10000,'active'),
(109,8,'checking account',2801860837584,2000,'active'),
(110,9,'saving account',677427591234034,1000,'active');
select*from accounts;
insert into transactions (transa_id,account_id,transa_date,transa_type,amount,balance,transa_status)
values(201,102,'2000-09-23','deposit',15000,10000,'active'),
(202,103,'2003-01-09','withdrawal',30000,20000,'active'),
(203,104,'2002-04-06','deposit',5000,1000,'active'),
(204,105,'2011-08-14','withdrawal',10000,2000,'active'),
(205,106,'2023-04-01','deposit',15000,10000,'active'),
(206,107,'2020-02-02','withdrawal',4000,2000,'active');
select* from transactions;
insert into branch(branch_id,branch_name,location,Phonenumber)
values(001,'HDFC bank','velchery',878684073414),
(002,'ICIC bank','thambaram',6863072072),
(003,'Indian bank','thambaram',279555708218),
(004,'Axis bank','thambaram',97642470174473),
(005,'bank of baroda','thambaram',489828718304),
(006,'punjab national bank','thambaram',9723088721484);
select* from branch;

insert into employee(emp_id,branch_id,first_name,last_name,Address,job,Email,Phonenumber)
values(411,001,'nandhini','indira','villupuram','IT','nandhini222@gmail.com',9125434283),
(412,002,'kaviya','murugan','pondy','HR','kaviyamurugan@222gmail.com',8665893402),
(413,003,'stephy','ansaleen','velchery','IT','stephy2003@gmail.com',9148923202),
(414,004,'john','michel','villupuram','IT','johnmi333@gmail.com',6798934202),
(415,005,'ruban','edwin','thuripakam','manager','rubanerdwin@gmail.com',7890234512),
(416,006,'edwin','ronoldo','gingee','manager','edwin299ro@gmail.com',95788994244);
select*from employee;
-- update
update branch
set location ='T.nagar'
where branch_id=5;
update branch
set location='pallikarani'
where branch_id=2;
-- Between operator
select* from transactions
where balance between 10000 and 15000;
-- limit clause
select * from transactions
limit 2
offset 2;
-- order by clause
select distinct(amount)
from transactions
order by amount desc limit 1
offset 1;
-- group by
select sum(amount) AS total
from transactions
group by amount;

-- join
select customers. first_name,customers.last_name,accounts.account_type
from customers
join accounts
on customers.cust_id=accounts.cust_id;
-- cross join
select * from accounts cross join transactions;
-- view
create view first_name as
select * from customers
where  first_name="anbu" or"stephy";
select*from first_name;

create view branch_name as
select * from branch
where branch_name="HDFC bank"or"ICIC bank";
select*from branch_name;

 create view account_type as
 select*from accounts
 where account_type= "saving account"or"business account";
  select*from account_type;
  
  create view transa_type as
select* from transactions
where transa_type="withdrawal"and" deposit";
select * from transa_type; 
 
   create view job as
 select* from employee
 where job="HR"or"IT";
 select * from job;
-- stored procedures 
 delimiter //
create procedure cust_branch()
begin
select * from customers;
select * from branch;
end //
delimiter ;
call cust_branch();

delimiter //
create procedure gettotalemployee(out emp_id int)
begin 
select count(*) into emp_id from employee;
end //
delimiter ;
call gettotalemployee(@a);
select @a;

delimiter //
create procedure tran(in input1 varchar(30),out total_amount int)
begin
select sum(amount) into total_amount
from transactions 
where amount=input1 ;
end //
delimiter ;
call tran(15000,@out_total_amount);
select @out_total_amount;
