/*
--------------------------------------------------------------------------------
					SQL Project Name : Learning Hub Coching Management System(LHCMS)
							    Trainee Name : Soyte Akter Mila 
						    	  Trainee ID : 1294109       
								Batch ID : WADA/PNTL-M/69/01 

 --------------------------------------------------------------------------------

Table of Contents: DDL
			=> SECTION 01: CHECK Database EXISTANCE & CREATE DATABASE WITH ATTRIBUTES [LHCMS]
			=> SECTION 02: CREATE TABLE WITH CONSTRAINTS DEFINE PRIMARY KEY AND FOREIGN KEY
			=> SECTION 03: CREATE INDEXES
			=> SECTION 04: CREATE TRIGGER, CREATE TRIGGER (INSTEAD OF TRIGGER)
			=> SECTION 05: CREATE A VIEW AND SCEMSBINDING
			=> SECTION 06: CREATE STORED PROCEDURE
			=> SECTION 07: CREATE FUNCTION



*/


/*
==============================  SECTION 01  ==============================
	   CHECK DATABASE EXISTANCE & CREATE DATABASE WITH ATTRIBUTES
==========================================================================
*/

USE master
GO

IF DB_ID('LHCMS') IS NOT NULL
DROP DATABASE LHCMS
GO

CREATE DATABASE LHCMS
ON
(
	name = 'lhcms_data',
	filename = 'E:\Project\lhcms_data.mdf',
	size = 10MB,
	maxsize = 100MB,
	filegrowth = 5%
)
LOG ON
(
	name = 'lhcms_log',
	filename = 'E:\Project\lhcms_log.ldf',
	size = 8MB,
	maxsize = 50MB,
	filegrowth = 5MB
)
GO

USE LHCMS
GO


/*
==============================  SECTION 02  ==============================
	 CREATE TABLE WITH CONSTRAINTS DEFINE PRIMARY KEY AND FOREIGN KEY
==========================================================================
*/




CREATE TABLE instructors 
(
    instructor_id  BIGINT PRIMARY KEY IDENTITY(1,1),
    full_name      VARCHAR(150) NOT NULL,
    email          VARCHAR(200) UNIQUE,
    phone          VARCHAR(30),
    expertise      VARCHAR(200),
    bio            TEXT,
    status         VARCHAR(10) CHECK(status IN  ('active','inactive')) DEFAULT 'active',
    created_at     DATETIME DEFAULT GETDATE(), 
    updated_at     DATETIME
)
Go


CREATE TABLE courses 
(
    course_id    BIGINT PRIMARY KEY IDENTITY(1,1),
    course_name   VARCHAR(200) NOT NULL,
    description    TEXT,
    duration_hours  INT CHECK (duration_hours >= 0),
    fee_amount       DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    start_date       DATE,
    end_date         DATE,
    max_seats        INT CHECK (max_seats >= 0),
    status           VARCHAR(20)CHECK(status IN ('scheduled','ongoing','completed','cancelled') )DEFAULT 'scheduled',
    created_at       DATETIME  DEFAULT GETDATE(),
    updated_at      DATETIME ,
    instructor_id    BIGINT,
    CONSTRAINT       fk_courses_instructor FOREIGN KEY (instructor_id)
     REFERENCES     instructors(instructor_id)
        ON UPDATE CASCADE ON DELETE SET NULL
)
GO



CREATE TABLE students 
(
    student_id         BIGINT PRIMARY KEY IDENTITY(1,1),
    full_name          VARCHAR(150) NOT NULL,
    father_name       VARCHAR(150),
    email              VARCHAR(200) UNIQUE,
    phone              VARCHAR(30),
    address_line       VARCHAR(250),
    city               VARCHAR(120),
    district           VARCHAR(120),
    date_of_birth      DATE,
    gender            VARCHAR(10)CHECK(GENDER IN ('male','female','other')),
    status             VARCHAR(20)CHECK(status IN ('active','inactive')) DEFAULT 'active',
    created_at         DATETIME  DEFAULT GETDATE(), 
    updated_at         BIGINT,
)
GO


CREATE TABLE enrollments
(
    enrollment_id      BIGINT PRIMARY KEY IDENTITY(1,1),
    student_id         BIGINT NOT NULL,
    course_id          BIGINT NOT NULL,
    enrollment_date    DATE DEFAULT (CURRENT_DATE),
    status             VARCHAR(20)CHECK(status IN ('enrolled','completed','dropped')) DEFAULT 'enrolled',
    remarks            VARCHAR(300),
    created_at        DATETIME  DEFAULT GETDATE(), 
    updated_at         DATETIME,
    CONSTRAINT fk_enroll_student FOREIGN KEY (student_id)
    REFERENCES students(student_id)
    ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_enroll_course FOREIGN KEY (course_id)
     REFERENCES courses(course_id)
     ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT uq_enroll_unique UNIQUE (student_id, course_id)
)
GO

CREATE TABLE payments
(
    payment_id     BIGINT PRIMARY KEY IDENTITY(1,1),
    student_id     BIGINT NOT NULL,
    enrollment_id  BIGINT,
    amount         DECIMAL(12,2) NOT NULL CHECK (amount >= 0),
    payment_date   DATE DEFAULT GETDATE() ,
    payment_method VARCHAR(20)CHECK (payment_method IN ('cash','bkash','nagad','card','bank_transfer'))NOT NULL,  
    reference_code VARCHAR (100),
    payment_status  VARCHAR(20)CHECK (payment_status IN ('created','pending','refunded'))DEFAULT 'created',
    notes          VARCHAR(255),
    created_at     DATETIME DEFAULT GETDATE(),
    updated_at     DATETIME,
    CONSTRAINT fk_pay_student FOREIGN KEY (student_id)
        REFERENCES students(student_id),
    CONSTRAINT fk_pay_enrollment FOREIGN KEY (enrollment_id)
        REFERENCES enrollments(enrollment_id)
)
GO

CREATE TABLE class_schedule 
(
    schedule_id        BIGINT PRIMARY KEY IDENTITY(1,1),
    course_id          BIGINT NOT NULL,
    instructor_id      BIGINT NOT NULL,
    class_date         DATE NOT NULL,
    start_time         TIME NOT NULL,
    end_time           TIME NOT NULL,
    room_no            VARCHAR(50),
    CONSTRAINT fk_schedule_course FOREIGN KEY (course_id)
    REFERENCES courses(course_id),
    CONSTRAINT fk_schedule_instructor FOREIGN KEY (instructor_id)
     REFERENCES instructors(instructor_id)
)
GO


CREATE TABLE attendance
(
    attendance_id      BIGINT PRIMARY KEY IDENTITY(1,1),
    student_id         BIGINT NOT NULL,
    schedule_id        BIGINT NOT NULL,
    status           VARCHAR(20)CHECK(status IN('present','absent','late')) DEFAULT 'present',
    remarks            VARCHAR(200),
    CONSTRAINT fk_attendance_student FOREIGN KEY (student_id)
        REFERENCES students(student_id),
    CONSTRAINT fk_attendance_schedule FOREIGN KEY (schedule_id)
        REFERENCES class_schedule(schedule_id)
)
GO


CREATE TABLE exams 
(
    exam_id            BIGINT PRIMARY KEY IDENTITY(1,1),
    course_id          BIGINT NOT NULL,
    exam_date          DATE NOT NULL,
    total_marks        INT NOT NULL,
    CONSTRAINT fk_exam_course FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
)
GO

CREATE TABLE result 
(
    result_id          BIGINT PRIMARY KEY IDENTITY(1,1),
    student_id         BIGINT NOT NULL,
    exam_id            BIGINT NOT NULL,
    marks_obtained     INT NOT NULL,
    grade              VARCHAR(5),
    remarks            VARCHAR(200),
    CONSTRAINT fk_result_student FOREIGN KEY (student_id)
        REFERENCES students(student_id),
    CONSTRAINT fk_result_exam FOREIGN KEY (exam_id)
        REFERENCES exams(exam_id)
)
go
-- Staff Table (non-teaching staff)

CREATE TABLE staff
(
    staff_id       BIGINT PRIMARY KEY IDENTITY(1,1),
    full_name      VARCHAR(100) NOT NULL,
    role           VARCHAR(50) NOT NULL,
    phone          VARCHAR(20),
    email          VARCHAR(100) UNIQUE,
    created_at     DATETIME DEFAULT GETDATE(),
    updated_at     DATETIME
)
go


CREATE TABLE notices (
    notice_id     BIGINT PRIMARY KEY IDENTITY(1,1),
    title         VARCHAR(150) NOT NULL,
    description   VARCHAR(500) NOT NULL,
    posted_by     BIGINT, 
    posted_date   DATE DEFAULT CAST(GETDATE() AS DATE),
    expiry_date   DATE,
    created_at    DATETIME DEFAULT GETDATE(),
    updated_at    DATETIME,
    CONSTRAINT fk_notice_staff FOREIGN KEY (posted_by)
        REFERENCES staff(staff_id)
)
Go


/*
==============================  SECTION 02  ==============================
	 CREATE TABLE WITH CONSTRAINTS DEFINE PRIMARY KEY AND FOREIGN KEY
==========================================================================
*/

-- 1. Add a Unique Constraint to the Students phone number
ALTER TABLE students
ADD CONSTRAINT uq_student_phone UNIQUE (phone);
GO

-- 2. Drop the constraint (Example)
-- ALTER TABLE students DROP CONSTRAINT uq_student_phone;
-- GO

-- 3. Add a Check Constraint to ensure exam marks are not negative
ALTER TABLE result
ADD CONSTRAINT ck_marks_not_negative CHECK (marks_obtained >= 0);
GO


/*
==============================  SECTION 03  ==============================
	CREATE INDEXES
==========================================================================
*/

-- Non-clustered index on Student Name for faster searching
CREATE NONCLUSTERED INDEX idx_student_name 
ON students (full_name);
GO

-- Non-clustered index on Course Name
CREATE NONCLUSTERED INDEX idx_course_name 
ON courses (course_name);
GO


/*
==============================  SECTION 04  ==============================
	CREATE TRIGGER, CREATE TRIGGER (INSTEAD OF TRIGGER)
==========================================================================
*/

CREATE TRIGGER trg_UpdateCourseTimestamp
ON courses
AFTER UPDATE
AS
BEGIN
    UPDATE courses
    SET updated_at = GETDATE()
    FROM inserted
    WHERE courses.course_id = inserted.course_id;
END;
GO


CREATE TRIGGER trg_SoftDeleteStudent
ON students
INSTEAD OF DELETE
AS
BEGIN
    UPDATE students
    SET status = 'inactive'
    WHERE student_id IN (SELECT student_id FROM deleted);
    
    PRINT 'Student record not deleted; status set to inactive.';
END;
GO
/*
==============================  SECTION 05  ==============================
	CREATE A VIEW AND SCEMSBINDING
==========================================================================
*/

CREATE VIEW vw_StudentEnrollmentDetails
AS
SELECT 
    s.full_name AS StudentName,
    c.course_name AS CourseName,
    i.full_name AS InstructorName,
    e.enrollment_date,
    e.status AS EnrollmentStatus
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
JOIN instructors i ON c.instructor_id = i.instructor_id;
GO


CREATE VIEW vw_SecureInstructorContact
WITH ENCRYPTION, SCHEMABINDING
AS
SELECT 
    instructor_id,
    full_name,
    email,
    phone
FROM dbo.instructors;
GO


/*
==============================  SECTION 06  ==============================
	CREATE STORED PROCEDURE
==========================================================================
*/
CREATE PROCEDURE usp_EnrollStudent
    @StudentID BIGINT,
    @CourseID BIGINT,
    @Remarks VARCHAR(300)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @CurrentEnrollments INT;
    DECLARE @MaxSeats INT;

    SELECT @MaxSeats = max_seats FROM courses WHERE course_id = @CourseID;
    SELECT @CurrentEnrollments = COUNT(*) FROM enrollments WHERE course_id = @CourseID;

    IF @CurrentEnrollments < @MaxSeats
    BEGIN
        INSERT INTO enrollments (student_id, course_id, enrollment_date, remarks)
        VALUES (@StudentID, @CourseID, CAST(GETDATE() AS DATE), @Remarks);
        PRINT 'Enrollment Successful';
    END
    ELSE
    BEGIN
        RAISERROR('Course is full. Enrollment failed.', 16, 1);
    END
END;
GO

/*
==============================  SECTION 07  ==============================
	CREATE FUNCTION
==========================================================================
*/

CREATE FUNCTION fn_GetStudentResults (@StudentID BIGINT)
RETURNS TABLE
AS
RETURN (
    SELECT 
        c.course_name,
        e.exam_date,
        r.marks_obtained,
        r.grade
    FROM result r
    JOIN exams e ON r.exam_id = e.exam_id
    JOIN courses c ON e.course_id = c.course_id
    WHERE r.student_id = @StudentID
);
GO
-----------------------------------------------------------------------------------------------------