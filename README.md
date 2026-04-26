This README is based on the project documentation found in **CASE STEADY_1294109.pdf**[cite: 1].

---

# Learning Hub Coaching Management System (LHCMS)

## 📝 Executive Summary
The **Learning Hub Coaching Management System (LHCMS)** is a centralized database solution designed to automate the administrative and academic operations of a modern coaching institute[cite: 1]. By replacing traditional paper-based records with a robust **SQL Server 2022** infrastructure, the system manages the entire student lifecycle—from enrollment and attendance to examinations and fee payments[cite: 1].

---

## 🚀 Key Objectives
*   **Digital Transformation:** Replace manual management in urban areas to eliminate data redundancy and reporting delays[cite: 1].
*   **Automation:** Implement **Triggers** and **Stored Procedures** to handle complex business logic automatically[cite: 1].
*   **Data Integrity:** Ensure reliable information through the strict use of Primary Keys, Foreign Keys, and Check Constraints[cite: 1].
*   **Analytical Insight:** Provide high-level reporting using CTEs, Ranking, and Aggregates[cite: 1].

---

## 🏗️ Database Architecture
The system is built on **11 core tables** organized to handle various institutional functions[cite: 1]:

### Core Tables
| Category | Tables |
| :--- | :--- |
| **People** | `students`, `instructors`, `staff`[cite: 1] |
| **Academics** | `courses`, `enrollments`, `class_schedule`, `attendance`[cite: 1] |
| **Evaluation** | `exams`, `result`[cite: 1] |
| **Admin** | `payments`, `notices`[cite: 1] |

---

## 🛠️ Advanced Features & Implementation

### 1. Automation via Triggers
The system includes "Silent Workers" to maintain database health[cite: 1]:
*   **`trg_UpdateCourseTimestamp`**: Automatically updates time records whenever course details are modified[cite: 1].
*   **`trg_SoftDeleteStudent`**: Instead of permanent deletion, it sets a student's status to 'inactive' to preserve historical data for audits[cite: 1].

### 2. Encapsulation with Stored Procedures
*   **`usp_EnrollStudent`**: This procedure handles complex enrollment logic, such as checking if the `max_seats` for a course has been reached before allowing a new entry[cite: 1].

### 3. Analytics and Reporting
*   **Common Table Expressions (CTEs)**: Used to calculate average marks across exams to generate performance reports[cite: 1].
*   **Ranking Functions**: Utilizes `DENSE_RANK()` to identify top students for scholarship awards[cite: 1].
*   **Financial Summaries**: Uses `ROLLUP` and `CUBE` to generate revenue reports by city and gender[cite: 1].

### 4. Security & Performance
*   **View Encryption**: The `vw_SecureInstructorContact` view is created **WITH ENCRYPTION** to protect instructor privacy[cite: 1].
*   **Indexing Strategy**: Non-clustered indexes are applied to `student_name` and `course_name` to accelerate searches in large datasets[cite: 1].

---

## 👤 Project Metadata
*   **Student Name:** Soyte Akter Mila[cite: 1]
*   **Trainee ID:** 1294109[cite: 1]
*   **Batch:** WADA/PNTL-M/69/01[cite: 1]
*   **Course:** IsDB-BISEW Diploma in Web Application Development Using ASP.NET[cite: 1]
*   **Module:** SQL Server 2022[cite: 1]
*   **TSP:** PeopleNTech Institute of Information Technology[cite: 1]
*   **Submission Date:** 30th December 2025[cite: 1]

---

## 🎓 Acknowledgments
Submitted to **Syed Zahidul Hassan**, Consultant at Show & Tell Consulting Ltd, as part of the **IsDB-BISEW IT Scholarship Programme**[cite: 1].
