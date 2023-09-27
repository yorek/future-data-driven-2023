drop user if exists [dabuser];
go

create user [dabuser] with password = '34ffDEKl23c3op3E0SDgef'
go

alter role db_owner add member [dabuser]
go
