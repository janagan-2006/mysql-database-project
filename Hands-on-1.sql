DROP DATABASE IF EXISTS college_db;
CREATE DATABASE college_db;
USE college_db;

CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name      VARCHAR(100) NOT NULL,
    hod_name       VARCHAR(100),
    budget         DECIMAL(12,2)
);

CREATE TABLE students (
    student_id       INT PRIMARY KEY AUTO_INCREMENT,
    first_name       VARCHAR(50) NOT NULL,
    last_name        VARCHAR(50) NOT NULL,
    email            VARCHAR(100) UNIQUE NOT NULL,
    date_of_birth    DATE,
    department_id    INT,
    enrollment_year  INT,
    CONSTRAINT fk_students_department
        FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE courses (
    course_id       INT PRIMARY KEY AUTO_INCREMENT,
    course_name     VARCHAR(150) NOT NULL,
    course_code     VARCHAR(20) UNIQUE,
    credits         INT,
    department_id   INT,
    CONSTRAINT fk_courses_department
        FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE enrollments (
    enrollment_id    INT PRIMARY KEY AUTO_INCREMENT,
    student_id       INT,
    course_id        INT,
    enrollment_date  DATE,
    grade            CHAR(2),
    CONSTRAINT fk_enrollments_student
        FOREIGN KEY (student_id) REFERENCES students(student_id),
    CONSTRAINT fk_enrollments_course
        FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE professors (
    professor_id    INT PRIMARY KEY AUTO_INCREMENT,
    prof_name       VARCHAR(100) NOT NULL,
    email           VARCHAR(100) UNIQUE,
    department_id   INT,
    salary          DECIMAL(10,2),
    CONSTRAINT fk_professors_department
        FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

SHOW TABLES;
DESCRIBE departments;
DESCRIBE students;
DESCRIBE courses;
DESCRIBE enrollments;
DESCRIBE professors;

ALTER TABLE students
    ADD COLUMN phone_number VARCHAR(15);

ALTER TABLE courses
    ADD COLUMN max_seats INT DEFAULT 60;

ALTER TABLE enrollments
    ADD CONSTRAINT chk_grade_valid
    CHECK (grade IN ('A','B','C','D','F') OR grade IS NULL);

ALTER TABLE departments
    CHANGE COLUMN hod_name head_of_dept VARCHAR(100);

ALTER TABLE students
    DROP COLUMN phone_number;

SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'college_db' AND TABLE_NAME = 'students';

SELECT COLUMN_NAME, DATA_TYPE, COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'college_db' AND TABLE_NAME = 'courses';

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'college_db' AND TABLE_NAME = 'departments';

SELECT CONSTRAINT_NAME, CHECK_CLAUSE
FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = 'college_db';
