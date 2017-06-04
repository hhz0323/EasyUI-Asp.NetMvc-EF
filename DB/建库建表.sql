if exists(select * from sys.databases where name='Personnel_DB')
drop database Personnel_DB
create database Personnel_DB
on
(
  name='Personnel_DB',
  filename='F:\NF\PersonnelManagerSys\PersonnelManagerSys\DB\Personnel_DB.MDF'
)
use Personnel_DB

--1�������ű�
create table Department
(
   Id int identity(1,1) primary key,
   ParentId int not null,
   DepartmentName nvarchar(50) not null,
   AuditMaxLeaveDays  int,--���������������
   AuditMaxMoney decimal(18,2),--���������������
   MainPrincipal int,--������Ҫ������
   SubordinationPrincipal int,--��Ҫ������  
   Sort int not null,
   AddDate datetime default(getdate()),
)

--2�������������
create table ASLevel
(
   Id int identity(1,1) primary key,
   Name  varchar(50) not null,
   BaseSalary  decimal(18,2),
   Description varchar(max)
)

--3����ְԱ��
create table Employee
(
   Id int identity(1,1) primary key,
   Work varchar(50) not null,
   Name  varchar(50) not null,
   OldName  varchar(50),--������
   EnglishName varchar(50),
   Sex varchar(50) not null,
   ASLevelId int not null foreign key references ASLevel(Id),  --���(���������)
   PoliticsStatus varchar(50),--������ò
   Nation varchar(50),--����
   Marriage varchar(50),--����״��
   InputDate  datetime default(getdate()),--��ְʱ��
   BaseSalary decimal(18,2) not null,
   PictureSrc varchar(100),--ְԱ��Ƭ
   BankAccount varchar(50) not null,--�����ʺ�
   GraduateSchool varchar(100),--��ҵԺУ
   StudyMajor varchar(50),--��ѧרҵ
   XueLi int,--ѧ��
   IdentityCard varchar(50),--���֤����
   Birthday datetime,--��������
   Anmelden varchar(50),--��������
   Phone varchar(50) not null,--�ֻ�����
   Email varchar(50),--����
   QQ varchar(50),
   NativePlace varchar(50),--����
   [Address] varchar(255),
   PostalCode varchar(30),--��������
   CurAddress varchar(255),
   HealthState varchar(50),--����״��
   HousingCase varchar(50),--ס�����
   Hobby varchar(255),--��Ȥ����
   Speciality  varchar(255),--�����س�
   DepartmentId int not null foreign key references Department(Id),--���(���ű�)
   EmployeeStatus bit not null,--��ְ״̬
   Description varchar(max)--��ע
)


--4�����û���
create table [User]
(
   Id int identity(1,1) primary key,
   EmployeeId int foreign key references Employee(Id),           --���(������ְԱ)
   UserName nvarchar(50) not null,
   UserPwd  nvarchar(50) not null,
   IsAble bit not null,
   IfChangePwd bit not null,
   AddDate datetime default(getdate()),
   Description nvarchar(200),
)

--5������ɫ��
create table Role
(
   Id int identity(1,1) primary key,
   RoleName nvarchar(50) not null,
   AddDate datetime default(getdate()),
   ModifyDate datetime not null,
   Description nvarchar(200),
)

--6�����û���ɫ��
drop table userrole
create table UserRole
(
   Id int identity(1,1) primary key,
   UserId int not null foreign key references [User](Id),
   RoleId int not null foreign key references [Role](Id),
)

--7�����˵���
create table Menu
(
   Id int identity(1,1) primary key,
   ParentId int not null,           --���(ְԱ��)
   Name nvarchar(50) not null,
   Code  varchar(50),
   LinkAddress varchar(100),
   Icon varchar(50),
   AddDate datetime default(getdate()),
   Sort int not null
)

--8������ť��
create table Button
(
   Id int identity(1,1) primary key,
   Name nvarchar(50) not null,
   Code  varchar(50),
   Icon varchar(50),
   AddDate datetime default(getdate()),
   Sort int not null,
   Description varchar(100)
)

--9���������˵���ť��
create table MenuButton
(
  Id int identity(1,1) primary key,
   MenuId int not null foreign key references [Menu](Id),
   ButtonId int not null foreign key references [Button](Id),
)

--10������ɫ�˵���ť��
create table RoleMenuButton
(
  Id int identity(1,1) primary key,
   RoleId int not null foreign key references Role(Id),
   ButtonId int not null foreign key references Button(Id),
   MenuId int not null foreign key references Menu(Id),
)

--11������¼��־��
create table LoginLog
(
   Id int identity(1,1) primary key,
   UserId int foreign key references [User](Id),--���(�û���)
   UserIp  varchar(50),
   City varchar(50),
   IfSuccess bit not null,
   LoginDate datetime default(getdate())
)

--12�����û�������־��
create table UserOperateLog
(
   Id int identity(1,1) primary key,
   UserId int foreign key references [User](Id),--���(�û���)
   UserIp  varchar(50),
   OperateInfo  varchar(100),
   Description varchar(max),
   IfSuccess bit not null,
   OperateDate datetime default(getdate())
)

--13���������
create table Bulletin
(
   Id int identity(1,1) primary key,
   Theme  varchar(50) not null,
   Publisher  int foreign key references Employee(Id) not null,--������
   Accessory varchar(255),
   Content varchar(max),
   DepartmentId int not null foreign key references Department(Id),--���(���ű�)
   PublishDate datetime default(getdate())
)

--14����֪ͨ��
create table Inform
(
   Id int identity(1,1) primary key,
   Theme  varchar(50) not null,
   Publisher  varchar(50) not null,
   Accessory varchar(50),
   Content varchar(max),
   EmployeeId int not null foreign key references Employee(Id),--���(ְԱ��)
   PublishDate datetime default(getdate())
)

--15����������ͱ�
create table LeaveType
(
   Id int identity(1,1) primary key,
   Name  varchar(50) not null,
   LeaveDays  int,
   OneDayMoney decimal(18,2),--��һ��۳��Ĺ���
   DeductMoney decimal(18,2),--�۳����
   Description varchar(max)
)

--16������ٱ�
create table Leave
(
   Id int identity(1,1) primary key,
   EmployeeId int not null foreign key references Employee(Id),--���(ְԱ��),�����
   LeaveTypeId int not null foreign key references LeaveType(Id),--���(������ͱ�)
   StartTime datetime not null,
   EndTime datetime not null,
   LeaveCause varchar(255),
   Description varchar(max),
   RegsterPerson int not null foreign key references Employee(Id),
   RegsterTime datetime not null,
   AuditPerson int null foreign key references Employee(Id),
   AuditStatus int not null,
   IsReader bit not null,--�Ƿ��Ѷ�
   LeaveDays int
)

--17�������������
create table LeaveAudit
(
   Id int identity(1,1) primary key,
   LeaveId int not null foreign key references Leave(Id),--���(��ٱ�)
   AuditPersonId int not null foreign key references Employee(Id),--���(ְԱ��)
   Status bit,
   AuditTime datetime not null,
   Description varchar(max)
)

--18��������ǼǱ�
create table Evection
(
   Id int identity(1,1) primary key,
   Theme varchar(50) not null,
   EmployeeId int not null foreign key references Employee(Id),--���(ְԱ��)
   StartTime datetime not null,
   EndTime datetime not null,
   SynergyPreson varchar(50),
   Address varchar(255),
   PredictCost decimal(18,2),
   ApplyForCost decimal(18,2),
   Description varchar(max),
   RegsterPerson int not null foreign key references Employee(Id),
   RegsterTime datetime not null,
   AuditPerson int null foreign key references Employee(Id),
   AuditStatus int not null,
)

--20������ְ�����
create table Dimission
(
   Id int identity(1,1) primary key,
   EmployeeId int not null foreign key references Employee(Id),--���(ְԱ��)
   DimissionTime datetime,
   AuditPerson int null foreign key references Employee(Id),
   AuditStatus int not null,
   Description varchar(max)
)

--21����������
create table Change
(
   Id int identity(1,1) primary key,
   Type varchar(50),
   EmployeeId int not null foreign key references Employee(Id),--���(ְԱ��)
   DepartmentId_Old int not null foreign key references Department(Id),--���(���ű�)
   DepartmentId_New int not null foreign key references Department(Id),--���(���ű�)
   ChangeTime datetime,
   RegsterPerson int not null foreign key references Employee(Id),
   RegsterTime datetime not null,
   AuditPerson int null foreign key references Employee(Id),
   AuditStatus int not null,
   Description varchar(max)
)

--22����������˱�
create table ChangeAudit
(
   Id int identity(1,1) primary key,
   ChangeId int not null foreign key references Change(Id),--���(������)
   AuditPersonId int not null foreign key references Employee(Id),--���(ְԱ��)
   Status bit,
   AuditTime datetime not null,
   Description varchar(max)
)


--23��������������
create table WorkExperience
(
   Id int identity(1,1) primary key,
   UnitName varchar(50) ,
   EmployeeId int not null foreign key references Employee(Id),--���(ְԱ��)
   WorkDepartment varchar(50),
   ProfessionalTitle varchar(50),
   Salary decimal(18,2),
   Content varchar(max)
)


--24��������������
create table EducationExperience
(
   Id int identity(1,1) primary key,
   GraduateSchool varchar(50) ,
   EmployeeId int not null foreign key references Employee(Id),--���(ְԱ��)
   StudyMajor varchar(50),
   XueLi int ,
   IfObtainedCertificate bit,
   ImgSrc varchar(200),
   StartTime datetime,
   EndTime datetime,
   IfGraduate bit,
   Description varchar(max)
)

--25������ѵ������
create table TrainExperience
(
   Id int identity(1,1) primary key,
   Organization varchar(50) ,
   EmployeeId int not null foreign key references Employee(Id),--���(ְԱ��)
   TrainCourse varchar(50),
   StartTime datetime,
   EndTime datetime,
   Duration datetime,
   TrainRank varchar(50),
   CertificateName varchar(50),
   Organ varchar(50),
   ObtainedCertificateDate datetime,
   Description varchar(max)
)
--26����������Ŀ��
create table RewarAndPunishProject
(
   Id int identity(1,1) primary key,
   Name varchar(50),
   [Money] decimal(18,2)
)
--27����ְԱ���ͱ�
create table RewarAndPunish
(
   Id int identity(1,1) primary key,
   ProjectId int not null foreign key references RewarAndPunishProject(Id),--���(������Ŀ��)
   EmployeeId int not null foreign key references Employee(Id),--���(ְԱ��)
   RTime datetime,
   [Money] decimal(18,2),
   RewarOrPunish bit,  
   RegsterPerson int not null foreign key references Employee(Id),
   RegsterTime datetime not null,
   AuditPerson int null foreign key references Employee(Id),
   AuditStatus int not null,
   Description varchar(max)
)

--28����������˱�
create table RewarAndPunishAudit
(
   Id int identity(1,1) primary key,
   RewarAndPunishId int not null foreign key references RewarAndPunish(Id),--���(���ͱ�)
   AuditPerson int not null foreign key references Employee(Id),
   Opinion varchar(255),
   AuditTime datetime,
   Status bit,
)

--29������ͬ���ͱ�
create table CompactType
(
   Id int identity(1,1) primary key,
   Name varchar(50) not null,
   Description varchar(max)
)

--30������ͬ��
create table Compact
(
   Id int identity(1,1) primary key,
   CompactTypeId int not null foreign key references CompactType(Id),--�������ͬ���ͱ�
   EmployeeId int not null foreign key references Employee(Id),--���(ְԱ��)
   OfficialSalary decimal(18,2),
   StartTime datetime,
   EndTime datetime,
   IsBuyInsurance bit,
   SignTime datetime,
   SignType varchar(50),
   CompactStatus varchar(50),
   [File] varchar(50),
   RegsterPerson varchar(50),
   RegsterTime datetime,
   Content varchar(max)
)
--31������ѵ�γ̱�
create table TrainCourse
(
   Id int identity(1,1) primary key,
   Name varchar(50) not null,
   Description varchar(max)
)

--32������ѵ�ƻ���
create table TrainPlan
(
   Id int identity(1,1) primary key,
   TrainCourseId int not null foreign key references TrainCourse(Id),--���
   TrainDays datetime,
   StartTime datetime,
   EndTime datetime,
   TrainLecturer varchar(50),
   PlanTime datetime,
   PlanPerson varchar(50),
   Description  varchar(max)
)

--32������ѵ��Ա��
create table TrainPerson
(
   Id int identity(1,1) primary key,
   TrainCourseId int not null foreign key references TrainPlan(Id),--���
   TrainObject int not null foreign key references Employee(Id),--���(ְԱ��)
   IsAccept bit,
   TrainNumber int,--��ѵ��(��)��
   TotalPoints int,--�ܷ�
)

--������ѵ��Աǩ����
create table SignIn
(
	 Id int identity(1,1) primary key,
	 TrainPersonId int not null foreign key references TrainPerson(Id),
	 IsSignIn bit not null,
	 SignInTime datetime default(getdate())
)


------------------��Ӽ�¼----------------------
--��Ӳ���
insert into Department(ParentId,DepartmentName,Sort) 
values(0,'���²�',1)
insert into Department(ParentId,DepartmentName,Sort) 
values(0,'�з���',2)
--�����������
insert into ASLevel(Name,BaseSalary) 
values('��ͨԱ��',5500)
--���ְԱ
insert into Employee(Work,Name,Sex,ASLevelId,DepartmentId,BaseSalary,BankAccount,Phone,EmployeeStatus)
values('1001','ϵͳ����Ա','��',1,2,5500,'6228487659764890231','13680398478',1)
--����û�
insert into [User](EmployeeId,UserName,UserPwd,IsAble,IfChangePwd) 
values(4,'admin','21232F297A57A5A743894A0E4A801F',1,1)
--��Ӳ˵�
insert into Menu(ParentId,Name,Sort)
values(0,'�ճ�����',1)
insert into Menu(ParentId,Name,Sort)
values(0,'���¹���',2)
insert into Menu(ParentId,Name,Sort)
values(0,'��ѵ����',3)
insert into Menu(ParentId,Name,Sort)
values(0,'Ȩ�޹���',4)
insert into Menu(ParentId,Name,Sort)
values(0,'ϵͳ����',5)

insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(1,'��ҵͨѶ¼','enterprise','/Employee/List',1)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(1,'��������','bulletin','/Bulletin/List',2)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(1,'����֪ͨ','inform','/Inform/List',3)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(1,'�ҵ����','leave','/Leave/List',4)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(1,'�ҵĳ���','evection','/Evection/List',5)

insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(2,'���µ���','enterprise','/Employee/List',1)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(2,'��������','workExperience','/WorkExperience/List',2)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(2,'��������','educationExperience','/EducationExperience/List',3)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(2,'��ѵ����','trainExperience','/TrainExperience/List',4)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(2,'��Ա��ְ','dimission','/Dimission/List',5)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(2,'���µ���','change','/Change/List',6)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(2,'��ٹ���','leave','/Leave/List',7)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(2,'�������','evection','/Evection/List',8)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(2,'��ͬ����','compact','/Compact/List',9)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(2,'���͹���','rewarAndPunish','/RewarAndPunish/List',10)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(2,'�����Ա����','enterprise','/Employee/List',11)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(2,'����ѧ������','enterprise','/Employee/List',12)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(2,'���²��ŷ���','enterprise','/Employee/List',13)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(2,'����״̬����','enterprise','/Employee/List',14)



insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(3,'�ƶ���ѵ�ƻ�','trainPlan','/TrainPlan/List',1)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(3,'��ѵ�γ̹���','trainCourse','/TrainCourse/List',2)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(3,'��ѵ��Ա����','trainPerson','/TrainPerson/List',3)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(3,'��ѵ��Աǩ��ͳ��','signIn','/SignIn/List',4)

insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(4,'��ť����','button','/Button/List',1)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(4,'�˵�����','menu','/Menu/List',2)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(4,'�û�����','user','/User/List',3)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(4,'��ɫ����','role','/Role/List',4)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(4,'���Ź���','department','/Department/List',5)

insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(5,'�������','leaveType','/LeaveType/List',1)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(5,'��������','aSLevel','/ASLevel/List',2)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(5,'��ͬ����','compactType','/CompactType/List',3)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(5,'������Ŀ','rewarAndPunishProject','/RewarAndPunishProject/List',4)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(5,'��¼��־','loginLog','/LoginLog/List',5)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(5,'������־','userOperateLog','/UserOperateLog/List',6)


insert into [Role](RoleName,AddDate,[Description])
values('�����ɫ',GETDATE(),'��ӵ������˵���Ȩ�ޣ�����ɾ��Ȩ��')

select * from Role

insert into UserRole(UserId,RoleId)
values(2,1)



select distinct(m.Name) menuname,m.Id menuid,m.Icon icon,u.Id userid,u.UserId username,m.ParentId menuparentid,m.Sort menusort,m.LinkAddress linkaddress from tbUser u
join tbUserRole ur on u.Id=ur.UserId
join tbRoleMenuButton rmb on ur.RoleId=rmb.RoleId
join tbMenu m on rmb.MenuId=m.Id
where u.Id=@Id order by m.ParentId,m.Sort



select * from [User]