DROP DATABASE IF EXISTS hospital;

CREATE DATABASE hospital;

USE hospital;

CREATE TABLE room (
  room_num           INT            PRIMARY KEY,
  capacity        	 INT    	    NOT NULL,
  fee       	     INT   			NOT NULL
);

CREATE TABLE physician (
  physician_id       INT            PRIMARY KEY   AUTO_INCREMENT,
  name           	 VARCHAR(50)    NOT NULL,
  cert_number        INT       		NOT NULL,
  field_of_exp       VARCHAR(30)    NOT NULL,
  address			 VARCHAR(100)   NOT NULL,
  phone_num          VARCHAR(15)    NOT NULL
);

CREATE TABLE nurse (
  nurse_id       	 INT            PRIMARY KEY   AUTO_INCREMENT,
  name           	 VARCHAR(50)    NOT NULL,
  cert_number        INT       		NOT NULL,
  address			 VARCHAR(100)   NOT NULL,
  phone_num          VARCHAR(15)    NOT NULL
);

CREATE TABLE patient (
  patient_id         INT            PRIMARY KEY   AUTO_INCREMENT,
  name        		 VARCHAR(50)    NOT NULL,
  address       	 VARCHAR(100)   NOT NULL,
  phone_num          VARCHAR(15)    NOT NULL,
  room_num			 INT			NOT NULL,
  length_of_stay	 INT			NOT NULL,
  FOREIGN KEY (room_num) REFERENCES room(room_num)
);

CREATE TABLE instruction (
  code           	 VARCHAR(15)            PRIMARY KEY,
  fee       	     INT   			NOT NULL,
  description		 TEXT,
  order_date		 DATETIME		NOT NULL,
  patient_id         INT			NOT NULL,
  physician_id       INT			NOT NULL,
  FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
  FOREIGN KEY (physician_id) REFERENCES physician(physician_id)
);

CREATE TABLE monitor (
	duration	    INT			   NOT NULL,
    physician_id		 INT			NOT NULL,
    patient_id		 INT			NOT NULL,
    FOREIGN KEY (physician_id) REFERENCES physician(physician_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

CREATE TABLE payment (
  date         		 DATETIME       NOT NULL PRIMARY KEY,
  amount             INT    		NOT NULL,
  patient_id		 INT			NOT NULL,
  FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

CREATE TABLE health_record (
  patient_id         INT            PRIMARY KEY   AUTO_INCREMENT,
  disease            VARCHAR(30)    NOT NULL,
  date       	 	 DATETIME       NOT NULL,
  status          	 VARCHAR(15)    NOT NULL,
  description		 TEXT,
  FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

CREATE TABLE medication (
  name           	 VARCHAR(50)    PRIMARY KEY,
  amount				 INT,
  patient_id         INT,
  nurse_id       	 INT,
  FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
  FOREIGN KEY (nurse_id) REFERENCES nurse(nurse_id)
);

CREATE TABLE nurse_execution (
	status		INT,
    nurse_id    INT,
    code		VARCHAR(15),
	FOREIGN KEY (nurse_id) REFERENCES nurse(nurse_id),
	FOREIGN KEY (code) REFERENCES medication(name)
);

CREATE TABLE medication_provision (
	nurse_id       	 INT	PRIMARY KEY,
    name           	 VARCHAR(50),
	FOREIGN KEY (nurse_id) REFERENCES nurse(nurse_id),
	FOREIGN KEY (name) REFERENCES medication(name)
);

CREATE TABLE invoice (
  instruction_cost   INT,
  room_cost          INT,
  patient_id       	 INT,
  FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);