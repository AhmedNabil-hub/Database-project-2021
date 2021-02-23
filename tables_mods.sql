ALTER TABLE client
drop constraint FK_client_order;

ALTER TABLE client
DROP COLUMN order_id;

ALTER TABLE [order]
ADD client_id int NULL CONSTRAINT FK_order_client FOREIGN KEY (client_id) references client(id);

ALTER TABLE [order]
ALTER COLUMN address_id int NOT NULL;

ALTER TABLE [order]
ALTER COLUMN weight float NOT NULL;

ALTER TABLE [order]
ALTER COLUMN dimensions varchar(50) NOT NULL;

ALTER TABLE [order]
ALTER COLUMN region varchar(50) NOT NULL;

ALTER TABLE [order]
ALTER COLUMN pricing_id int NOT NULL;

ALTER TABLE [order]
ALTER COLUMN reciever_first_name varchar(50) NOT NULL;

ALTER TABLE [order]
ALTER COLUMN reciever_last_name varchar(50) NOT NULL;

ALTER TABLE [order]
ADD CONSTRAINT df_order_note
DEFAULT 'empty' FOR arrival_note; 

ALTER TABLE [order]
ADD CONSTRAINT df_order_recPN
DEFAULT 'empty' FOR reciever_phone_no;

ALTER TABLE [order]
ADD CONSTRAINT df_order_date
DEFAULT DATEADD(month, 1, GETDATE()) FOR arrival_date; 

ALTER TABLE [order]
ADD CONSTRAINT df_order_state
DEFAULT 'Pending' FOR state; 




ALTER TABLE address
ALTER COLUMN governorate varchar(50) NOT NULL;

ALTER TABLE address
ALTER COLUMN city varchar(50) NOT NULL;

ALTER TABLE address
ADD CONSTRAINT df_street
DEFAULT 'empty' FOR street; 

ALTER TABLE address
ADD CONSTRAINT df_add
DEFAULT 'empty' FOR additional; 




ALTER TABLE driver
ALTER COLUMN rate float NOT NULL;

ALTER TABLE driver
ALTER COLUMN region varchar(50) NOT NULL;

ALTER TABLE driver
ADD CONSTRAINT df_rate
DEFAULT 0 FOR rate; 

ALTER TABLE driver
ADD CONSTRAINT df_region
DEFAULT 'empty' FOR region; 




ALTER TABLE client
ALTER COLUMN first_name varchar(50) NOT NULL;

ALTER TABLE client
ALTER COLUMN last_name varchar(50) NOT NULL;

ALTER TABLE client
ALTER COLUMN phone_no varchar(50) NOT NULL;




ALTER TABLE pricing
ALTER COLUMN dimensions varchar(50) NOT NULL;

ALTER TABLE pricing
ALTER COLUMN weight float NOT NULL;

ALTER TABLE pricing
ALTER COLUMN distance int NOT NULL;


ALTER TABLE pricing
ALTER COLUMN cost money NOT NULL;




ALTER TABLE employee
ALTER COLUMN first_name varchar(50) NOT NULL;

ALTER TABLE employee
ALTER COLUMN last_name varchar(50) NOT NULL;

ALTER TABLE employee
ALTER COLUMN phone_no varchar(50) NOT NULL;

ALTER TABLE employee
ALTER COLUMN ssn varchar(50) NOT NULL;

ALTER TABLE employee
ALTER COLUMN job_title varchar(50) NOT NULL;

ALTER TABLE driver
DROP CONSTRAINT FK_driver_employee;

ALTER TABLE driver
ADD CONSTRAINT FK_driver_employee FOREIGN KEY (id) REFERENCES employee(id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE [order]
DROP CONSTRAINT FK_order_client;

ALTER TABLE [order]
ADD CONSTRAINT FK_order_client FOREIGN KEY (client_id) REFERENCES client(id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE [order]
DROP CONSTRAINT FK_order_address;

ALTER TABLE [order]
ADD CONSTRAINT FK_order_address FOREIGN KEY (address_id) REFERENCES address(id)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE [order]
DROP CONSTRAINT FK_order_pricing;

ALTER TABLE [order]
ADD CONSTRAINT FK_order_pricing FOREIGN KEY (pricing_id) REFERENCES pricing(id)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE [order]
DROP CONSTRAINT FK_order_employee;

ALTER TABLE [order]
ADD CONSTRAINT FK_order_employee FOREIGN KEY (driver_id) REFERENCES employee(id)
ON DELETE NO ACTION
ON UPDATE CASCADE;

