Use CabinetVeterinar;


create function validate_name(@nume varchar(50))
RETURNS bit
AS
begin 
return
(
select
case
when @nume is NULL then 0
when @nume like '%[0-9]%' then 0
Else 1
END
)
end


create function validate_id(@id int) Returns bit as
begin return(
select case
when @id is NULL then 0
Else 1
END)
end



create procedure adaugare_animal 
( @nume varchar(50),@tip varchar(50), @boala varchar(100), @varsta int) 
AS
BEGIN
declare @n int
set @n=0
select @n=max(id_a) from Animal
if dbo.validate_name(@nume)=0 raiserror('Numele nu este valid.',10,1)
else if dbo.validate_id(@n+1)=0 raiserror('id-ul nu este valid.',10,1)
else
INSERT into Animal Values(@n+1,@nume,@tip,@boala,@varsta)
END

AS
begin 
return
(
select
case
when @an is NULL then 0
when @an >2005 then 0
Else 1
END
)
end
select @n=max(id_me) from Medic