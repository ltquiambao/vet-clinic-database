CREATE TABLE `OWNER` (
  `Owner_Id` INT,
  `Name` VARCHAR(50),
  `Street_Number` VARCHAR(10),
  `Street_Name` VARCHAR(20),
  `City` VARCHAR(20),
  `Province` VARCHAR(20),
  `Postal_Code` CHAR(7),
  `Phone` CHAR(11),
  PRIMARY KEY (`Owner_Id`)
);

CREATE TABLE `PATIENT` (
  `Patient_Id` INT,
  `Name` VARCHAR(20),
  `Species` VARCHAR(10),
  `Breed` VARCHAR(10),
  `Birthdate` DATE,
  `Weight` VARCHAR(10),
  `Color_Mark` VARCHAR(10),
  `Microchip` CHAR(15),
  `Rabies_Tag` CHAR(8),
  PRIMARY KEY (`Patient_Id`)
);

CREATE TABLE `PATIENT_OWNER` (
  `Patient_Id` INT,
  `Owner_Id` INT,
  PRIMARY KEY (`Patient_Id`, `Owner_Id`),
  FOREIGN KEY (`Owner_Id`) REFERENCES `OWNER`(`Owner_Id`),
  FOREIGN KEY (`Patient_Id`) REFERENCES `PATIENT`(`Patient_Id`)
);

CREATE TABLE `ACTION` (
  `Code` VARCHAR(8),
  `Category` VARCHAR(10),
  `Description` VARCHAR(30),
  PRIMARY KEY (`Code`)
);

CREATE TABLE `ITEM` (
  `Item_code` VARCHAR(8),
  PRIMARY KEY (`Item_code`),
  FOREIGN KEY (`Item_code`) REFERENCES `ACTION`(`Code`)
);

CREATE TABLE `TREATMENT` (
  `Treat_code` VARCHAR(8),
  PRIMARY KEY (`Treat_code`),
  FOREIGN KEY (`Treat_code`) REFERENCES `ACTION`(`Code`)
);

CREATE TABLE `CONDITION` (
  `Cond_code` VARCHAR(8),
  PRIMARY KEY (`Cond_code`),
  FOREIGN KEY (`Cond_code`) REFERENCES `ACTION`(`Code`)
);

CREATE TABLE `EMPLOYEE` (
  `SIN` CHAR(9),
  `Name` VARCHAR(50),
  `Street number` VARCHAR(10),
  `Street name` VARCHAR(20),
  `City` VARCHAR(20),
  `Province` VARCHAR(20),
  `Postal_Code` CHAR(7),
  `Phone` CHAR(11),
  `Birthdate` DATE,
  `Gender` CHAR(1),
  PRIMARY KEY (`SIN`)
);

CREATE TABLE `DVM` (
  `DVM_Id` CHAR(9),
  `Specialization` VARCHAR(20),
  PRIMARY KEY (`DVM_Id`),
  FOREIGN KEY (`DVM_Id`) REFERENCES `EMPLOYEE`(`SIN`)
);

CREATE TABLE `STAFF` (
  `Staff_Id` CHAR(9),
  PRIMARY KEY (`Staff_Id`),
  FOREIGN KEY (`Staff_Id`) REFERENCES `EMPLOYEE`(`SIN`)
);

CREATE TABLE `APPOINTMENT` (
  `Appoint_Id` INT,
  `Patient_Id` INT,
  `DVM_Id` CHAR(9),
  `Staff_Id` CHAR(9),
  `Reason` VARCHAR(50),
  `Schedule` DATETIME,
  PRIMARY KEY (`Patient_Id`, `Schedule`),
  FOREIGN KEY (`Staff_Id`) REFERENCES `STAFF`(`Staff_Id`),
  FOREIGN KEY (`DVM_Id`) REFERENCES `DVM`(`DVM_Id`),
  FOREIGN KEY (`Patient_Id`) REFERENCES `PATIENT`(`Patient_Id`),
  UNIQUE KEY (`Appoint_Id`)
);

CREATE TABLE `CONDITION_DIAGNOSED` (
  `Appoint_Id` INT,
  `Cond_code` VARCHAR(8),
  `Notes` VARCHAR(30),
  PRIMARY KEY (`Appoint_Id`, `Cond_code`),
  FOREIGN KEY (`Appoint_Id`) REFERENCES `APPOINTMENT`(`Appoint_Id`),
  FOREIGN KEY (`Cond_code`) REFERENCES `CONDITION`(`Cond_code`)
);

CREATE TABLE `ITEM_TREATMENT_PRESCRIBED` (
  `Appoint_Id` INT,
  `Item_code` VARCHAR(8),
  `Treat_code` VARCHAR(8),
  `Dosage_amount` VARCHAR(8),
  `Method` VARCHAR(10),
  `Frequency` VARCHAR(10),
  `Special_Inst` VARCHAR(30),
  PRIMARY KEY (`Appoint_Id`, `Item_code`, `Treat_code`),
  FOREIGN KEY (`Appoint_Id`) REFERENCES `APPOINTMENT`(`Appoint_Id`),
  FOREIGN KEY (`Item_code`) REFERENCES `ITEM`(`Item_code`),
  FOREIGN KEY (`Treat_code`) REFERENCES `TREATMENT`(`Treat_code`)
);
