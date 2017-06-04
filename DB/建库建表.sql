if exists(select * from sys.databases where name='Personnel_DB')
drop database Personnel_DB
create database Personnel_DB
on
(
  name='Personnel_DB',
  filename='F:\NF\PersonnelManagerSys\PersonnelManagerSys\DB\Personnel_DB.MDF'
)
use Personnel_DB

--1创建部门表
create table Department
(
   Id int identity(1,1) primary key,
   ParentId int not null,
   DepartmentName nvarchar(50) not null,
   AuditMaxLeaveDays  int,--审批最大的请假天数
   AuditMaxMoney decimal(18,2),--审批奖惩最大金额数
   MainPrincipal int,--部门主要负责人
   SubordinationPrincipal int,--次要负责人  
   Sort int not null,
   AddDate datetime default(getdate()),
)

--2创建行政级别表
create table ASLevel
(
   Id int identity(1,1) primary key,
   Name  varchar(50) not null,
   BaseSalary  decimal(18,2),
   Description varchar(max)
)

--3创建职员表
create table Employee
(
   Id int identity(1,1) primary key,
   Work varchar(50) not null,
   Name  varchar(50) not null,
   OldName  varchar(50),--曾用名
   EnglishName varchar(50),
   Sex varchar(50) not null,
   ASLevelId int not null foreign key references ASLevel(Id),  --外键(行政级别表)
   PoliticsStatus varchar(50),--政治面貌
   Nation varchar(50),--民族
   Marriage varchar(50),--婚姻状况
   InputDate  datetime default(getdate()),--入职时间
   BaseSalary decimal(18,2) not null,
   PictureSrc varchar(100),--职员照片
   BankAccount varchar(50) not null,--银行帐号
   GraduateSchool varchar(100),--毕业院校
   StudyMajor varchar(50),--所学专业
   XueLi int,--学历
   IdentityCard varchar(50),--身份证号码
   Birthday datetime,--出生日期
   Anmelden varchar(50),--户口性质
   Phone varchar(50) not null,--手机号码
   Email varchar(50),--邮箱
   QQ varchar(50),
   NativePlace varchar(50),--籍贯
   [Address] varchar(255),
   PostalCode varchar(30),--邮政编码
   CurAddress varchar(255),
   HealthState varchar(50),--健康状况
   HousingCase varchar(50),--住房情况
   Hobby varchar(255),--兴趣爱好
   Speciality  varchar(255),--个人特长
   DepartmentId int not null foreign key references Department(Id),--外键(部门表)
   EmployeeStatus bit not null,--在职状态
   Description varchar(max)--备注
)


--4创建用户表
create table [User]
(
   Id int identity(1,1) primary key,
   EmployeeId int foreign key references Employee(Id),           --外键(关联的职员)
   UserName nvarchar(50) not null,
   UserPwd  nvarchar(50) not null,
   IsAble bit not null,
   IfChangePwd bit not null,
   AddDate datetime default(getdate()),
   Description nvarchar(200),
)

--5创建角色表
create table Role
(
   Id int identity(1,1) primary key,
   RoleName nvarchar(50) not null,
   AddDate datetime default(getdate()),
   ModifyDate datetime not null,
   Description nvarchar(200),
)

--6创建用户角色表
drop table userrole
create table UserRole
(
   Id int identity(1,1) primary key,
   UserId int not null foreign key references [User](Id),
   RoleId int not null foreign key references [Role](Id),
)

--7创建菜单表
create table Menu
(
   Id int identity(1,1) primary key,
   ParentId int not null,           --外键(职员表)
   Name nvarchar(50) not null,
   Code  varchar(50),
   LinkAddress varchar(100),
   Icon varchar(50),
   AddDate datetime default(getdate()),
   Sort int not null
)

--8创建按钮表
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

--9创建导航菜单按钮表
create table MenuButton
(
  Id int identity(1,1) primary key,
   MenuId int not null foreign key references [Menu](Id),
   ButtonId int not null foreign key references [Button](Id),
)

--10创建角色菜单按钮表
create table RoleMenuButton
(
  Id int identity(1,1) primary key,
   RoleId int not null foreign key references Role(Id),
   ButtonId int not null foreign key references Button(Id),
   MenuId int not null foreign key references Menu(Id),
)

--11创建登录日志表
create table LoginLog
(
   Id int identity(1,1) primary key,
   UserId int foreign key references [User](Id),--外键(用户表)
   UserIp  varchar(50),
   City varchar(50),
   IfSuccess bit not null,
   LoginDate datetime default(getdate())
)

--12创建用户操作日志表
create table UserOperateLog
(
   Id int identity(1,1) primary key,
   UserId int foreign key references [User](Id),--外键(用户表)
   UserIp  varchar(50),
   OperateInfo  varchar(100),
   Description varchar(max),
   IfSuccess bit not null,
   OperateDate datetime default(getdate())
)

--13创建公告表
create table Bulletin
(
   Id int identity(1,1) primary key,
   Theme  varchar(50) not null,
   Publisher  int foreign key references Employee(Id) not null,--发布人
   Accessory varchar(255),
   Content varchar(max),
   DepartmentId int not null foreign key references Department(Id),--外键(部门表)
   PublishDate datetime default(getdate())
)

--14创建通知表
create table Inform
(
   Id int identity(1,1) primary key,
   Theme  varchar(50) not null,
   Publisher  varchar(50) not null,
   Accessory varchar(50),
   Content varchar(max),
   EmployeeId int not null foreign key references Employee(Id),--外键(职员表)
   PublishDate datetime default(getdate())
)

--15创建请假类型表
create table LeaveType
(
   Id int identity(1,1) primary key,
   Name  varchar(50) not null,
   LeaveDays  int,
   OneDayMoney decimal(18,2),--请一天扣除的工资
   DeductMoney decimal(18,2),--扣除金额
   Description varchar(max)
)

--16创建请假表
create table Leave
(
   Id int identity(1,1) primary key,
   EmployeeId int not null foreign key references Employee(Id),--外键(职员表),请假人
   LeaveTypeId int not null foreign key references LeaveType(Id),--外键(请假类型表)
   StartTime datetime not null,
   EndTime datetime not null,
   LeaveCause varchar(255),
   Description varchar(max),
   RegsterPerson int not null foreign key references Employee(Id),
   RegsterTime datetime not null,
   AuditPerson int null foreign key references Employee(Id),
   AuditStatus int not null,
   IsReader bit not null,--是否已读
   LeaveDays int
)

--17创建请假审批表
create table LeaveAudit
(
   Id int identity(1,1) primary key,
   LeaveId int not null foreign key references Leave(Id),--外键(请假表)
   AuditPersonId int not null foreign key references Employee(Id),--外键(职员表)
   Status bit,
   AuditTime datetime not null,
   Description varchar(max)
)

--18创建出差登记表
create table Evection
(
   Id int identity(1,1) primary key,
   Theme varchar(50) not null,
   EmployeeId int not null foreign key references Employee(Id),--外键(职员表)
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

--20创建离职申请表
create table Dimission
(
   Id int identity(1,1) primary key,
   EmployeeId int not null foreign key references Employee(Id),--外键(职员表)
   DimissionTime datetime,
   AuditPerson int null foreign key references Employee(Id),
   AuditStatus int not null,
   Description varchar(max)
)

--21创建调动表
create table Change
(
   Id int identity(1,1) primary key,
   Type varchar(50),
   EmployeeId int not null foreign key references Employee(Id),--外键(职员表)
   DepartmentId_Old int not null foreign key references Department(Id),--外键(部门表)
   DepartmentId_New int not null foreign key references Department(Id),--外键(部门表)
   ChangeTime datetime,
   RegsterPerson int not null foreign key references Employee(Id),
   RegsterTime datetime not null,
   AuditPerson int null foreign key references Employee(Id),
   AuditStatus int not null,
   Description varchar(max)
)

--22创建调动审核表
create table ChangeAudit
(
   Id int identity(1,1) primary key,
   ChangeId int not null foreign key references Change(Id),--外键(调动表)
   AuditPersonId int not null foreign key references Employee(Id),--外键(职员表)
   Status bit,
   AuditTime datetime not null,
   Description varchar(max)
)


--23创建工作经历表
create table WorkExperience
(
   Id int identity(1,1) primary key,
   UnitName varchar(50) ,
   EmployeeId int not null foreign key references Employee(Id),--外键(职员表)
   WorkDepartment varchar(50),
   ProfessionalTitle varchar(50),
   Salary decimal(18,2),
   Content varchar(max)
)


--24创建教育经历表
create table EducationExperience
(
   Id int identity(1,1) primary key,
   GraduateSchool varchar(50) ,
   EmployeeId int not null foreign key references Employee(Id),--外键(职员表)
   StudyMajor varchar(50),
   XueLi int ,
   IfObtainedCertificate bit,
   ImgSrc varchar(200),
   StartTime datetime,
   EndTime datetime,
   IfGraduate bit,
   Description varchar(max)
)

--25创建培训经历表
create table TrainExperience
(
   Id int identity(1,1) primary key,
   Organization varchar(50) ,
   EmployeeId int not null foreign key references Employee(Id),--外键(职员表)
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
--26创建奖惩项目表
create table RewarAndPunishProject
(
   Id int identity(1,1) primary key,
   Name varchar(50),
   [Money] decimal(18,2)
)
--27创建职员奖惩表
create table RewarAndPunish
(
   Id int identity(1,1) primary key,
   ProjectId int not null foreign key references RewarAndPunishProject(Id),--外键(奖惩项目表)
   EmployeeId int not null foreign key references Employee(Id),--外键(职员表)
   RTime datetime,
   [Money] decimal(18,2),
   RewarOrPunish bit,  
   RegsterPerson int not null foreign key references Employee(Id),
   RegsterTime datetime not null,
   AuditPerson int null foreign key references Employee(Id),
   AuditStatus int not null,
   Description varchar(max)
)

--28创建奖惩审核表
create table RewarAndPunishAudit
(
   Id int identity(1,1) primary key,
   RewarAndPunishId int not null foreign key references RewarAndPunish(Id),--外键(奖惩表)
   AuditPerson int not null foreign key references Employee(Id),
   Opinion varchar(255),
   AuditTime datetime,
   Status bit,
)

--29创建合同类型表
create table CompactType
(
   Id int identity(1,1) primary key,
   Name varchar(50) not null,
   Description varchar(max)
)

--30创建合同表
create table Compact
(
   Id int identity(1,1) primary key,
   CompactTypeId int not null foreign key references CompactType(Id),--外键（合同类型表）
   EmployeeId int not null foreign key references Employee(Id),--外键(职员表)
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
--31创建培训课程表
create table TrainCourse
(
   Id int identity(1,1) primary key,
   Name varchar(50) not null,
   Description varchar(max)
)

--32创建培训计划表
create table TrainPlan
(
   Id int identity(1,1) primary key,
   TrainCourseId int not null foreign key references TrainCourse(Id),--外键
   TrainDays datetime,
   StartTime datetime,
   EndTime datetime,
   TrainLecturer varchar(50),
   PlanTime datetime,
   PlanPerson varchar(50),
   Description  varchar(max)
)

--32创建培训人员表
create table TrainPerson
(
   Id int identity(1,1) primary key,
   TrainCourseId int not null foreign key references TrainPlan(Id),--外键
   TrainObject int not null foreign key references Employee(Id),--外键(职员表)
   IsAccept bit,
   TrainNumber int,--培训次(天)数
   TotalPoints int,--总分
)

--创建培训人员签到表
create table SignIn
(
	 Id int identity(1,1) primary key,
	 TrainPersonId int not null foreign key references TrainPerson(Id),
	 IsSignIn bit not null,
	 SignInTime datetime default(getdate())
)


------------------添加记录----------------------
--添加部门
insert into Department(ParentId,DepartmentName,Sort) 
values(0,'人事部',1)
insert into Department(ParentId,DepartmentName,Sort) 
values(0,'研发部',2)
--添加行政级别
insert into ASLevel(Name,BaseSalary) 
values('普通员工',5500)
--添加职员
insert into Employee(Work,Name,Sex,ASLevelId,DepartmentId,BaseSalary,BankAccount,Phone,EmployeeStatus)
values('1001','系统管理员','男',1,2,5500,'6228487659764890231','13680398478',1)
--添加用户
insert into [User](EmployeeId,UserName,UserPwd,IsAble,IfChangePwd) 
values(4,'admin','21232F297A57A5A743894A0E4A801F',1,1)
--添加菜单
insert into Menu(ParentId,Name,Sort)
values(0,'日常事务',1)
insert into Menu(ParentId,Name,Sort)
values(0,'人事管理',2)
insert into Menu(ParentId,Name,Sort)
values(0,'培训管理',3)
insert into Menu(ParentId,Name,Sort)
values(0,'权限管理',4)
insert into Menu(ParentId,Name,Sort)
values(0,'系统设置',5)

insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(1,'企业通讯录','enterprise','/Employee/List',1)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(1,'发布公告','bulletin','/Bulletin/List',2)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(1,'发布通知','inform','/Inform/List',3)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(1,'我的请假','leave','/Leave/List',4)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(1,'我的出差','evection','/Evection/List',5)

insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(2,'人事档案','enterprise','/Employee/List',1)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(2,'工作经历','workExperience','/WorkExperience/List',2)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(2,'教育经历','educationExperience','/EducationExperience/List',3)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(2,'培训经历','trainExperience','/TrainExperience/List',4)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(2,'人员离职','dimission','/Dimission/List',5)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(2,'人事调动','change','/Change/List',6)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(2,'请假管理','leave','/Leave/List',7)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(2,'出差管理','evection','/Evection/List',8)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(2,'合同管理','compact','/Compact/List',9)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(2,'奖惩管理','rewarAndPunish','/RewarAndPunish/List',10)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(2,'人事性别分析','enterprise','/Employee/List',11)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(2,'人事学历分析','enterprise','/Employee/List',12)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(2,'人事部门分析','enterprise','/Employee/List',13)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(2,'人事状态分析','enterprise','/Employee/List',14)



insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(3,'制定培训计划','trainPlan','/TrainPlan/List',1)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(3,'培训课程管理','trainCourse','/TrainCourse/List',2)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(3,'培训人员管理','trainPerson','/TrainPerson/List',3)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(3,'培训人员签到统计','signIn','/SignIn/List',4)

insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(4,'按钮管理','button','/Button/List',1)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(4,'菜单管理','menu','/Menu/List',2)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(4,'用户管理','user','/User/List',3)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(4,'角色管理','role','/Role/List',4)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(4,'部门管理','department','/Department/List',5)

insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(5,'请假类型','leaveType','/LeaveType/List',1)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(5,'行政级别','aSLevel','/ASLevel/List',2)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(5,'合同类型','compactType','/CompactType/List',3)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(5,'奖惩项目','rewarAndPunishProject','/RewarAndPunishProject/List',4)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(5,'登录日志','loginLog','/LoginLog/List',5)
insert into Menu(ParentId,Name,Code,LinkAddress,Sort)
values(5,'操作日志','userOperateLog','/UserOperateLog/List',6)


insert into [Role](RoleName,AddDate,[Description])
values('浏览角色',GETDATE(),'仅拥有浏览菜单的权限，无增删改权限')

select * from Role

insert into UserRole(UserId,RoleId)
values(2,1)



select distinct(m.Name) menuname,m.Id menuid,m.Icon icon,u.Id userid,u.UserId username,m.ParentId menuparentid,m.Sort menusort,m.LinkAddress linkaddress from tbUser u
join tbUserRole ur on u.Id=ur.UserId
join tbRoleMenuButton rmb on ur.RoleId=rmb.RoleId
join tbMenu m on rmb.MenuId=m.Id
where u.Id=@Id order by m.ParentId,m.Sort



select * from [User]