drop table if exists dbo.[sessions];
drop table if exists dbo.[speakers];

drop sequence if exists dbo.globalId;
create sequence dbo.globalId as int start with 100000 increment by 1;

create table dbo.[speakers]
(
    id int not null primary key default next value for dbo.globalId,
    fullname nvarchar(200) not null,
    title nvarchar(100) null,
    biography nvarchar(max) null,
    picture_url nvarchar(1000) null
)
go

create table dbo.[sessions]
(
    id int not null primary key default next value for dbo.globalId,
    title nvarchar(200) not null,
    abstract nvarchar(max) not null,
    speaker_id int not null foreign key references dbo.speakers(id),    
    is_published bit not null default (0),
    owner_id varchar(50) null
)
go

create or alter procedure dbo.stp_get_session_count
as
select count(*) as total_session_count from dbo.sessions
go

delete from dbo.sessions
delete from dbo.speakers
go

insert into speakers (id, fullname, title, biography) 
values
(1, 'Bradley Ball', 'Microsoft - Sr. FastTrack Azure Engineer', 'Bradley Ball is a Sr. FastTrack Azure Engineer on the Microsoft CXP Product Group. He is a current Microsoft MVP Reconnect member and former MVP. Bradley spent 8 years working as a Defense contractor for clients such as the U.S. Army and The Executive Office of the President of the United States, was the Data Platform Practice Manager for Pragmatic Works Consulting, and a Sr. Consultant for Microsoft Premier Support for Developers. He has presented at many SQL Saturdays, for PASS SSUG’s across the US from California to Puerto Rico to New Hampshire, SQL Rally, DevConnections, SQLBits 2015, TechReady 24, SQL Live 360 2011-2019, SQL Intersections 2019 - 2021, & the PASS Summit 2011-2015. He wrote Chapter 14 Page & Row Compression for PRO SQL Server 2012 Best Practices and he can be found blogging on http://www.sqlballs.com about anything else that interests him.'),
(2, 'Bob Ward', 'Principal Architect, Microsoft Azure Data', 'Bob Ward is a Principal Architect for the Microsoft Azure Data team, which owns the development for all SQL Server versions. Bob has worked for Microsoft for 29 years on every version of SQL Server shipped from OS/2 1.1 to SQL Server 2022 including Azure SQL. Bob is a well-known speaker on SQL Server and Azure SQL, often presenting talks on new releases, internals, and specialized topics at events such as SQLBits, Azure Data Conference, Microsoft Build, Microsoft Inspire, Microsoft Ignite, PASS Summit, and VS Live. You can also learn Azure SQL from him on the popular series https://aka.ms/azuresql4beginners. You can follow him at @bobwardms or linkedin.com/in/bobwardms. Bob is the author of the books Pro SQL Server on Linux, SQL Server 2019 Revealed, Azure SQL Revealed and SQL Server 2022 Revealed available from Apress Media.'),
(3, 'Davide Mauri', 'Microsoft, Principal Product Manager', 'Azure Data Platform MVP for 12 years in a row, now Product Manager in Azure SQL team, focusing on developer experience. Developer at heart, heavy metal lover; once a biker, now waiting for kids to grow old to start to travel the world again.')
go

insert into dbo.sessions (id, title, speaker_id, is_published, owner_id, abstract)
values
(1, '"5 Things You MUST KNOW If You Use Azure SQL Managed Instance', 1, 1, 'bb5789', '
Azure SQL Managed Instance is incredibly popular. However, if you are unfamiliar with the service you may have some questions:

* Is there a Developer Edition, e.g. an edition where I don’t have to pay for SQL Licensing?
* How does Transparent Data Encryption work on the system?
* How do you perform a “Prod Refresh” of a database across subscriptions while keeping TDE in place?
* Can you backup and restore to SQL Server from SQL MI?
* How does High Availability & Disaster Recovery work?

In this demo heavy session, we will answer these questions (and more)!'),
(2, 'Latest innovations in Azure SQL Edge to Clou', 2, 1, 'bw4567', 'Come learn about all the latest innovations for SQL edge to cloud'),
(3, 'From databases to API: an efficient solution both on-premises and in Azure', 3, 1, 'dm1234', 'Data API builder turns Azure Databases into REST a GraphQL API so that you can have the backend for your next modern application done in just a few minutes instead of days. With full support to authentication and authorization, integrated with Static Web Apps and easily scalable up and out – using API Management – Data API builder is something you really want to look at. Available both on Azure and on-premises, and Open Source, this is very likely to become your favorite tool. Come and learn everything about it!')
go

select * from dbo.speakers
select * from dbo.sessions
go

