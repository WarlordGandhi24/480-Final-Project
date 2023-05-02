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

SELECT name, room_num
FROM patient
WHERE room_num IN (
SELECT room_num
FROM room
WHERE capacity > 7
);

SELECT *
FROM nurse_execution
WHERE nurse_id NOT IN (
SELECT nurse_id
FROM nurse
WHERE cert_number = 332 OR cert_number = 424
);

SELECT *
FROM nurse
WHERE nurse_id = (
SELECT nurse_id
FROM medication_provision
WHERE name = "Insulin"
);

select patient.name, patient.length_of_stay, payment.amount
from patient join payment on patient.patient_id = payment.patient_id
where patient.length_of_stay > 4 and payment.amount > 2300;

select patient.patient_id, avg(amount)
from patient 
join medication 
on patient.patient_id = medication.patient_id
group by patient.patient_id

select patient_id, count(distinct physician_id) as cnt_physician
from monitor
group by patient_id

select patient_id, (instruction_cost + room_cost) / length_of_stay as avg_cost_per_day
from invoice
join patient 
on invoice.patient_id = patient.patient_id

with tmp as (
select patient_id, avg(room_cost) as avg_room_cost
from invoice
group by patient_id
)
select patient_id
from tmp 
order by avg_room_cost desc 
limit 1

select count(*) as num_of_insturctions 
from instruction
where physician_id = 
(select physician_id 
from physician 
where name = 'Jessica Worthy');

select name
from patient join payment on patient.patient_id = payment.patient_id
where payment.date between '2020-01-01' and '2020-12-31';

select room_num, fee
from room 
order by fee;

select name from patient 
where patient_id not in (select patient_id from monitor);

select name from physician
where physician_id in (select physician_id 
from instruction 
join nurse_execution on instruction.code = nurse_execution.code
where status = 'failure');

select name from physician
where name like 'J%'

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
    UPDATE instruction SET fee = fee + 150 WHERE patient_id = 101;
COMMIT;

START TRANSACTION;
	UPDATE health_record SET status = 'Resolved' WHERE patient_id = 102;
    UPDATE health_record SET description = 'Patient experienced a migraine and has recovered.' WHERE patient_id = 102;
COMMIT;
