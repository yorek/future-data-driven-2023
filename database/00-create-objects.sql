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
