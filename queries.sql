
-- The busiest day in a week
SELECT CASE date_part('isodow', start_time) 
	WHEN 1 THEN 'Sunday'
    WHEN 2 THEN 'Monday'
    WHEN 3 THEN 'Tuesday'
    WHEN 4 THEN 'Wednesday'
	WHEN 5 THEN 'Thursday'
	WHEN 6 THEN 'Friday'
	WHEN 7 THEN 'Saturday' END AS busiest_day
FROM hospital.appointments 
GROUP BY busiest_day
ORDER BY count(*) DESC LIMIT 1;


-- Prescription most commonly prescribed
SELECT prescription_name AS most_common_prescription FROM hospital.prescriptions
WHERE prescription_id =
	(SELECT prescription FROM hospital.medical_records
	 GROUP BY prescription
	 ORDER BY count(prescription) DESC LIMIT 1);
	 
	 
-- Doctors, and their phone numbers, assigned to the Anesthitic department
SELECT (d_first_name ||' '|| d_last_name) AS doctor, d_phone_number AS phone_number
FROM hospital.doctors
WHERE department = 
	(SELECT department_ID FROM hospital.departments
	 WHERE department_name = 'Anesthetic')
	

-- Patients who had an appointment on the 8th of January 1953, their doctor and their care plan	 
SELECT (p_first_name ||' '|| p_last_name) AS patient_name, (d_first_name ||' '|| d_last_name) AS doctor_name, description
FROM hospital.patients
	JOIN hospital.care_plans
	ON hospital.patients.care_plan = hospital.care_plans.care_plan_ID
	JOIN hospital.appointments
	ON hospital.care_plans.doctor = hospital.appointments.doctor
	JOIN hospital.doctors
	ON hospital.appointments.doctor = hospital.doctors.doctor_ID
WHERE DATE(start_time) = '1953-01-08'
GROUP BY patient_name, doctor_name, description 
	 
	 
-- Doctor with the longest queue times
SELECT (d_first_name ||' '|| d_last_name) AS busiest_doctor FROM hospital.doctors
WHERE doctor_id = 
	(SELECT doctor FROM hospital.medical_records
	GROUP BY doctor
	ORDER BY count(*) DESC LIMIT 1);
	 
	 
-- Patient that has spent most money on medications and the amount (displayed in dollars)	
SELECT (p_first_name ||' '|| p_last_name) AS patient, total_cost FROM hospital.patients
JOIN(SELECT patient, SUM(medicin_cost) AS total_cost FROM
		(SELECT patient, (CAST(count(prescription) AS DOUBLE PRECISION)* 
						  CAST(prescription_cost AS DOUBLE PRECISION)) 
		 				  AS medicin_cost FROM hospital.medical_records 
		JOIN hospital.prescriptions 
		ON hospital.prescriptions.prescription_ID = hospital.medical_records.prescription
		GROUP BY prescription_cost, patient) 
	GROUP BY patient
	ORDER BY SUM(medicin_cost) DESC) AS costs
ON costs.patient = patients.patient_ID
ORDER BY total_cost DESC limit 1;


-- Patient that has stayed longest (including appointments) in the hospital and the time spent
SELECT (p_first_name ||' '|| p_last_name) AS patient, time_spent FROM hospital.patients
JOIN(SELECT COALESCE(patient_1, patient_2) AS patient, (COALESCE(total_stay,'0') 
	+ COALESCE(total_appointments,'0')) AS time_spent FROM
		(SELECT patient AS patient_1, SUM(end_time - start_time) AS total_stay
		FROM hospital.stay
		GROUP BY patient_1
		ORDER BY total_stay DESC) AS total_stay
	JOIN
		(SELECT patient as patient_2, SUM(end_time - start_time) AS total_appointments
		FROM hospital.appointments
		GROUP BY patient_2
		ORDER BY total_appointments DESC) AS total_time
	ON total_stay.patient_1 =  total_time.patient_2) AS time_spent
ON time_spent.patient = patients.patient_ID	
ORDER BY time_spent DESC LIMIT 1;



	 
	 
	 
	 