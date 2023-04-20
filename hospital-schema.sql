DROP DATABASE IF EXISTS hospital;

CREATE DATABASE hospital;

USE hospital;

CREATE TABLE patient (
  patient_id         INT            PRIMARY KEY   AUTO_INCREMENT,
  name        		 VARCHAR(50)    NOT NULL,
  address       	 VARCHAR(100)   NOT NULL,
  phone_num          VARCHAR(15)    NOT NULL
);

CREATE TABLE room (
  room_num           INT            PRIMARY KEY,
  capacity        	 INT    	    NOT NULL,
  fee       	     INT   			NOT NULL
);

CREATE TABLE payment (
  date         		 DATETIME       NOT NULL PRIMARY KEY,
  amount             INT    		NOT NULL
);

CREATE TABLE health_record (
  patient_id         INT            PRIMARY KEY   AUTO_INCREMENT,
  disease            VARCHAR(30)    NOT NULL,
  date       	 	 DATETIME       NOT NULL,
  status          	 VARCHAR(15)    NOT NULL,
  description		 TEXT
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

CREATE TABLE medication (
  patient_id         INT,
  name           	 VARCHAR(50)    PRIMARY KEY,
  nurse_id       	 INT,
  FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
  FOREIGN KEY (nurse_id) REFERENCES nurse(nurse_id)
);

CREATE TABLE instruction (
  code           	 INT            PRIMARY KEY,
  fee       	     INT   			NOT NULL,
  description		 TEXT
);