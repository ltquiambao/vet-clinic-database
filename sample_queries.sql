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

# Find the name of all patients who was examined by Dr x on Aug 1, 2021
SELECT DISTINCT
    p.Patient_Id, p.Name
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