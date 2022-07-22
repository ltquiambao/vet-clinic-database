CREATE TABLE `OWNER` (
    `Owner_Id` INT NOT NULL,
    `Name` VARCHAR(50) NOT NULL,
    `Street_Number` VARCHAR(10),
    `Street_Name` VARCHAR(20) NOT NULL,   
    `City` VARCHAR(20) NOT NULL,
    `Province` VARCHAR(20) NOT NULL,
    `Postal_Code` CHAR(7) NOT NULL,
    `Phone` CHAR(11),
    PRIMARY KEY (`Owner_Id`)
);

CREATE TABLE `PATIENT` (
    `Patient_Id` INT NOT NULL,
    `Name` VARCHAR(20) NOT NULL,
    `Species` ENUM('Feline', 'Canine') NOT NULL,
    `Breed` VARCHAR(10),
    `Birthdate` DATE NOT NULL CHECK (`Birthdate` < '1990-01-01'),
    `Weight` VARCHAR(10) NOT NULL CHECK (`Weight` > 0 AND `Weight` < 150),
    `Color_Mark` VARCHAR(10),
    `Microchip` CHAR(15),
    `Rabies_Tag` CHAR(8),
    `Gender` ENUM('M', 'F'),
    `Primary_Owner` INT NOT NULL,
    `Secondary_Owner` INT,
    PRIMARY KEY (`Patient_Id`),
    FOREIGN KEY (`Primary_Owner`)
        REFERENCES `OWNER` (`Owner_Id`)
        ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`Secondary_Owner`)
        REFERENCES `OWNER` (`Owner_Id`)
        ON DELETE SET NULL ON UPDATE CASCADE,
    UNIQUE KEY (`Microchip`),
    UNIQUE KEY (`Rabies_Tag`)
);

CREATE TABLE `ACTION` (
    `Code` VARCHAR(8) NOT NULL,
    `Category` VARCHAR(10) NOT NULL,
    `Description` VARCHAR(30),
    PRIMARY KEY (`Code`)
);

CREATE TABLE `ITEM` (
    `Item_code` VARCHAR(8) NOT NULL,
    PRIMARY KEY (`Item_code`),
    FOREIGN KEY (`Item_code`)
        REFERENCES `ACTION` (`Code`)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `TREATMENT` (
    `Treat_code` VARCHAR(8) NOT NULL,
    PRIMARY KEY (`Treat_code`),
    FOREIGN KEY (`Treat_code`)
        REFERENCES `ACTION` (`Code`)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `CONDITION` (
    `Cond_code` VARCHAR(8) NOT NULL,
    PRIMARY KEY (`Cond_code`),
    FOREIGN KEY (`Cond_code`)
        REFERENCES `ACTION` (`Code`)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `EMPLOYEE` (
    `SIN` CHAR(9) NOT NULL,
    `Name` VARCHAR(50) NOT NULL,
    `Street number` VARCHAR(10),
    `Street name` VARCHAR(20) NOT NULL,
    `City` VARCHAR(20) NOT NULL,
    `Province` VARCHAR(20) NOT NULL,
    `Postal_Code` CHAR(7) NOT NULL,
    `Phone` CHAR(11),
    `Birthdate` DATE NOT NULL CHECK (`Birthdate` < '1900-01-01'),
    `Gender` ENUM('M', 'F'),
    PRIMARY KEY (`SIN`)
);

CREATE TABLE `DVM` (
    `DVM_Id` CHAR(9) NOT NULL,
    `Specialization` VARCHAR(20),
    PRIMARY KEY (`DVM_Id`),
    FOREIGN KEY (`DVM_Id`)
        REFERENCES `EMPLOYEE` (`SIN`)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `STAFF` (
    `Staff_Id` CHAR(9) NOT NULL,
    PRIMARY KEY (`Staff_Id`),
    FOREIGN KEY (`Staff_Id`)
        REFERENCES `EMPLOYEE` (`SIN`)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `APPOINTMENT` (
    `Appoint_Id` INT NOT NULL,
    `Patient_Id` INT NOT NULL,
    `DVM_Id` CHAR(9) NOT NULL,
    `Staff_Id` CHAR(9) NOT NULL,
    `Reason` VARCHAR(50),
    `Schedule` DATETIME NOT NULL,
    PRIMARY KEY (`Patient_Id` , `Schedule`),
    FOREIGN KEY (`Staff_Id`)
        REFERENCES `STAFF` (`Staff_Id`)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (`DVM_Id`)
        REFERENCES `DVM` (`DVM_Id`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Patient_Id`)
        REFERENCES `PATIENT` (`Patient_Id`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE KEY (`Appoint_Id`)
);

CREATE TABLE `CONDITION_DIAGNOSED` (
    `Appoint_Id` INT NOT NULL,
    `Cond_code` VARCHAR(8) NOT NULL,
    `Notes` VARCHAR(30),
    PRIMARY KEY (`Appoint_Id` , `Cond_code`),
    FOREIGN KEY (`Appoint_Id`)
        REFERENCES `APPOINTMENT` (`Appoint_Id`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Cond_code`)
        REFERENCES `CONDITION` (`Cond_code`)
        ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE `ITEM_TREATMENT_PRESCRIBED` (
    `Appoint_Id` INT NOT NULL,
    `Item_code` VARCHAR(8) NOT NULL,
    `Treat_code` VARCHAR(8) NOT NULL,
    `Dosage_amount` VARCHAR(8),
    `Method` VARCHAR(10),
    `Frequency` VARCHAR(10),
    `Special_Inst` VARCHAR(30),
    PRIMARY KEY (`Appoint_Id` , `Item_code` , `Treat_code`),
    FOREIGN KEY (`Appoint_Id`)
        REFERENCES `APPOINTMENT` (`Appoint_Id`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Item_code`)
        REFERENCES `ITEM` (`Item_code`)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (`Treat_code`)
        REFERENCES `TREATMENT` (`Treat_code`)
        ON DELETE NO ACTION ON UPDATE CASCADE
);
