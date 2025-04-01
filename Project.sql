CREATE DATABASE Employee;

-- Task-3
select EMP_ID,FIRST_NAME,LAST_NAME,GENDER,DEPT from emp_record_table
	order By DEPT;
    
-- Task-4
select EMP_ID,FIRST_NAME,LAST_NAME,GENDER,DEPT,EMP_RATING,
	CASE
		when Emp_rating < 2 then 'Low'
        when Emp_rating <= 4 then 'Avg'
        else 'High'
    end as Rating_Status
	from emp_record_table;

-- Task 5

select Concat(First_Name,' ',Last_Name) as NAME from emp_record_table
	where DEPT = 'Finance';
    
-- Task 6
select m.FIRST_NAME Manager_Name,Count(*) from
	emp_record_table e JOIN emp_record_table m 
    ON e.Manager_ID = m.EMP_ID
    group by m.FIRST_NAME;


select DISTINCT m.FIRST_NAME Manager_Name from
	emp_record_table e JOIN emp_record_table m 
    ON e.Manager_ID = m.EMP_ID;
    
-- Task 7

select * from emp_record_table where DEPT = 'HEALTHCARE'
UNION
select * from emp_record_table where DEPT = 'FINANCE';

-- Task 8
select EMP_ID,FIRST_NAME,LAST_NAME,ROLE,DEPT,EMP_RATING,
	Max(Emp_Rating) over(partition by DEPT ) Max_Emp_Rating	from emp_record_table;
    
-- Task 9
select Role, MIN(Salary) lowest, Max(Salary) Hieghest	from emp_record_table
	group by ROLE;
    
-- Task 10
select EMP_ID,FIRST_NAME,LAST_NAME,EXP, 
	Rank() over(order by Exp desc) as RankByExp
    from emp_record_table;

-- Task 11
create View V_Emp_6k
as
select EMP_ID,FIRST_NAME,LAST_NAME,COUNTRY from emp_record_table where Salary > 6000
	ORDER bY COUNTRY;
    
SELECT * FROM V_Emp_6k;

-- TASK 12
SELECT * FROM emp_record_table where Emp_ID IN (SELECT EMP_ID FROM emp_record_table WHERE EXP > 10); 


-- Task - 13

DELIMITER $$
USE `employee`$$
CREATE PROCEDURE P_Emp_3YrsExp ()
BEGIN
	select * from emp_record_table where exp > 3;
END$$

DELIMITER ;

call P_Emp_3YrsExp;

-- Task 14

DELIMITER $$
USE `employee`$$
CREATE FUNCTION `Task14`(eid   varchar(5)) 
RETURNS varchar(100) 
    DETERMINISTIC
BEGIN
	declare ex int;
   -- declare r varchar(80);
    declare vrole varchar(100);
    declare flag varchar(10);
    select exp, ROLE into ex, VROLE from data_science_team where emp_ID = eid;
  
		if ex > 12 and ex < 16 then
			if VROLE = 'Manager' then
				set flag = 'Yes';
			else
				set flag = 'No';
			end if;
			# set r = 'Manager';
		elseif ex > 10 and ex <= 12 then 
			if VROLE = 'LEAD DATA SCIENTIST' then
				set flag = 'Yes';
			else
				set flag = 'No';
			end if;
			#set r = 'LEAD DATA SCIENTIST';
		elseif ex > 5 and ex <=10 then 
			if VROLE = 'SENIOR DATA SCIENTIST' then
				set flag = 'Yes';
			else
				set flag = 'No';
			end if;
			#set r ='SENIOR DATA SCIENTIST';
		elseif ex > 2 and ex <=5 then
			if VROLE = 'ASSOCIATE DATA SCIENTIST' then
				set flag = 'Yes';
			else
				set flag = 'No';
			end if;
			#set r = 'ASSOCIATE DATA SCIENTIST';
		elseif ex <= 2 then
			if VROLE = 'JUNIOR DATA SCIENTIST' then
				set flag = 'Yes';
			else
				set flag = 'No';
			end if;
			#set r = 'JUNIOR DATA SCIENTIST';
		end if;
	

RETURN flag;
END$$
DELIMITER ;
;

SELECT *,Task14(Emp_ID) FROM data_science_team;

-- Task-15

select * from emp_record_table where First_Name='Eric';

create Index idx_emp_Fname on emp_record_table(First_Name);

select * from emp_record_table where First_Name='Eric';


-- Task 16

select EMP_ID,FIRST_NAME,SALARY,EMP_RATING,
	(Emp_rating * 0.05 * SALARY) Bonus	from emp_record_table;
    
-- Task 17
select CONTINENT,COUNTRY,Avg(Salary) from emp_record_table
	group by CONTINENT,COUNTRY with rollup
    order by CONTINENT,COUNTRY;