# Find the name of all patients who was examined by Dr x on Aug 1, 2021
SELECT DISTINCT
    p.Patient_Id, p.Name
FROM
    patient AS p
        JOIN
    appointment AS a ON p.Patient_Id = a.Patient_Id
WHERE
    a.DVM_Id = '603250932'
        AND a.Schedule > '2021-08-01 00:00:00'
        AND a.Schedule < '2021-08-01 23:59:59';

# Find the name of all patients who was examined by Dr x on Aug 1, 2021 (Using nested queries)
SELECT DISTINCT
    p.*
FROM
    patient AS p
        JOIN
    appointment AS a ON p.Patient_Id = a.Patient_Id
WHERE
    a.DVM_Id = '603250932'
        AND a.Schedule IN (SELECT 
            a2.Schedule
        FROM
            appointment AS a2
        WHERE
            a2.Schedule > '2021-08-01 00:00:00'
                AND a2.Schedule < '2021-08-01 23:59:59');

# Find the age of pets diagnosed with pancreatitis
SELECT 
    p.Patient_id,
    p.Name,
    YEAR(CURRENT_DATE()) - YEAR(p.Birthdate) AS Age
FROM
    patient AS p
        JOIN
    appointment AS a ON p.Patient_Id = a.Patient_Id
        JOIN
    condition_diagnosed AS cd ON a.Appoint_Id = cd.Appoint_Id
        JOIN
    `action` AS ac ON cd.Cond_code = ac.`Code`
WHERE
    ac.Description = 'Pancreatitis';
    
# Find all info on patients with Primary Owner x (searched by name instead of id)
SELECT
	p.*
FROM
	patient AS p
		JOIN
	owner AS o ON p.Primary_Owner = o.Owner_Id
WHERE
	o.name = "Shane M Woodfin";

# Find all info on dvms who Specializes in x 
SELECT
	e.*
FROM
	employee AS e
		JOIN
	dvm AS d ON e.SIN = d.DVM_Id
WHERE
	d.Specialization = "Dentist";

# Find names of patients and DVM under appointments
SELECT a.*, p.name AS Patient_Name, e.name AS DVM_Name
FROM 
	appointment AS a
		JOIN
	patient AS p ON a.Patient_Id = p.Patient_Id
		JOIN
	employee AS e ON a.DVM_Id = e.SIN;

# Find all appointments booked for Dr x
SELECT a.*, p.name AS Patient_Name, e.name AS DVM_Name
FROM 
	appointment AS a
		JOIN
	patient AS p ON a.Patient_Id = p.Patient_Id
		JOIN
	employee AS e ON a.DVM_Id = e.SIN
WHERE 
	e.name = "Stacie S Lee";

# Find all appointments booked by Staff member x    
SELECT a.*, e.name AS Staff_Name
FROM
	appointment AS a
		JOIN
	employee AS e ON a.Staff_Id = e.SIN
WHERE 
	e.name = "Jacob J Talkington";

# Counting the number of patients and their avg age with x condition  
SELECT COUNT(p.Patient_id) as NO_OF_PATIENTS, AVG(YEAR(CURRENT_DATE()) - YEAR(p.Birthdate)) as AVG_AGE, cd.Cond_code
FROM PATIENT as p
JOIN appointment AS a ON p.Patient_Id = a.Patient_Id
        JOIN
    condition_diagnosed AS cd ON a.Appoint_Id = cd.Appoint_Id
        JOIN
    `action` AS ac ON cd.Cond_code = ac.`Code`
GROUP BY cd.Cond_code;

# Counting the number of patients that are Feline and older than 5 yrs old with x condition  
SELECT COUNT(p.Patient_id) as NO_OF_PATIENTS, AVG(YEAR(CURRENT_DATE()) - YEAR(p.Birthdate)) as AVG_AGE, cd.Cond_code
FROM PATIENT as p
JOIN appointment AS a ON p.Patient_Id = a.Patient_Id
        JOIN
    condition_diagnosed AS cd ON a.Appoint_Id = cd.Appoint_Id
        JOIN
    `action` AS ac ON cd.Cond_code = ac.`Code`
WHERE p.Species = 'Feline'
GROUP BY cd.Cond_code
HAVING AVG_AGE > 5;

# Order patients by their age
SELECT p.Name, YEAR(CURRENT_DATE()) - YEAR(p.Birthdate) as AGE, p.Weight
FROM PATIENT as p
ORDER BY AGE desc;
    
# What are the most recent condition/s diagnosed on each patient
SELECT 
    p.Name as 'Patient_name' , DATE(a1.Schedule) as 'Date', ac.Description as 'Condition'
FROM
    Appointment AS a1
        JOIN
    patient AS p ON a1.Patient_Id = p.Patient_Id
        JOIN
    condition_diagnosed AS cd ON a1.Appoint_Id = cd.Appoint_Id
        JOIN
    `action` AS ac ON cd.Cond_code = ac.`Code`
WHERE
    (a1.Patient_Id , a1.Schedule) IN (SELECT 
            a2.Patient_Id, MAX(a2.Schedule) AS most_recent_app
        FROM
            Appointment AS a2
        WHERE
            a2.Patient_Id IN (SELECT 
                    p.Patient_Id
                FROM
                    Patient AS p)
        GROUP BY a2.Patient_Id);

# Update secondary owner of a patient 
UPDATE PATIENT
SET Secondary_Owner = 5
WHERE Patient_id = 5;

# Update owner details
UPDATE OWNER
SET Phone = '123-456-7890'
WHERE Owner_id = 5;

# Testing Patient Owner ON UPDATE CASCADE constraint
UPDATE OWNER
SET Owner_Id = 6
WHERE Owner_id = 5;

# Testing Secondary_Owner ON DELETE SET NULL constraint
DELETE FROM OWNER 
WHERE
    Owner_Id = 2;

# Testing Primary_Owner ON DELETE CASCADE constraint
DELETE FROM OWNER 
WHERE
    Owner_Id = 1;
