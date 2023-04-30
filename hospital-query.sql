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

START TRANSACTION;
	UPDATE invoice SET instruction_cost = instruction_cost + 150 WHERE patient_id = 101;
	UPDATE payment SET amount = amount + 150 WHERE patient_id = 101;
    UPDATE instruction SET amount = amount + 150 WHERE patient_id = 101;
COMMIT;

START TRANSACTION;
	UPDATE health_record SET status = 'Resolved' WHERE patient_id = 102;
    UPDATE health_record SET description = 'Patient experienced a migraine and has recovered.' WHERE patient_id = 102;
COMMIT;