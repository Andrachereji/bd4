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
declare @v intset @v=7exec adaugare_animal 'Tomas','pisica','deparazitare',@vselect * from Animal;create procedure adaugare_consultatie(@id_a int, @id_me int,@dat date, @boala varchar(100))as beginif dbo.validate_id(@id_a)=0 raiserror('id-ul nu e valid.',10,1)else if dbo.validate_id(@id_me)=0 raiserror('id-ul nu e valid.',10,1)elseINSERT into Consultatie Values(@id_a,@id_me,@dat,@boala)ENDexec adaugare_consultatie 7,12,'2022-11-10','vaccin'select * from Consultatie;create function validator_year(@an int)RETURNS bit
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
endcreate procedure adaugare_medic(@nume varchar(50), @an_abs int)as begin declare @n int set @n=0
select @n=max(id_me) from Medicif dbo.validate_id(@n+1)=0 raiserror('id-ul nu e valid.',10,1)else if dbo.validate_name(@nume)=0 raiserror('Numele nu este valid.',10,1)else if dbo.validator_year(@an_abs)=0 raiserror('Anul nu este valid',10,1)else INSERT into Medic values(@n+1,@nume,@an_abs)ENDexec adaugare_medic 'Ionescu Mihai',1998;select *from Medic;--view care contine numele animalului si numele medicului care l-a consultatCreate view Animal_Medic as Select Animal.nume as NumeAnimal, Medic.nume as NumeMedic from Animal INNER JOIN Consultatie on Animal.id_a=Consultatie.id_aINNER JOIN Medic on Consultatie.id_me=Medic.id_meselect * from Animal_Medic;--trigger pentru adaugare consultatiegocreate or alter trigger AdAnimal on Animalfor Insert as beginprint 'Adaugare ' + convert(varchar(50),getdate(),121)+' Animal'end;--trigger pentru stergere consulatiegocreate or alter trigger DeleteAnimal on Animalfor Deleteas beginprint 'Stergere ' + convert(varchar(50),getdate(),121)+' Animal 'end;declare @varsta intset @varsta=9exec adaugare_animal 'ion', 'caine','vaccin',@varstaselect * from Animal