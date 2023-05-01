SELECT instruction.code, instruction.fee, instruction.description, nurse_execution.nurse_id
FROM instruction JOIN nurse_execution
WHERE instruction.code = nurse_execution.code and fee > 100 and status = 'success';

SELECT patient.name, patient.room_num, medication.name, medication.amount
FROM patient JOIN medication
WHERE medication.patient_id = patient.patient_id AND amount > 150;

SELECT patient.name, patient.length_of_stay, room.room_num, room.fee
FROM patient JOIN room
WHERE patient.room_num = room.room_num and room.fee > 300 and patient.length_of_stay < 9;

SELECT status, COUNT(status)
FROM nurse_execution
GROUP BY status;

SELECT SUM(amount)
FROM payment JOIN patient
WHERE patient.patient_id = payment.patient_id AND patient.length_of_stay > 7;

SELECT AVG(instruction_cost) as 'Average Instruction Cost', AVG(room_cost) as 'Average Room Cost'
FROM invoice;

create view PatientView as
select patient.patient_id, patient.name, patient.address, health_record.disease, health_record.status, health_record.description, invoice.instruction_cost, invoice.room_cost
from patient, health_record, invoice
where patient.patient_id = health_record.patient_id and patient.patient_id = invoice.patient_id;

create view PhysicianView as
select physician.physician_id, physician.name, physician.field_of_exp, instruction.code, instruction.description, monitor.duration
from physician, instruction, monitor
where physician.physician_id = instruction.physician_id and physician.physician_id = monitor.physician_id;

create view NurseView as
select nurse.nurse_id, nurse.name as nurse_name, nurse_execution.status, instruction.description, medication.name, medication.patient_id
from nurse, nurse_execution, instruction, medication_provision, medication
where nurse.nurse_id = nurse_execution.nurse_id and nurse.nurse_id = medication_provision.nurse_id and nurse_execution.code = instruction.code and medication_provision.name = medication.name;

CREATE TRIGGER nurseTrigger
AFTER INSERT
ON medication FOR EACH ROW
INSERT INTO medication_provision VALUES (1015, NEW.name);

CREATE TRIGGER executionTrigger
AFTER INSERT
ON instruction FOR EACH ROW
INSERT INTO nurse_execution VALUES ('pending', 1015, NEW.code);
DELIMITER @@;
CREATE TRIGGER deleteNursesTrigger
AFTER DELETE
ON nurse FOR EACH ROW
BEGIN
	UPDATE nurse_execution SET nurse_id = '0000' WHERE nurse_id = OLD.nurse_id;
    UPDATE medication_provision SET nurse_id = '0000' WHERE nurse_id = OLD.nurse_id;
END;
@@;
DELIMITER ;

START TRANSACTION;
	UPDATE invoice SET instruction_cost = instruction_cost + 150 WHERE patient_id = 101;
	UPDATE payment SET amount = amount + 150 WHERE patient_id = 101;
    UPDATE instruction SET amount = amount + 150 WHERE patient_id = 101;
COMMIT;

START TRANSACTION;
	UPDATE health_record SET status = 'Resolved' WHERE patient_id = 102;
    UPDATE health_record SET description = 'Patient experienced a migraine and has recovered.' WHERE patient_id = 102;
COMMIT;