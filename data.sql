
CREATE TABLE hospital.patients (
	patient_ID char(4) PRIMARY KEY,
	p_first_name varcharhospital.(20),
	p_last_name varchar(20),
	p_address varchar(50),
	p_phone_number char(10),
	care_plan char(4) REFERENCES hospital.care_plans(care_plan_ID)
)

INSERT INTO hospital.patients (patient_ID, p_first_name, p_last_name, p_address, p_phone_number, care_plan) VALUES
(1001, 'Linnea', 'Johansson', 'Ringvägen 10B, 17070 Solna', 0736659878, 5004),
(1002, 'Karl', 'Lindberg','Skogsstigen 2, 18400 Åkersberga', 0704775925, 5005),
(1003, 'Anna', 'Nordin','Bergsgatan 72, 19124 Sollentuna', 0702264988, 5008),
(1004, 'Erik', 'Jonsson','Björkvägen 13, 12333 Farsta', 0731181901, 5001),
(1005, 'Sofi', 'Wallin','Odengatan 20, 10044 Stockholm', 0705301744, 5002),
(1006, 'Mikael', 'Holm','Humlegatan 43, 10215 Stockholm', 0702730032, 5007),
(1007, 'Anna', 'Söderström','Stationsgatan 11, 18037 Täby', 0733989881, 5009),
(1008, 'Johan', 'Andersson','Granstigen 7, 14731 Tumba', 0735535010, 5003),
(1009, 'Clara', 'Viklund','Ängägen 9B, 12524 Älvsjö', 0702320649, 5010),
(1010, 'Jan', 'Lindgren','Hornsgatan 27, 10041 Stockholm', 0703203348, 5006);

CREATE TABLE hospital.doctors (
	doctor_ID char(4) PRIMARY KEY,
	d_first_name varchar(20),
	d_last_name varchar(20),
	department char(4) REFERENCES hospital.departments(department_ID),
	d_phone_number char(10)
)

INSERT INTO hospital.doctors (doctor_ID, d_first_name, d_last_name, department, d_phone_number) VALUES
(2001, 'Tobias', 'Moberg', 3003, 0736659878),
(2002, 'Matilda', 'Oscarsson', 3007, 07023764333),
(2003, 'Måns', 'Lindgren', 3004, 0733774980),
(2004, 'Josefin', 'Ohlin', 3008, 0702213535),
(2005, 'Gustav', 'Gustafsson', 3009, 0700198984),
(2006, 'Fatima', 'Juhlin', 3009, 0702354547),
(2007, 'Emilia', 'Nordgren', 3001, 07044498673),
(2008, 'Johan', 'Krok', 3010, 0730967930),
(2009, 'Stella', 'Nilsson', 3002, 0732255343),
(2010, 'Joar', 'Andersson', 3006, 0707745458);


CREATE TABLE hospital.departments (
	department_ID char(4) PRIMARY KEY,
	department_name varchar(30)
) 

INSERT INTO hospital.departments (department_ID, department_name) VALUES
(3001, 'Cardiology'),
(3002, 'Emergency'),
(3003, 'Oncology'),
(3004, 'Psychiatric'),
(3005, 'Urology'),
(3006, 'Surgery'),
(3007, 'Radiology'),
(3008, 'Accident'),
(3009, 'Anesthetic'),
(3010, 'Neurology');
 
 
CREATE TABLE hospital.appointments (
	appointment_ID char(4) PRIMARY KEY,
	start_time timestamp,
	end_time timestamp,
	patient char(4) REFERENCES hospital.patients(patient_ID),
	doctor char(4) REFERENCES hospital.doctors(doctor_ID),
	prescription char(4) REFERENCES hospital.prescriptions(prescription_ID)
) 

INSERT INTO hospital.appointments (appointment_ID, start_time, end_time, patient, doctor, prescription) VALUES
(4001, '1953-01-08 11:00:00', '1953-01-08 11:50:00', 1001, 2007, 6007),
(4002, '1952-12-30 08:00:00', '1952-12-30 10:00:00', 1010, 2001, 6010),
(4003, '1953-01-08 15:30:00', '1953-01-08 16:00:00', 1005, 2004, 6003),
(4004, '1953-01-08 14:00:00', '1953-01-08 15:10:00', 1002, 2008, 6006),
(4005, '1953-01-08 10:00:00', '1953-01-08 11:00:00', 1003, 2007, 6002),
(4006, '1953-02-02 08:00:00', '1953-02-02 08:40:00', 1001, 2009, 6009),
(4007, '1953-02-05 09:20:00', '1953-02-05 10:00:00', 1004, 2004, 6004),
(4008, '1953-01-08 12:00:00', '1953-01-08 13:00:00', 1008, 2006, 6001),
(4009, '1953-01-11 14:30:00', '1953-01-11 15:10:00', 1003, 2007, 6005),
(4010, '1953-03-08 13:00:00', '1953-03-08 13:30:00', 1009, 2003, 6008);
 
 
CREATE TABLE hospital.care_plans (
	care_plan_ID char(4) PRIMARY KEY,
	doctor char(4) REFERENCES hospital.doctors(doctor_ID),
	description varchar(100)
)

INSERT INTO hospital.care_plans (care_plan_ID, doctor, description) VALUES
(5001, 2007, 'Radical prostatectomy every forth week'),	
(5002, 2008, 'Daily exercise and if no improvements surgery'),	
(5003, 2004, 'Therapy every thursday'),	
(5004, 2006, 'Cholecystectomy'),	
(5005, 2001, 'Upper GI Endoscopy '),	
(5006, 2003, 'Chemotherapy'),	
(5007, 2010, 'Weekly check ups'),	
(5008, 2006, 'Strict diet before colostomy'),	
(5009, 2008, 'Tests, x-rays and scans once a year for check up'),	
(5010, 2002, 'Dialysis three times a week');	


CREATE TABLE hospital.prescriptions (
	prescription_ID char(4) PRIMARY KEY,
	prescription_name varchar(30),
	dose char(6),
	prescription_cost char(6)
) 

INSERT INTO hospital.prescriptions (prescription_ID, prescription_name, dose, prescription_cost) VALUES
(6001, 'Acetaminophen', 160, 20),
(6002, 'Xanax', 0.5, 50.9),
(6003, 'Lisinopril', 30, 9.9),
(6004, 'Augmentin', 250, 69),
(6005, 'Ibuprofen', 800, 49.7),
(6006, 'Humira', 40, 32),
(6007, 'Methotrexate', 2.5, 55),
(6008, 'Tramadol', 100, 9.8),
(6009, 'Amoxicillin', 600, 39.9),
(6010, 'Farxiga', 10, 22);


CREATE TABLE hospital.medical_records (
	medical_record_ID char(4) PRIMARY KEY,
	patient char(4) REFERENCES hospital.patients(patient_ID),
	doctor char(4) REFERENCES hospital.doctors(doctor_ID),
	prescription char(4) REFERENCES hospital.prescriptions(prescription_ID)
) 

INSERT INTO hospital.medical_records (medical_record_ID, patient, doctor, prescription) VALUES
(7001, 1001, 2007, 6007), (7002, 1003, 2002, 6004), (7003, 1007, 2002, 6005),
(7004, 1010, 2001, 6010), (7005, 1005, 2008, 6009), (7006, 1005, 2001, 6003),
(7007, 1005, 2004, 6003), (7008, 1001, 2005, 6010), (7009, 1009, 2008, 6006),
(7010, 1002, 2008, 6005), (7011, 1007, 2006, 6002), (7012, 1005, 2010, 6002),
(7013, 1003, 2007, 6002), (7014, 1004, 2007, 6003), (7015, 1002, 2003, 6001),
(7016, 1001, 2009, 6009), (7017, 1004, 2006, 6004), (7018, 1003, 2002, 6010),
(7019, 1004, 2004, 6004), (7020, 1010, 2010, 6008), (7021, 1010, 2007, 6008),
(7022, 1008, 2006, 6001), (7023, 1008, 2009, 6007), (7024, 1007, 2005, 6005),
(7025, 1003, 2007, 6005), (7026, 1002, 2002, 6007), (7027, 1010, 2007, 6007),
(7028, 1009, 2003, 6008), (7029, 1008, 2004, 6005), (7030, 1006, 2005, 6004);


CREATE TABLE hospital.stay (
	stay_ID char(4) PRIMARY KEY,
	patient char(4) REFERENCES patients(patient_ID),
	room char(3), 
	start_time timestamp,
	end_time timestamp
) 

INSERT INTO hospital.stay (stay_ID, patient, room, start_time, end_time) VALUES
(8001, 1003, 912, '1952-10-28 10:50:00', '1952-11-04 12:00:00'),
(8002, 1004, 922, '1952-12-15 11:00:00', '1952-12-17 08:00:00'),
(8003, 1004, 912, '1952-11-21 08:00:00', '1952-11-23 10:30:00'),
(8004, 1001, 902, '1952-11-09 12:30:00', '1952-11-09 19:00:00'),
(8005, 1009, 928, '1952-12-04 17:00:00', '1952-12-08 10:00:00'),
(8006, 1002, 900, '1953-01-13 08:00:00', '1953-01-13 16:20:00'),
(8007, 1004, 920, '1952-12-25 07:30:00', '1953-01-02 09:00:00'),
(8008, 1001, 904, '1952-10-11 08:00:00', '1952-10-16 14:00:00'),
(8009, 1004, 912, '1953-01-07 22:10:00', '1953-01-09 09:30:00'),
(8010, 1010, 904, '1952-09-30 16:00:00', '1952-10-30 10:00:00');



