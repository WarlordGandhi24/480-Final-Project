insert into room values (101, 4, 500);
insert into room values (102, 8, 300);
insert into room values (103, 8, 300);
insert into room values (104, 2, 800);
insert into room values (105, 4, 500);


insert into patient values (101, 'Arn Bjarn', '5833 Copera Avenue', '332-92-32232', 103, 12);
insert into patient values (102, 'Bjork York', '5555 Yasser Street', '309-99-9999', 101, 5);
insert into patient values (103, 'Torb Jorn', '2222 Arm Street', '412-22-4242', 102, 8);
insert into patient values (104, 'Patient Zero', '4473 Elem Road', '3939-39-3939', 104, 2);
insert into patient values (105, 'Jenna Benna', '3829 Art Street', '2929-29-2929', 105, 18);


insert into payment values('2020-04-20', 6150, 101);
insert into payment values('2023-03-27', 1750, 102);
insert into payment values('2020-12-30', 2475, 103);
insert into payment values('2023-04-27', 1700, 104);
insert into payment values('2023-08-23', 9200, 105);


insert into health_record values(101,'Diabetes','2020-03-05','Active', 'Type 2 diabetes');
insert into health_record values(102, 'Migraine', '2023-02-25', 'Inactive', 'Patient is stable on medication');
insert into health_record values(103, 'Cardiovascular disease', '2020-08-11', 'Active', 'Patient is being treated with medication and under blood pressure control');
insert into health_record values(104, 'Depression', '2023-01-10', 'Active', 'Patient is treateed with behavioral therapy and medication');
insert into health_record values(105, 'Influenza', '2023-07-05', 'Resolved', 'Patient experienced flu-like symptoms and has recovered');

insert into physician values (782, 'John Ham', 137, 'Surgery', '4040 Fake Street', '101-01-0111');
insert into physician values (783, 'Jessica Worthy', 382, 'Eyes', '5555 Johnson Ave', '5252-03-5323');
insert into physician values (784, 'Doctor Mario', 152, 'Terminal Illness', '4848 Mushroom Street', '2341-02-4323');
insert into physician values (785, 'Zed Fyrestone', 467, 'Mental Illness', '2420 Border Boulevard', '5454-34-8415');
insert into physician values (786, 'Ludwig Gehrmacht', 634, 'Surgery', '8049 Dustbowl Street', '111-11-1111');

insert into nurse values (1014, 'Eric Hanson', 332, '5848 Fake Street', '924-13-5439');
insert into nurse values (1015, 'Melissa Kiergan', 424, '4212 Wendigo Avenue', '434-54-5455');
insert into nurse values (1016, 'Joy Aflora', 976, '8292 Pallet Road', '999-99-9999');
insert into nurse values (1017, 'Claire Heel', 754, '4129 Hallow Street', '653-63-2453');
insert into nurse values (1018, 'Alan Benson', 728, '5829 Cap Avenue', '131-43-5321');

insert into medication values ('insulin', '500mg', 101);
insert into medication values ('ibuprofen', '200mg', 102);
insert into medication values ('aspirin', '100mg', 103);
insert into medication values ('SSRIs','150mg', 104);
insert into medication values ('Tylenol', '250mg', 105);

insert into instruction values ('MI001', 150, "Monitor blood glucose levels regularly",'2020-03-10', 101, 782);
insert into instruction values('MI002', 250, "Provide patient with medication", '2023-02-27', 102, 783);
insert into instruction values('MI003', 75, "Perform routine medical assessments and physical exams", '2020-08-15', 103,783);
insert into instruction values('MI004', 100, "Prescribe antidepressant medications", '2023-01-10', 104, 783);
insert into instruction values('MI005', 200, "Flu vaccine administration", '2023-07-11', 105, 784);

insert into invoice values(150, 6000, 101);
insert into invoice values(250,1500,102);
insert into invoice values(75,2400,103);
insert into invoice values(100,1600,104);
insert into invoice values(200,9000,105);

insert into monitor values('5 hour', 782, 101 );
insert into monitor values('10 hour', 783, 101);
insert into monitor values('1 hour', 782, 102);
insert into monitor values('24 hour', 785, 103);
insert into monitor values('30 hour', 784, 105);


insert into medication_provision values(1014, 'insulin');
insert into medication_provision values(1017, 'ibuprofen' );
insert into medication_provision values(1014, 'aspirin');
insert into medication_provision values(1015, 'SSRIs');
insert into medication_provision values(1015, 'Tylenol');


insert into nurse_execution values('success', 1014, 'MI001');
insert into nurse_execution values('success', 1014, 'MI002');
insert into nurse_execution values('success', 1016, 'MI003');
insert into nurse_execution values('success', 1017,'MI004');
insert into nurse_execution values('failure', 1018,'MI005');

