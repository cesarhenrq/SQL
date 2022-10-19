-- Criação do banco de dados para o cenário de Oficina.
CREATE DATABASE oficina;
USE oficina;

-- Cria tabela cliente.
CREATE TABLE clients (
		idClient INT PRIMARY KEY AUTO_INCREMENT,
        fName VARCHAR(10), 
        mInit CHAR (3),
        lName VARCHAR(20),
        adress VARCHAR(30),
        contact char(11),
        autorization ENUM("Autorizado", "Não-Autorizado") DEFAULT "Não-Autorizado"
);

                
-- Cria tabela veiculo.
CREATE TABLE vehicle (
		idVehicle INT AUTO_INCREMENT PRIMARY KEY,
        idClientVehicle INT,
        idMechanicsTeamVihicle INT, 
		licensePlate CHAR(7) NOT NULL,
        model VARCHAR(20) NOT NULL,
        brand VARCHAR(20) NOT NULL,
        vehicleType ENUM("Moto","Carro") NOT NULL,
        CONSTRAINT unique_licenseplate_vehicle UNIQUE (licensePlate),
        CONSTRAINT fk_vehicle_client FOREIGN KEY (idClientVehicle) REFERENCES clients(idClient),
        CONSTRAINT fk_vehicle_mechanicsteam FOREIGN KEY (idMechanicsTeamVihicle) REFERENCES mechanicsteam(idMechanicsTeam)
);

-- Cria tabela mecânicos.
CREATE TABLE mechanic (
		idmechanic INT AUTO_INCREMENT PRIMARY KEY,
        idMechanicsTeamMechanic INT,
        mechanicName VARCHAR(45) NOT NULL,
        adress VARCHAR(255) NOT NULL,
        specialty VARCHAR(20) NOT NULL,
        CONSTRAINT fk_mechanic_mechanicsteam FOREIGN KEY (idMechanicsTeamMechanic) REFERENCES mechanicsteam(idMechanicsTeam)
);

-- Cria tabela equipe de mecânicos.
CREATE TABLE mechanicsteam (
		idMechanicsTeam INT AUTO_INCREMENT PRIMARY KEY,
        appraisal VARCHAR(255) NOT NULL
);

-- Cria tabela serviços.
CREATE TABLE task (
		idTask INT AUTO_INCREMENT PRIMARY KEY,
        idMechanicsTeamTask INT,
        taskType VARCHAR(255) NOT NULL,
        taskPrice FLOAT NOT NULL,
        CONSTRAINT fk_task_mechanicsteam FOREIGN KEY (idMechanicsTeamTask) REFERENCES mechanicsteam(idMechanicsTeam)
);

-- Cria tabela peça.
CREATE TABLE part (
		idPart INT AUTO_INCREMENT PRIMARY KEY,
        idMechanicsTeamPart INT,
        partName VARCHAR(45) NOT NULL,
        partPrice FLOAT NOT NULL,
        CONSTRAINT fk_part_mechanicsteam FOREIGN KEY (idMechanicsTeamPart) REFERENCES mechanicsteam(idMechanicsTeam)
);

-- Cria tabela ordem de serviço.
CREATE TABLE ordertask (
		idOrderTask INT AUTO_INCREMENT PRIMARY KEY,
        idMechanicsTeamOrderTask INT,
        idClientOrderTask INT,
        partName VARCHAR(45) NOT NULL,
        partPrice FLOAT NOT NULL,
        CONSTRAINT fk_ordertask_mechanicsteam FOREIGN KEY (idMechanicsTeamOrderTask) REFERENCES mechanicsteam(idMechanicsTeam),
        CONSTRAINT fk_ordetask_client FOREIGN KEY (idClientOrderTask) REFERENCES clients(idClient)
);

-- Cria tabela peça/ordem de serviço.
CREATE TABLE partordertask (
		idOrderTask INT,
        idPart INT,
        quantity INT,
        CONSTRAINT pk_partordertask PRIMARY KEY (idOrdemTask, idPart),
        CONSTRAINT fk_partordertask_ordertask FOREIGN KEY (idOrderTask) REFERENCES ordertask(idOrderTask),
        CONSTRAINT fk_partordertask_part FOREIGN KEY (idPart) REFERENCES part(idPart)
);

-- Cria tabela serviços/ordem de serviço.
CREATE TABLE taskordertask (
		idOrderTask INT,
        idTask INT,
        quantity INT,
        CONSTRAINT pk_taskordertask PRIMARY KEY (idOrdemTask, idTask),
        CONSTRAINT fk_taskordertask_ordertask FOREIGN KEY (idOrderTask) REFERENCES ordertask(idOrderTask),
        CONSTRAINT fk_taskordertask_part FOREIGN KEY (idPart) REFERENCES part(idPart)
);

SHOW TABLES;