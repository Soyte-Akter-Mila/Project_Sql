/*====================================================================================================
					  	SQL Project Name : Learning Hub Coching Management System(LHCMS)
======================================================================================================
					
								 Trainee Name : Soyte Akter Mila 
						    	  Trainee ID : 1294109       
								Batch ID : WADA/PNTL-M/69/01 

------------------------------------------------------------------------------------------------------
                                          DOCUMENT STRUCTURE: DML                         
------------------------------------------------------------------------------------------------------

                          => SECTION 01: INSERT DATA INTO TABLES										
                          => SECTION 02: RETRIEVE DATA USING VIEW
                          => SECTION 03: INSERT DATA THROUGH STORED PROCEDURE
                          => SECTION 04: RETRIEVE DATA USING USER-DEFINED FUNCTIONS (UDF)   										
                          => SECTION 05: USING AN INDEX			
                          => SECTION 06: SQL DML QUERIES FROM TPRMS PROJECT						
                          - Coverage:
                	      :: All types of JOIN						
                	      :: ALL, DISTINCT, TOP, PERCENT, WITH TIES
                	      :: String Expressions, Concatenate			
                	      :: GROUP BY, HAVING
				          :: Arithmetic Expressions							  
				          :: ROLLUP, CUBE, GROUPING SETS
				          :: Logical Operator (AND, OR, NOT)							
				          :: Comparison Operator, BETWEEN
				          :: Range of Selected Rows (OFFSET FETCH)		  
				          :: Compound Join
				          :: UNION, UNION ALL, EXCEPT, INTERSECT   
				          :: GROUP BY, HAVING
				          :: Subqueries											   
				          :: CTE, Recursive CTE
    			          :: CAST, CONVERT, TRY_CONVERT
				          :: Other Data Conversion Functions				   
				          :: Numeric Functions
				          :: Date Functions										   
				          :: COALESCE, ISNULL, CASE
				          :: IIF, CHOOSE										   
				          :: Temporary Tables, Table Variables
				          :: Ranking Functions								  	   
				          :: System Stored Procedures						   
				          :: TRY-CATCH block to handle errors			   
------------------------------------------------------------------------------------------------------




==========================================  SECTION 01  ==============================================
										INSERT DATA INTO TABLES	
==========================================================================*===========================*/

USE LHCMS
GO


-- Insert Instructors
INSERT INTO instructors (full_name, email, phone, expertise, bio, status)
VALUES 
('Dr. Ariful Islam', 'ariful@example.com', '01711223344', 'Data Science', '10 years of experience in AI.', 'active'),
('Sarah Jenkins', 'sarah.j@example.com', '01822334455', 'Web Development', 'Senior Full Stack Developer.', 'active')
go

-- Insert Staff
INSERT INTO staff (full_name, role, phone, email)
VALUES 
('Rahim Uddin', 'Administrator', '01911001122', 'rahim.admin@example.com'),
('Karim Ahmed', 'Accountant', '01555667788', 'karim.acc@example.com')
go

-- Insert Students
-- Note: updated_at is BIGINT in your schema, so we use a timestamp value.
INSERT INTO students (full_name, father_name, email, phone, city, gender, status, updated_at)
VALUES 
('Tanvir Hossain', 'Anwar Hossain', 'tanvir@example.com', '01300112233', 'Dhaka', 'male', 'active', 202310101230),
('Mitu Akter', 'Siddiqur Rahman', 'mitu@example.com', '01600112233', 'Chittagong', 'female', 'active', 202310101230)
go

-- Insert Courses (Depends on Instructors)
INSERT INTO courses (course_name, description, duration_hours, fee_amount, start_date, max_seats, instructor_id, status)
VALUES 
('SQL Mastery', 'Advanced SQL for Professionals', 40, 5000.00, '2024-01-15', 30, 1, 'scheduled'),
('React Basics', 'Introduction to React.js', 30, 4500.00, '2024-02-01', 25, 2, 'scheduled')
go

-- Insert Staff Notices (Depends on Staff)
INSERT INTO notices (title, description, posted_by, expiry_date)
VALUES 
('Winter Vacation', 'The institute will remain closed from Dec 25-30.', 1, '2024-12-31')
go

-- Insert Enrollments (Depends on Students and Courses)
INSERT INTO enrollments (student_id, course_id, status, remarks)
VALUES 
(1, 1, 'enrolled', 'First installment paid'),
(2, 1, 'enrolled', 'Full payment done')
go

-- Insert Exams (Depends on Courses)
INSERT INTO exams (course_id, exam_date, total_marks)
VALUES 
(1, '2024-03-01', 100),
(2, '2024-03-15', 100)
go

-- Insert Class Schedules (Depends on Courses and Instructors)
INSERT INTO class_schedule (course_id, instructor_id, class_date, start_time, end_time, room_no)
VALUES 
(1, 1, '2024-01-15', '10:00:00', '12:00:00', 'Room 302'),
(2, 2, '2024-02-01', '14:00:00', '16:00:00', 'Lab 1')
go

-- Insert Payments (Depends on Students and Enrollments)
INSERT INTO payments (student_id, enrollment_id, amount, payment_method, payment_status)
VALUES 
(1, 1, 2500.00, 'bkash', 'created'),
(2, 2, 5000.00, 'cash', 'created')
go

-- Insert Attendance (Depends on Students and Schedule)
INSERT INTO attendance (student_id, schedule_id, status, remarks)
VALUES 
(1, 1, 'present', 'On time'),
(2, 1, 'late', 'Traffic jam')
go

-- Insert Results (Depends on Students and Exams)
INSERT INTO result (student_id, exam_id, marks_obtained, grade)
VALUES 
(1, 1, 85, 'A'),
(2, 1, 92, 'A+')
go


/*
==========================================  SECTION 02  ==============================================
                                     RETRIEVE DATA USING VIEW
======================================================================================================*/

-- 1. Using the basic view for student enrollment details
SELECT * FROM vw_StudentEnrollmentDetails;
GO

-- 2. Using the secure view (with encryption and schemabinding)
SELECT full_name, email 
FROM vw_SecureInstructorContact 
WHERE full_name LIKE 'Dr.%';
GO


/*
==========================================  SECTION 03  ==============================================
                               INSERT DATA THROUGH STORED PROCEDURE
======================================================================================================*/

-- Enrolling a new student (ID 1) into Course 2 using the procedure
EXEC usp_EnrollStudent 
    @StudentID = 1, 
    @CourseID = 2, 
    @Remarks = 'Enrolled via Stored Procedure';
GO


/*
==========================================  SECTION 04  ==============================================
                           RETRIEVE DATA USING USER-DEFINED FUNCTIONS (UDF)
======================================================================================================*/

-- Get exam results for Tanvir Hossain (Student ID 1) using the Table-Valued Function
SELECT * FROM dbo.fn_GetStudentResults(1);
GO


/*
==========================================  SECTION 05  ==============================================
                                        USING AN INDEX
======================================================================================================*/

-- Queries that utilize the non-clustered indexes on full_name and course_name
SELECT student_id, full_name, email 
FROM students 
WHERE full_name = 'Tanvir Hossain'; -- Uses idx_student_name
GO

SELECT course_id, course_name, fee_amount 
FROM courses 
WHERE course_name = 'SQL Mastery'; -- Uses idx_course_name
GO


/*
==========================================  SECTION 06  ==============================================
                               SQL DML QUERIES FROM TPRMS PROJECT
======================================================================================================*/


/* 1. All Types of JOIN (Inner, Left, Right, Full, Cross) */
-- Inner Join: Students and their enrolled courses
SELECT s.full_name, c.course_name 
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c ON e.course_id = c.course_id;

-- Left Join: All students and their payments (even if they haven't paid yet)
SELECT s.full_name, p.amount, p.payment_status
FROM students s
LEFT JOIN payments p ON s.student_id = p.student_id;

-- Right Join: All courses and their instructors
SELECT c.course_name, i.full_name AS Instructor
FROM courses c
RIGHT JOIN instructors i ON c.instructor_id = i.instructor_id;

-- Full Outer Join: Match students and results (to see students without exams and exams without results)
SELECT s.full_name, r.marks_obtained
FROM students s
FULL OUTER JOIN result r ON s.student_id = r.student_id;

-- Cross Join: Every student paired with every course (Potential marketing list)
SELECT s.full_name, c.course_name
FROM students s
CROSS JOIN courses c;
GO


/* 2. Selection Modifiers: DISTINCT, TOP, PERCENT, WITH TIES */
-- TOP 1 with Ties: Get the highest mark(s) in an exam
SELECT TOP 1 WITH TIES student_id, marks_obtained
FROM result
ORDER BY marks_obtained DESC;


/* 3. String Expressions & Concatenate */
SELECT 
    UPPER(full_name) AS UpperName,
    LOWER(email) AS LowerEmail,
    CONCAT(full_name, ' lives in ', city) AS Description,
    SUBSTRING(phone, 1, 3) AS OperatorCode
FROM students;
GO


/* 4. Aggregates with ROLLUP, CUBE, and GROUPING SETS */
-- Summary of fee amounts by city and gender with sub-totals
SELECT city, gender, SUM(fee_amount) AS TotalPotentialRevenue
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
GROUP BY ROLLUP (city, gender);

-- Using CUBE for all possible combinations
SELECT city, gender, COUNT(student_id) AS StudentCount
FROM students
GROUP BY CUBE (city, gender);

-- Using GROUPING SETS for specific summaries
SELECT city, gender, COUNT(*) AS Total
FROM students
GROUP BY GROUPING SETS ((city), (gender), ());
GO


/* 5. Arithmetic Expressions & Logical Operators (AND, OR, NOT, BETWEEN) */
SELECT course_name, fee_amount, 
       (fee_amount * 1.15) AS FeeWithTax, -- 15% VAT
       (fee_amount - 500) AS DiscountedFee
FROM courses
WHERE (fee_amount BETWEEN 2000 AND 6000) 
  AND status != 'cancelled' 
  OR NOT (max_seats < 10);
GO


/* 6. Range of Selected Rows (OFFSET FETCH) */
-- Skip first student and take the next 2 (Pagination)
SELECT student_id, full_name
FROM students
ORDER BY student_id
OFFSET 1 ROWS FETCH NEXT 2 ROWS ONLY;
GO


/* 7. Set Operators: UNION, UNION ALL, EXCEPT, INTERSECT */
-- UNION: Combine names of Students and Instructors
SELECT full_name, 'Student' AS Category FROM students
UNION
SELECT full_name, 'Instructor' FROM instructors;

-- EXCEPT: Students who have NOT made a payment yet
SELECT student_id FROM students
EXCEPT
SELECT student_id FROM payments;
GO


/* 8. Subqueries (Nested & Correlated) */
-- Find courses where the fee is higher than the average fee
SELECT course_name, fee_amount 
FROM courses
WHERE fee_amount > (SELECT AVG(fee_amount) FROM courses);
GO


/* 9. CTE (Common Table Expression) & Recursive CTE */
-- Standard CTE to calculate student performance
WITH StudentPerformance AS (
    SELECT student_id, AVG(marks_obtained) AS AvgMarks
    FROM result
    GROUP BY student_id
)
SELECT s.full_name, sp.AvgMarks
FROM students s
JOIN StudentPerformance sp ON s.student_id = sp.student_id;

-- Simple Recursive CTE: Generating a sequence of 5 days (e.g., for a week view)
WITH DateSeries AS (
    SELECT CAST(GETDATE() AS DATE) AS ExamDate
    UNION ALL
    SELECT DATEADD(DAY, 1, ExamDate)
    FROM DateSeries
    WHERE ExamDate < DATEADD(DAY, 4, GETDATE())
)
SELECT * FROM DateSeries;
GO


/* 10. Data Conversion: CAST, CONVERT, TRY_CONVERT */
SELECT 
    CAST(payment_date AS VARCHAR) AS CastDate,
    CONVERT(VARCHAR, payment_date, 103) AS BritishFormat, -- DD/MM/YYYY
    TRY_CONVERT(INT, '123') AS SuccessfulConvert,
    TRY_CONVERT(INT, 'ABC') AS FailedConvert -- Returns NULL instead of error
FROM payments;
GO


/* 11. Logical Functions: COALESCE, ISNULL, CASE, IIF, CHOOSE */
SELECT 
    full_name,
    ISNULL(phone, 'No Phone') AS Contact,
    COALESCE(address_line, city, 'Address Missing') AS Location,
    IIF(status = 'active', 'Member', 'Inactive') AS MemberStatus,
    CASE 
        WHEN status = 'active' THEN 'Access Granted'
        ELSE 'Access Denied'
    END AS AccessLevel,
    CHOOSE(2, 'Bronze', 'Silver', 'Gold') AS RankExample
FROM students;
GO


/* 12. Ranking Functions */
SELECT 
    full_name,
    marks_obtained,
    ROW_NUMBER() OVER(ORDER BY marks_obtained DESC) AS RowNum,
    RANK() OVER(ORDER BY marks_obtained DESC) AS RankVal,
    DENSE_RANK() OVER(ORDER BY marks_obtained DESC) AS DenseRankVal
FROM result r
JOIN students s ON r.student_id = s.student_id;
GO


/* 13. Temporary Tables & Table Variables */
-- Table Variable
DECLARE @CityList TABLE (CityName VARCHAR(50));
INSERT INTO @CityList SELECT DISTINCT city FROM students;
SELECT * FROM @CityList;

-- Local Temporary Table
CREATE TABLE #TempCourseSummary (
    CourseID BIGINT,
    StudentCount INT
);
INSERT INTO #TempCourseSummary
SELECT course_id, COUNT(student_id) FROM enrollments GROUP BY course_id;

SELECT * FROM #TempCourseSummary;
DROP TABLE #TempCourseSummary;
GO


/* 14. Error Handling with TRY-CATCH & System Stored Procedures */
BEGIN TRY
    -- Intentionally failing query (Divide by Zero)
    SELECT 1/0;
END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage,
        ERROR_SEVERITY() AS Severity;
END CATCH;

-- System Stored Procedure example
EXEC sp_help 'students'; -- Get metadata of the table
GO


--=================================== END DML =======================================