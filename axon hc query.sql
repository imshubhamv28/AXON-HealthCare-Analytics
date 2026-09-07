
#--------------------------------------------------------------------------------------------------------------------------------------------------

#Total Patients
select count(patient_id) from patient;
#Total Doctors
select count(doctor_id) from doctors;
#Total Visits
select count(visit_id) from visit;
#Average Age of Patients
select round(avg(age),0) from patient;
#Top 5 Diagnosed Conditions
select diagnosis,count(diagnosis) from visit group by diagnosis order by 2 desc;
#Follow-Up Rate
select round((sum(case
when follow_up_required ='Yes' then 1 else 0 end) *100.0)/ count(patient_id),2) as Follow_up_rate  from visit;
#Average Treatment Cost Per Visit
select round(avg(total_episode_cost), 2) as average_treatment_cost_per_visit from treatment;
#Total Lab Tests Conducted
select count(lab_result_id) as total_lab_tests from lab_test;
#Percentage of Abnormal Lab Results
select round((sum(case
when test_result = 'Abnormal' then 1 else 0 end) * 100.0) / count(*),2) as abnormal_lab_result_percentage
from lab_test;
#Doctor Workload (Avg. Patients Per Doctor)
select round(count(distinct visit_id) * 1.0 /(select count(*) from doctors),2) as average_patients_per_doctor
from visit;


#--------------------------------------------------------------------------------------------------------------------------------------------------

select
    concat(p.first_name, ' ', p.last_name) as patient_name,
    v.visit_date,
    v.diagnosis,
    t.treatment_name,
    l.test_name,
    l.test_result
from patient as p
join visit as v
    on p.patient_id = v.patient_id
left join treatment as t
    on v.visit_id = t.visit_id
left join lab_test as l
    on v.visit_id = l.visit_id;

#--------------------------------------------------------------------------------------------------------------------------------------------------

#CASE STUDY-1
#Disease Trend Analysis

#What are the most frequently diagnosed diseases?

select * from visit;
select diagnosis,count(diagnosis) from visit group by diagnosis order by 2 desc;

#Which age groups are most affected by each disease?
select * from patient;
select * from visit;

select v.diagnosis, case 
when p.age between 0 and 17 then 'Children [0-17]'
when p.age between 18 and 35 then 'Young Adults [18-35]'
when p.age between 36 and 55 then 'Adults [36-55]'
else 'Senior Citizens [55+]'
end as Age_Group ,
count(*) Total_Patients from patient as p join visit as v on p.patient_id=v.patient_id
group by v.diagnosis,age_group
order by 1,2;

#Which age groups are most affected by each disease? 
with t as 
(select v.diagnosis, case
when p.age between 0 and 17 then 'Children [0-17 Age]'
when p.age between 18 and 35 then 'Young Adults [18-35 Age]'
when p.age between 36 and 55 then 'Adults [36-55 Age]'
else 'Senior Citizens' 
end as Age_Group, 
count(*) as No_Of_Patients 
from patient as p join visit as v on p.patient_id=v.patient_id
group by 1,2), 
rank_data as
(select *,row_number() over(partition by diagnosis order by No_of_Patients desc) as rnk from t)
select diagnosis,age_group,no_of_patients from rank_data where rnk=1;


# Which months have the highest number of disease cases?

select * from visit;
select visit_month_name as Month,count(diagnosis) as Total_Diseases from visit group by 1 order by 2 desc;

with t as
(select visit_month_name as Month, diagnosis, count(diagnosis) as Total_Diseases from visit group by 1,2 ),
rank_data as 
(select *, row_number() over(partition by month order by Total_diseases desc) as rnk from t)
select month,diagnosis,total_diseases from rank_data where rnk=1 order by total_diseases desc;


# CASE Study-2
# Doctor & Department Performance

# How many patients does each doctor handle?
select * from visit;
select * from doctors;

select v.doctor_id,d.doctor_name ,count(distinct v.patient_id) as Total_Patients 
from visit as v join doctors as d on v.doctor_id=d.doctor_id 
group by 1,2 order by 3 desc;

# Which departments handle the highest number of disease cases?

select * from visit;
select * from department;
select * from doctors;

select d.department_id,dp.department_name,count(v.diagnosis) as Disease_Cases
from doctors as d join visit as v on d.doctor_id=v.doctor_id 
join department as dp on dp.department_id=d.department_id group by 1,2  order by 3 desc;


#Which doctors have the highest follow-up rate?
select * from doctors;
select * from visit;
select * from department;

select v.doctor_id,d.doctor_name ,count(v.patient_id) Total_Patients, sum(case
when follow_up_required = 'Yes' then  1 else 0 end) as Total_follow_up_cases,
round((sum(case
when follow_up_required ='Yes' then 1 else 0 end) *100.0)/ count(patient_id),2) as Follow_up_rate 
from visit as v join doctors as d on v.doctor_id=d.doctor_id 
group by 1,2 order by 5 desc;


# Which doctors generate the highest treatment revenue?
select * from treatment;
select * from visit;
select * from doctors;

select d.doctor_id,d.doctor_name, round(sum(t.total_episode_cost),2) as Total_Revenue 
from treatment as t join visit as v on t.visit_id=v.visit_id join doctors as d on d.doctor_id = v.doctor_id group by 1,2 order by 2 desc;

#Which doctors perform the highest number of successful treatments?

select * from doctors;
select * from treatment;
select * from visit;

with t as(
select d.doctor_id,d.doctor_name,sum(case
when t.outcome = 'Successful' then 1 else 0 end) as T_Successful_treatments
from doctors as d join visit as v on d.doctor_id=v.doctor_id join treatment as t on t.visit_id=v.visit_id group by 1,2 order by 2 desc)
select doctor_name,T_Successful_treatments,dense_rank() over (order by T_Successful_treatments desc) as rnk from t;


#CASE Study-3
#Patient Care Analysis

# Which age groups require the highest follow-up rate?
select * from visit;
select * from patient;

select case 
when p.age between 0 and 17 then 'Children [0-17 Age]'
when p.age between 18 and 35 then 'Young Adults [18-35 Age]'
when p.age between 36 and 55 then 'Adults [36-55 Age]'
else 'Senior Citizens' 
end as Age_Group, 
round((sum(case
when follow_up_required = 'Yes' then 1 else 0 end) *100) /count(v.patient_id),2) as Follow_up_rate
from patient as p join visit as v on p.patient_id=v.patient_id group by 1 order by 2 desc;

# Which age groups visit hospital the most?

select * from patient;
select * from visit;

select case
when p.age between 0 and 17 then 'Children [0-17 Age]'
when p.age between 18 and 35 then 'Young Adults [18-35 Age]'
when p.age between 36 and 55 then 'Adults [36-55 Age]'
else 'Senior Citizens' 
end as Age_Group, count(*) Total_Patients
from patient as p join visit as v on p.patient_id=v.patient_id group by 1 order by 2 desc;

# Which age groups contribute the highest hospital revenue?
select * from patient;
select * from visit;
select * from treatment;

select case 
when p.age between 0 and 17 then 'Children [0-17 Age]'
when p.age between 18 and 35 then 'Young Adults [18-35 Age]'
when p.age between 36 and 55 then 'Adults [36-55 Age]'
else 'Senior Citizens' 
end as Age_Group,count(v.visit_id)as Total_Visits ,round(sum(t.total_episode_cost),2) as Revenue
from patient as p join visit as v on p.patient_id=v.patient_id join treatment as t on t.visit_id=v.visit_id group by 1 order by 2 desc;



#CASE Study-4: Treatment Cost & Effectiveness Analysis

# Which treatments are most frequently performed?
select * from treatment;
select * from visit;

select treatment_name,count(treatment_name) as Total_Performed from treatment group by 1 order by 2 desc;

# Which treatments have the highest average treatment cost?
select * from treatment;
select treatment_name,round(avg(total_episode_cost),2) as AVG_Treatment_Cost from treatment group by 1 order by 2 desc;

# CASE Study-5: Insurance & Revenue Analysis
# What is the total hospital revenue?

select * from treatment;
select round(sum(total_episode_cost),2) as T_Hospital_Revenue from treatment;

# How much payment is still outstanding
select * from billing;
select round(sum(outstanding),2) from billing;

# What is the insurance claim approval rate
select * from ins_claims;

select claim_status,count(*) as total_claims,
round((count(*) * 100.0) /(select count(*) from ins_claims),2) as percentage
from ins_claims group by claim_status order by total_claims desc;

# Which insurance providers handle the highest number of claims?

select * from ins_provider;
select * from ins_claims;
select ip.provider_name, count(ic.claim_id) as T_Claims 
from ins_provider as ip join ins_claims as ic on ip.provider_id=ic.provider_id group by 1 order by 2 desc;

# Which insurance providers have the highest claim approval rate?

select * from ins_provider;
select * from ins_claims;
select ip.provider_name, round((sum(case 
when claim_status='Approved' then 1 else 0 end) *100)/count(ic.claim_status),2) as Claim_Approval_Rate 
from ins_provider as ip join ins_claims as ic on ip.provider_id=ic.provider_id group by 1 order by 2 desc;

