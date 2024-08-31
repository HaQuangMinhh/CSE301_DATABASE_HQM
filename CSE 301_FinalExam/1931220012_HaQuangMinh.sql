-- 1. Creating Constraint for the tables in Database (10 marks) 

-- a) Implement a constraint to ensure that the Grade field only accepts values between 0 and 10. 
alter table student_course add constraint check_grade check ( grade between 0 and 10 ) ; 


-- b) Implement a constraint to ensure that the Semester field only accepts values between 1 and 3. 
alter table student_course add constraint check_semester check ( semester between 1 and 3 ) ; 


-- 2. Writing SQL query (30 marks) 


-- a) Update the results in the Result_Course table such that any grade below 5 is marked as 'Fail' 
-- and any grade 5 or above is marked as 'Pass'. 
update student_course set result = case when grade >= 5 then "Pass" else "fail" end ; 

select * from student_course ; 

-- b) Count the number of students who failed in each course and display only the courses where 
-- more than one student has failed. 
select StudentID , count(grade) as Number_student_failed from student_course
where grade < 5  
group by studentID 
having Number_student_failed > 1 ;   

select * from students ; 

-- c) Find the names of lecturers and the average grade that students received in the courses they 
-- taught. 
select lec.LecturerName , Avg(stc.grade) from lecturers lec
inner join student_course stc on lec.LecturerID = stc.LecturerID 
group by lecturerName ; 


-- d) Find the course names and the highest and lowest grades that students achieved in each 
-- course during the first semester of the 2023-2024 academic year. 
select Co.CourseName , max(stc.grade) as HighestGrades , min(stc.grade) as LowestGrades from Courses co
inner join student_course stc on co.courseID = stc.courseID
where stc.semester = 1 and AcademicYear = "2023-2024" 
group by co.courseName; 


-- e) Find the names of students who have achieved grades greater than or equal to 5.0 in all their 
-- courses.
select studentName from students where studentID not in (
select distinct st.studentID from students st inner join student_course stc on st.studentID = stc.studentID 
where stc.grade < 5.0) ; 


-- f) Find the list of students (StudentName, StudentID) who are eligible for a scholarship in the 
-- first semester of the 2023-2024 academic year. Eligibility criteria include a minimum average 
-- grade of 8.0 and no failed courses. List the top 5 students based on their average grade. 




-- g) Create a stored procedure to update the grade of a student in a specific course.
delimiter $$ 
	create procedure Update_grade ( in i_studentName varchar(50) , in i_course varchar(50) , in i_grade decimal(5,2) ) 
    begin 
		update ( select stc.grade , st.studentName , co.courseName from Courses co
        inner join student_course stc on co.courseID = stc.courseID 
        inner join students st on st.studentID = stc.studentID ) 
        set stc.grade = i_grade , st.studentName = i_studentName , co.courseName = i_course ; 
	end ;  
$$ delimiter 




 