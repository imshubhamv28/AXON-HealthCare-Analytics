<div align="center">

<img width="931" height="525" alt="Home Page" src="https://github.com/user-attachments/assets/a8f31f41-d0d5-4b14-8d85-b8ad87655bf8" />

<img width="925" height="517" alt="Executive Dashboard" src="https://github.com/user-attachments/assets/1374d692-24f7-428d-a60f-79391b1fa440" />

<img width="927" height="517" alt="Patients Analytics" src="https://github.com/user-attachments/assets/e854d714-7513-4684-913d-c23cc1c46a67" />

<img width="927" height="521" alt="Clinical Operations" src="https://github.com/user-attachments/assets/a5cd4e69-0791-4549-8748-431787151f83" />

<img width="930" height="520" alt="Doctor Performance" src="https://github.com/user-attachments/assets/9e56fddd-3323-4f4f-b8f5-a0a0b9ad3fb8" />

<img width="930" height="522" alt="Project Overview" src="https://github.com/user-attachments/assets/82999ae2-c86f-43a7-aa5b-c56768d58e43" />


# 🏥 AXON — Healthcare EMR Analytics Project

### Turning fragmented EMR activity into decision-ready intelligence for hospital leadership, clinical teams, and finance

![SQL](https://img.shields.io/badge/SQL-MySQL-4479A1?style=flat-square&logo=mysql&logoColor=white)
![Excel](https://img.shields.io/badge/Excel-Power%20Pivot-217346?style=flat-square&logo=microsoftexcel&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-DAX-F2C811?style=flat-square&logo=powerbi&logoColor=black)
![Tableau](https://img.shields.io/badge/Tableau-Dashboards-E97627?style=flat-square&logo=tableau&logoColor=white)
![Status](https://img.shields.io/badge/Status-Phase%201%20Delivered-success?style=flat-square)
![License](https://img.shields.io/badge/License-MIT-blue?style=flat-square)

</div>

---

## 📌 Project Overview

<img src="assets/project_overview.png" alt="Project Overview" width="850"/>

| Field | Detail |
|---|---|
| **Analyst** | Shubham Vishwakarma |
| **Role** | Data Analyst |
| **Project** | AXON HealthCare Analytics |
| **Domain** | Healthcare / EMR Hospital Operations |
| **Program** | ExcelR — AI Variant Capstone (Group Project, Group 6) |
| **Tools Used** | Power BI, Excel, Tableau, SQL, DAX, Data Modeling |
| **Dataset** | Hospital EMR Dataset — 10,000 Patients, 10,000 Visits, 1,000 Doctors (2023–2025) |

**Objective:** Analyze hospital EMR data using Power BI by evaluating patient demographics, clinical operations, doctor performance, and financial outcomes — enabling interactive, data-driven hospital management decisions.

**Business Requirements:**
- Analyze patient chronic-condition and demographic trends across age, gender, and state
- Track visit completion, cancellation, and follow-up rates on a monthly basis
- Identify Top 5 diagnoses based on visit volume
- Surface Top 5 doctors by revenue contribution
- Compare doctor workload vs. completion rate across specialties
- Analyze revenue distribution across departments and specialties

> **Key finding:** Patient and visit volume is strong, but completion, treatment success, and doctor performance all converge around the same ~33% mark — signaling a **hospital-wide scheduling and care-continuity gap**, not a department- or doctor-specific issue.

---

## 🎓 About This Capstone (Read First)

This project was built on **ExcelR's "AXON Healthcare Analytics" capstone brief** — a standardized 10,000-patient EMR dataset, 7-table star schema, and KPI framework issued as the assignment template, with a public reference/study hub maintained by **Mahendra Singh** ([LinkedIn](https://www.linkedin.com/in/mahendra-singh-83699485/) · [Medium](https://medium.com/@mahendraa1188)).

**What came from the template:** the dataset shape, the star-schema data model, the KPI catalog, the dashboard specifications, and the reference data-pipeline pattern (EMR → Source DB → ETL → Data Warehouse → BI tools).

**What is this team's own work:** all SQL scripts and analytical case studies, the Excel Power Pivot model, the Power BI semantic model and full DAX measure library, the Tableau workbook, the four delivered dashboards (screenshots below), and the business insights and recommendations drawn from the data.

Flagging this distinction explicitly rather than presenting the architecture as originally designed in-house — the value added here is the implementation, the SQL logic, the dashboard build, and the insight work, not the underlying assignment structure.

---

## 🎯 Business Objective

Hospital data was scattered across disconnected operational systems, making it hard to answer basic questions: *How full is our patient pipeline? Which visits are falling through? Are treatments working? Are we getting paid?*

This project builds a single analytical layer that answers those questions across **six business domains** — Patient Care, Operations, Treatment, Diagnostics, Revenue, and Insurance.

> **Decision principle:** one metric definition → one backend logic → multiple BI views.

---

## 🔄 Data Flow Architecture

<img width="2172" height="724" alt="DataFlow" src="https://github.com/user-attachments/assets/ad919ba2-64e1-4530-9de5-a07af79450b4" />

Raw EMR activity (patients · visits · billing) lands in a **source database**, passes through an **ETL layer** (Extract → Transform → Load), and is modeled into a **Star Schema data warehouse**. From there, the same governed dataset feeds **Tableau**, **Power BI**, and downstream **AI/Insights** — one model, multiple consumption layers. *(Reference pipeline pattern from the capstone brief — implemented against this project's own SQL build and BI files.)*

**Tool-connection rule followed in this build:**
- **Excel** works directly on the source dataset — cleaning and the first-pass dashboard are built straight from the spreadsheet.
- **Tableau and Power BI do *not* connect to the Excel file**, and never connect to each other. Both connect **only to the SQL database** (`healthcare_db`) as their data source.
- **QA/validation** runs SQL queries directly against the backend and reconciles every count, sum, and average against what the Tableau and Power BI dashboards display.

---

## 🧬 Database Schema

<img width="1054" height="1493" alt="Schema" src="https://github.com/user-attachments/assets/b192353b-383d-4d95-b2b6-5a026647e279" />

The `healthcare_db` MySQL schema contains **9 relational tables**, all loaded and queried via `HealthCare_DataBase.sql`:

- `patient` — demographics & health profile
- `doctor` — specialty, credentials, department
- `department` — department lookup
- `visit` — **central fact table**, every encounter
- `treatment` — cost, medication, outcome per visit
- `lab_test` — diagnostic results per visit
- `billing` — revenue-cycle data
- `insurance_policy` — patient coverage details
- `insurance_claims` — payer-side claim status
- `insurance_provider` — payer master data

Modeled as a **Star Schema** with `visit` as the central fact table; `treatment`, `lab_test`, and `billing` attach through `Visit ID`, and `visit` links to `patient` and `doctor` dimensions. Zero orphan foreign keys — verified via SQL referential-integrity checks.

<br clear="right"/>

---

## 🛠️ Tech Stack & Modeling Approach

| Layer | Tool | Role |
|---|---|---|
| Preparation | **SQL (MySQL)** | Schema design, KPI logic, 5 analytical case studies |
| Preparation | **Excel** | Power Pivot data model, PivotTable KPI validation |
| Visual/Relationship layer | **Tableau** | Connects to SQL only; relationship-based model, interactive drill-down dashboards |
| Semantic/DAX layer | **Power BI** | Connects to SQL only; star schema, fact/dimension separation, DAX measures |

### DAX Measure Library

<img width="265" height="557" alt="Measures" src="https://github.com/user-attachments/assets/21b57361-e0fb-4c1b-aaa5-ba792b561c35" />

A dedicated `TableMeasure_Patients` measure table holds 20+ centralized DAX measures — including Active Patients, Cancellation Rate, Chronic Patient Rate, Doctor Success Rate, Doctor's Visit Completion Rate, Follow-Up Rate, Insurance Coverage Rate, Success Rate, and Top Doctor Revenue — so every dashboard page pulls from **one governed calculation**, never a page-local formula.

<br clear="right"/>

---

## 📈 Dashboards Delivered (Phase 1)

> Four dashboards are fully built in Power BI and Tableau. Treatment & Outcomes, Lab Test Analytics, and Financial & Billing dashboards are scoped for **Phase 2** — the underlying data already exists in the model. (The capstone's full brief specifies 7 dashboards total; this repo documents the 4 actually delivered.)

### 1️⃣ Executive Dashboard — *Hospital CEO / Board*

<img width="925" height="517" alt="Executive Dashboard" src="https://github.com/user-attachments/assets/1374d692-24f7-428d-a60f-79391b1fa440" />

A high-level snapshot of total patients, visits, treatment success, and revenue billed across departments — a fast, single view of hospital-wide performance.

| Metric | Value |
|---|---|
| Total Patients | 10K |
| Total Visits | 10K |
| Revenue | $25M |
| Chronic Patient Rate | 80.4% |
| Success Rate | 33.01% |
| Patient Visit Completion Rate | 33.25% |

- Revenue is evenly spread across General Medicine, Cardiology, and Pediatrics (~$4.3M each)
- **Migraine, Asthma, Healthy, Hypertension, Diabetes** are the top 5 diagnoses by volume (~1.5–1.6K visits each)
- Patient outcomes split almost evenly across Successful (33.01%), Ongoing (33.51%), and Failed (33.48%) — a signal worth investigating further

### 2️⃣ Patient Analytics — *Clinical Staff / Case Management*

<img width="927" height="517" alt="Patients Analytics" src="https://github.com/user-attachments/assets/ea87f896-5b37-4e58-9067-b8690cca7e29" />

Explore patient demographics, age groups, chronic conditions, allergies, blood types, and insurance coverage to understand who your patients are and what they need.

| Metric | Value |
|---|---|
| Total Patients | 10K |
| New Registrations | 295 |
| Average Patient Age | 49 |
| Chronic Patient Rate | 80.4% |
| Insurance Coverage Rate | 87% |

- Near-even gender split (Male 32.83% / Female 33.14% / Other 34.03%)
- Patients concentrated in the 21–40 and 41–60 age bands (~2.2–2.3K each)
- Top chronic conditions: Arthritis, Diabetes, Asthma, Hypertension
- High-risk patient list cross-tabs diagnosis against Failed / Ongoing / Successful outcome counts for targeted case management

### 3️⃣ Clinical Operations Analytics — *Department Heads / Nursing*

<img width="927" height="521" alt="Clinical Operations" src="https://github.com/user-attachments/assets/b2b676fd-0497-40bd-a898-022f85439ae9" />

Monitor visit completion, cancellations, follow-up compliance, and emergency load by day and month to spot scheduling gaps and keep daily operations running smoothly.

| Metric | Value |
|---|---|
| Total Visits | 10K |
| Patient Visit Completion | 33.25% |
| Cancellation Rate | 33.44% |
| Follow-Up Rate | 25.21% |
| Emergency Visits | 24.38% |

- Visit types are near-evenly split across Follow-up, Specialist Consult, Routine Checkup (2.0K each), and Emergency (1.9K)
- Migraine again leads diagnosis volume (1,633), followed by Asthma, Healthy, Hypertension, Diabetes
- Doctor Workload vs. Completion Rate scatter identifies which doctors are carrying high visit volume without proportional completion — a staffing/capacity signal

### 4️⃣ Doctor Performance Analysis — *Medical Director / HR*

<img width="930" height="520" alt="Doctor Performance" src="https://github.com/user-attachments/assets/09cf82d3-e3e3-4d06-97b4-f3a2ae5abfe7" />

Compare doctor workload, years of experience, completion and success rates, and revenue contribution across specialties to identify top performers and staffing needs.

| Metric | Value |
|---|---|
| Total Doctors | 1K |
| Doctor's Avg Experience | 21 Yrs |
| Top Doctor Revenue | $79K |
| Doctor's Visit Completion | 96.90% |
| Doctor Success Rate | 96.20% |
| Avg Visit Duration | 56.61 min |

- Revenue is led by General Medicine, Pediatrics, and Cardiology (~1.7K each)
- Vaccination visits carry the highest treatment success rate (63.36%), Medication the lowest (58.55%)
- Doctor headcount is fairly balanced across Cardiology (20.8%), Pediatrics (20.4%), Orthopedics (19%), General Medicine (21.2%), and Neurology (18.6%)
- Emergency visit outcomes: 34.44% Ongoing, 32.51% Failed, 33.05% Successful

---

## 💡 From Data to Decisions

| Lens | Signal | Action |
|---|---|---|
| Demand Planning | Migraine tops diagnosis volume across dashboards | Plan capacity around diagnosis + seasonal concentration |
| Visit Operations | 33.44% cancelled vs 33.25% completed | Review scheduling, reminders, slot allocation |
| Chronic Care | 80.4% of patients marked chronic | Prioritize follow-up capacity & long-term pathways |
| Doctor Workload | Doctor-level completion (96.9%) far exceeds patient-level completion (33.25%) | Investigate the gap between doctor-attributed and patient-journey completion definitions |
| Revenue | $25M billed, evenly spread across top 5 departments | Balanced service-line performance — no single point of revenue risk |
| Insurance | 87% insurance coverage rate | Strong payer coverage; monitor claim approval and processing time next |

---

## 🗂️ Repository Structure

```
axon-healthcare-analytics/
├── assets/
│   ├── home_page.png
│   ├── project_overview.png
│   ├── data_flow.png
│   ├── schema.png
│   ├── measures.png
│   ├── executive_dashboard.png
│   ├── patient_analytics.png
│   ├── clinical_operations.png
│   └── doctor_performance.png
├── data/
│   ├── Patient.csv
│   ├── Doctor.csv
│   ├── Department.csv
│   ├── Visit.csv
│   ├── Treatment.csv
│   ├── Lab_Test.csv
│   ├── Billing.csv
│   ├── Insurance_Provider.csv
│   ├── Insurance_Policy.csv
│   └── Insurance_Claims.csv
├── sql/
│   ├── HealthCare_DataBase.sql     # Schema + full data load
│   └── axon_hc_query.sql          # KPI logic + 5 analytical case studies
├── excel/
│   └── EMR_dashboards.xlsx        # Power Pivot data model + PivotTable KPIs
├── powerbi/
│   └── HealthCare_Analytics.pbix  # Star-schema semantic model + DAX measures
├── tableau/
│   └── Axon_Healthcare_Analytics.twbx
├── docs/
│   ├── EMR_BRD_Full_7_Dashboard.docx
│   ├── EMR_BRD_Phase1_4Dashboards.docx
│   └── AXON_Healthcare_12_Slide.pptx
└── README.md
```

> ⚠️ **For the screenshots above to render on GitHub:** commit the `assets/` folder at the repo root, in the same commit as this `README.md`, with these exact filenames (all lowercase, as listed above). GitHub renders relative image paths (`assets/executive_dashboard.png`) based on the README's own location — if `README.md` sits at the repo root, `assets/` must sit at the repo root too. If you rename the folder or files, update the `<img src="...">` paths in this file to match, or the images will show as broken links after commit.

---

## 🚀 How to Reproduce This Project

1. **Load the schema** — run `sql/HealthCare_DataBase.sql` in MySQL Workbench to create and populate the `healthcare_db` schema (patient, doctor, department, visit, treatment, lab_test, billing, insurance_policy, insurance_claims, insurance_provider).
2. **Run KPI logic** — execute `sql/axon_hc_query.sql` to validate KPI figures and explore the 5 analytical case studies.
3. **Excel** — open `excel/EMR_dashboards.xlsx`; the Power Pivot model works directly off the raw dataset (not off SQL) — this is the one exception in the pipeline.
4. **Power BI** — open `powerbi/HealthCare_Analytics.pbix`; point the connection at your local `healthcare_db` (SQL, not Excel), then explore the `TableMeasure_Patients` DAX library across all four dashboard pages.
5. **Tableau** — open `tableau/Axon_Healthcare_Analytics.twbx`; it's a packaged workbook connected to `healthcare_db`, ready to explore.
6. **QA** — re-run `axon_hc_query.sql` against your loaded schema and reconcile every figure against what's shown on the Power BI and Tableau dashboards before treating any KPI as final.

---

## 🧭 Phase 2 Roadmap

Planned dashboards (data model already supports these, not yet built as standalone views):

- **Treatment & Outcomes** — medication usage, cost breakdown, discontinued-treatment analysis
- **Lab Test Analytics** — abnormal-result trends, test-volume analysis, monthly lab load
- **Financial & Billing** — claims analysis, payer performance, collections monitoring

---

## 🏆 Business Impact

- **Improved Decision-Making** — a single governed view of key hospital KPIs for management
- **Operational Efficiency** — surfaced concrete gaps in visit completion, follow-ups, and doctor workload
- **Better Clinical Monitoring** — treatment outcomes and chronic-condition patterns now trackable at scale
- **Revenue Visibility** — clearer monitoring of billing, insurance coverage, and department-level revenue
- **Data-Driven Planning** — insights feeding resource allocation and care-pathway decisions

---

## 👥 Team

**Group 6 — ExcelR AI Variant**

| Name | Role |
|---|---|
| Shubham Vishwakarma | Data Analyst — BRD, KPI Framework, SQL, Power BI | www.linkedin.com/in/imshubhamv28
| Ananya | Data Analyst | Tableau | https://www.linkedin.com/in/ananyasanap/
| Suraj | Data Analyst | Excel, Power Quary | https://www.linkedin.com/in/suraj-ranpise-05bb1887/

---

## 🙏 Acknowledgments

- Capstone brief, dataset shape, and KPI/dashboard specification: **ExcelR** "AXON Healthcare Analytics" program.
- Reference/study hub used during preparation: **Mahendra Singh** — [emr-site-nine.vercel.app](https://emr-site-nine.vercel.app/), [LinkedIn](https://www.linkedin.com/in/mahendra-singh-83699485/), [Medium](https://medium.com/@mahendraa1188).
---

## 📬 Connect

If this project is useful or you'd like to discuss healthcare analytics, BI dashboard design, or SQL data modeling — feel free to connect or open an issue.

**#HealthcareAnalytics #EMR #PowerBI #Tableau #SQL #DataAnalytics #BusinessIntelligence**

---
<sub>Dataset is synthetic and built for training/analytical/portfolio use only. Not sourced from real patient records; not intended for clinical or regulatory use.</sub>
</div>
