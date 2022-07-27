INSERT INTO `OWNER` (`Owner_Id`, `Name`, `Street_Number`, `Street_Name`, `City`, `Province`, `Postal_Code`, `Phone`)
VALUES
	(1, "Shane M Woodfin", "4330", "Port Washington Road", "Coaldale", "Alberta", "T0K 0L0", "403-345-6302"),
    (2, "Jason J Penrod", "1157", "Fallon Drive", "Blyth", "Ontario", "N0M 1H0", "519-523-6974"),
    (3, "Allen S Farmer", "4117", "Russell Avenue", "White Rock", "British Columbia", "V4B 3E1", "604-541-7232"),
    (4, "Hilda K Nolan", "2993", "Churchill Plaza", "Sault Ste Marie", "Ontario", "P6A 1Z2", "705-941-9466"),
    (5, "Alfred M Kelly", "4726", "Water Street", "Kitchener", "Ontario", "N2H 5A5", "519-744-9428");
    
INSERT INTO `PATIENT` (`Patient_Id`,`Name`,`Species`,`Breed`,`Birthdate`,`Weight`,`Color_Mark`,`Microchip`,`Rabies_Tag`,`Gender`,`Primary_Owner`,`Secondary_Owner`)
VALUES 
	(1,'Coco','Canine','Bulldog','2020-05-23',20.03,'White','1234567890ABCDE','12345678','F',1,2),
	(2,'Dex','Canine','German Shepherd','2021-02-14',36.89,'Brown, Black','1224466880ABCDE','65412378','M',1,2),
	(3,'Milo','Feline','Maine Coon','2020-07-12',3.89,'White','9999999990ABCDE','88888888','M',1,2),
	(4,'Luna','Feline','Scottish Fold','2022-01-08',3.50,'Grey','15678462345AFCD','66513478','F',3,NULL),
	(5,'Zoe','Feline','Siamese Cat','2012-10-17',5.72,'White','56774551ADHHN45','44199653','F',4,NULL);

INSERT INTO `EMPLOYEE` (`SIN`,`Name`,`Street number`,`Street name`,`City`,`Province`,`Postal_Code`,`Phone`,`Birthdate`,`Gender`)
VALUES
    ("603250932", "Stacie S Lee", "5007", "Bloor Street", "Ardrossan", "Alberta", "T0B 0E0", "780-922-0568", "1961-01-31", "F"),
    ("760436888", "Alexander A Morrissey", "3171", "Glover Road", "Fort Langley", "British Columbia", "V3A 6X5", "604-881-7596", "1996-03-22", "F"),
    ("794309983", "Norma C Colon", "4117", "Russell Avenue", "White Rock", "British Columbia", "V4B 3E1", "604-541-7232", "1958-08-20", "F"),
    ("666433072", "Daniel B Nunn", "4696", "Galts Ave", "Red Deer", "Alberta", "T4N 5Z9", "403-321-3042", "1990-08-05", "M"),
    ("543688019", "Jacob J Talkington", "4059", "Nelson Street", "Muskrat Dam", "Ontario", "P0V 3B0", "807-471-6932", "1978-12-16", "M");

INSERT INTO `DVM` (`DVM_Id`,`Specialization`)
VALUES
	('603250932', 'Dentist'),
    ('760436888' , 'Anesthetist'),
    ('794309983', 'Surgeon');
    
INSERT INTO `STAFF` (`Staff_Id`)
VALUES
	("666433072"),
    ("543688019");

INSERT INTO `ACTION`(`Code`,`Category`,`Description`)
VALUES
	("na", "Not applicable", "Not applicable"),
	("SC", "blood test", "Superchem"),
	("Ex", "Exam", "Examination"),
    ("Hy", "Healthy", "Healthy"),
    ("Panc", "Endocrine disease", "Pancreatitis"),
    ("Hm", "Cardiopathology", "Heart murmur"),
    ("opht", "Keratitis", "Ophthalmology"),
    ("Metr", "Metritis", "Ginecology"),
    ("Hem", "Hemorrhage", "Trauma"),
    ("FUSO", "Diet", "Feline urinary SO"),
    ("Lant", "Medication", "Lantus"),
    ("Metac", "Metacam", "Medication"),
    ("Sham", "Shampoo", "Grooming"),
    ("Tobra", "Tobradex", "Medication");

INSERT INTO `TREATMENT`
VALUES
	("na"),
	("SC"),
    ("Ex");

INSERT INTO `CONDITION`
VALUES
	("Panc"),
    ("Hm"),
    ("Hy"),
    ("opht"),
    ("Metr"),
    ("Hem");

INSERT INTO `ITEM`
VALUES
	("na"),
	("FUSO"),
    ("Lant"),
    ("Metac"),
    ("Sham"),
    ("Tobra");

INSERT INTO `APPOINTMENT` (`Appoint_Id`,`Patient_Id`,`DVM_Id`,`Staff_Id`,`Reason`,`Schedule`)
VALUES
	(1,1,'603250932',"666433072","Tooth ache","2021-08-01 01:30:00"),
    (2,1,'603250932',"543688019","Tooth ache","2021-08-10 02:00:00"),
    (3,1,'760436888',"543688019","Broken leg","2022-01-20 09:00:00"),
    (4,2,'794309983',"543688019","Stomach ache","2021-08-15 01:30:00"),
    (5,2,'603250932',"666433072","Tooth decay","2021-09-05 02:00:00"),
    (6,2,'760436888',"543688019","Broken leg","2022-03-25 10:00:00"),
    (7,3,'794309983',"543688019","Stomach ache","2021-10-15 01:30:00"),
    (8,4,'603250932',"666433072","Tooth decay","2021-11-05 03:00:00"),
    (9,5,'760436888',"543688019","Broken leg","2022-04-10 01:00:00");

INSERT INTO `APPOINTMENT` (`Appoint_Id`,`Patient_Id`,`DVM_Id`,`Staff_Id`,`Schedule`)
VALUES
	(10,1,'603250932','666433072','2022-08-01 01:30:00');
    
INSERT INTO `CONDITION_DIAGNOSED` (`Appoint_Id`,`Cond_code`,`Notes`)
VALUES
	(1, 'opht', 'xxx'),
    (2, 'Hem', 'xxx'),
	(4, 'Panc', 'xxx'),
    (9, 'Panc', 'xxx'),
    (9, 'opht', 'xxx'),
    (8, 'Metr', 'xxx'),
    (8, 'Hem', 'xxx'),
    (7, 'Panc', 'xxx'),
    (6, 'opht', 'xxx');
    
INSERT INTO `CONDITION_DIAGNOSED` (`Appoint_Id`,`Notes`)
VALUES
	(4, 'xxx');
    
INSERT INTO `ITEM_TREATMENT_PRESCRIBED` (`Appoint_Id`, `Item_code`, `Treat_code`, `Dosage_amount`, `Method`, `Frequency`, `Special_Inst`)
VALUES
	(1, "FUSO", "na", "xx", "xx", "xx", "xx"),
    (2, "Lant", "na", "xx", "xx", "xx", "xx"),
    (4, "Metac", "na", "xx", "xx", "xx", "xx"),
    (9, "Metac", "na", "xx", "xx", "xx", "xx"),
    (8, "Sham", "na", "xx", "xx", "xx", "xx"),
    (8, "na", "SC", "xx", "xx", "xx", "xx"),
    (7, "FUSO", "na", "xx", "xx", "xx", "xx"),
    (6, "na", "Ex", "xx", "xx", "xx", "xx")
