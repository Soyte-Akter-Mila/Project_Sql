```

---

## 👤 Author
*   **Student Name:** Soyte Akter Mila[cite: 1]
*   **Trainee ID:** 1294109[cite: 1]
*   **Batch:** WADA/PNTL-M/69/01[cite: 1]
*   **TSP:** PeopleNTech Institute of Information Technology[cite: 1]
*   **Course:** IsDB-BISEW Diploma in Web Application Development Using ASP.NET[cite: 1]

---

## 🎓 Acknowledgments
Submitted to **Syed Zahidul Hassan**, Consultant at Show & Tell Consulting Ltd, for the IsDB-BISEW IT Scholarship ProgrammeThis GitHub `README.md` is tailored specifically for your **Learning Hub Coaching Management System (LHCMS)** project based on the documentation provided[cite: 1].

---

# Learning Hub Coaching Management System (LHCMS)

![IsDB-BISEW Logo](https://upload.wikimedia.org/wikipedia/en/b/b2/IsDB-BISEW_Logo.png) 

## 📝 Project Overview
The **Learning Hub Coaching Management System (LHCMS)** is a centralized RDBMS solution developed as part of the **IsDB-BISEW IT Scholarship Programme**[cite: 1]. This system is designed to automate the administrative and academic operations of a modern coaching institute, replacing traditional paper-based records with a robust SQL Server 2022 infrastructure[cite: 1].

### 🎯 Key Objectives
*   **Digital Transformation:** Move away from manual record-keeping to reduce data redundancy[cite: 1].
*   **Automation:** Use Triggers and Stored Procedures to handle business logic automatically[cite: 1].
*   **Data Integrity:** Ensure reliable data through Primary Keys, Foreign Keys, and Check Constraints[cite: 1].
*   **Analytical Insight:** Provide high-level reporting using CTEs, Ranking functions, and Aggregates[cite: 1].

---

## 🏗️ Database Architecture
The system is built on **11 core tables** organized to manage the complete student lifecycle[cite: 1]:

*   **User Management:** `students`, `instructors`, `staff`.
*   **Academic Core:** `courses`, `enrollments`, `class_schedule`, `attendance`.
*   **Performance:** `exams`, `result`.
*   **Finance & Communication:** `payments`, `notices`.



---

## 🚀 Key Features & Implementation

### 1. Advanced Business Logic (Automation)
*   **Triggers:** Includes `trg_UpdateCourseTimestamp` for audit trails and `trg_SoftDeleteStudent` to keep historical data active for financial audits without deleting records[cite: 1].
*   **Stored Procedures:** The `usp_EnrollStudent` procedure handles complex logic, such as checking `max_seats` availability before allowing a new registration[cite: 1].

### 2. Analytical Reporting
The project utilizes advanced DML operations to generate insights:
*   **Financial Summaries:** Uses `ROLLUP` and `CUBE` to summarize revenue by City and Gender[cite: 1].
*   **Performance Reports:** Employs **Common Table Expressions (CTEs)** to calculate average marks and rank the top 3 students using `DENSE_RANK()`[cite: 1].

### 3. Security & Performance
*   **View Encryption:** Sensitive instructor contact information is protected using `WITH ENCRYPTION` on views[cite: 1].
*   **Indexing:** Non-clustered indexes (`idx_student_name`, `idx_course_name`) are implemented to ensure fast searches even as the dataset grows[cite: 1].

---

## 🛠️ Tech Stack
*   **Database Engine:** SQL Server 2022[cite: 1]
*   **Tools:** SQL Server Management Studio (SSMS)
*   **Methodology:** Normalized Relational Database Design (RDBMS)[cite: 1]

---

## 📂 Project Structure
```text
├── SQL_Scripts/
│   ├── DDL_Schema.sql          # Table creations and constraints
│   ├── DML_SeedData.sql        # Sample data for testing
│   ├── Procedures_Triggers.sql # Stored procedures and automation logic
│   └── Analytical_Queries.sql  # CTEs, Joins, and Reporting
├── Documentation/
│   └── CaseStudy_Report.pdf    # Full project documentation
└── README.md
```

---

## 👤 Author
*   **Student Name:** Soyte Akter Mila[cite: 1]
*   **Trainee ID:** 1294109[cite: 1]
*   **Batch:** WADA/PNTL-M/69/01[cite: 1]
*   **TSP:** PeopleNTech Institute of Information Technology[cite: 1]
*   **Course:** IsDB-BISEW Diploma in Web Application Development Using ASP.NET[cite: 1]

---

## 🎓 Acknowledgments
Submitted to **Syed Zahidul Hassan**, Consultant at Show & Tell Consulting Ltd, for the IsDB-BISEW IT Scholarship Programme[cite: 1].
```
