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
