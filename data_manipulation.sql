create database customer_data;

use customer_data;


# Create Card Category Dimension Table and Insert Values
create table card_category(
	id int NOT NULL,
	card_category varchar(10) NOT NULL,
	PRIMARY KEY (id),
	UNIQUE KEY id_unique (id)
)ENGINE = InnoDB;

insert into card_category(id,card_category)
values (1,'Blue'),(2,'Gold'),(3,'Silver'),(4,'Platinum');

# Create Education Level Dimension Table and Insert Values
create table education_level(
	id int NOT NULL,
	education_level varchar(20) NOT NULL,
	PRIMARY KEY (id),
	UNIQUE KEY id_unique (id)
)ENGINE = InnoDB;

insert into education_level(id,education_level)
values (1,'High School'),(2,'Graduate'),(3,'Uneducated'),(4,'Unknown'),
	   (5,'College'),(6,'Post-Graduate'),(7,'Doctorate');

# Create Marital Status Dimension Table and Insert Values
create table marital_status(
	id int NOT NULL,
	marital_status varchar(10) NOT NULL,
	PRIMARY KEY (id),
	UNIQUE KEY id_unique (id)
)ENGINE = InnoDB;

insert into marital_status(id,marital_status)
values (1,'Married'),(2,'Single'),(3,'Unknown'),(0,'Divorced');

# Create Customer Status Dimension Table and Insert Values
create table customer_status(
	id int NOT NULL,
	status varchar(30) NOT NULL,
	PRIMARY KEY (id),
	UNIQUE KEY id_unique (id)
)ENGINE = InnoDB;

insert into customer_status(id,status)
values (1,'Existing Customer'),(2,'Attrited Customer');

# Import Customer_Data_History.csv

start transaction;

# Rename column name
alter table customer_data_history
	rename column CLIENTNUM to client_id,
	rename column Customer_Age to customer_age,
	rename column Gender to gender,
	rename column Dependent_count to dependent_count,
	rename column Educationid to education_id,
	rename column Maritalid to marital_id,
	rename column Income_Category to income_category,
	rename column Months_on_book to months_on_book,
	rename column Total_Relationship_Count to total_relationship_count,
	rename column Months_Inactive_12_mon to months_inactive_12,
	rename column Contacts_Count_12_mon to contacts_count_12,
	rename column Total_Revolving_Bal to total_revolving_bal,
	rename column Credit_Limit to credit_limit,
	rename column Avg_Open_To_Buy to avg_open_to_buy,
	rename column Total_Trans_Amt to total_trans_amt,
	rename column Total_Trans_Ct to total_trans_ct,
	rename column Avg_Utilization_Ratio to avg_utilization_ratio;

# Set primary and foreign key, change column data type
alter table customer_data_history
	modify customer_age int NOT NULL,
	modify idstatus int NOT NULL,
	modify gender ENUM('M','F') NOT NULL,
	modify customer_age int NOT NULL,
	MODIFY income_category ENUM('Less than $40K', '$40K - $60K','$60K - $80K','$80K - $120K', '$120K +','Unknown') NOT NULL;
	modify dependent_count int NOT NULL DEFAULT 0,
	modify education_id int NOT NULL DEFAULT 4,
	modify marital_id int NOT NULL DEFAULT 3,
	modify card_categoryid int NOT NULL,
	modify months_on_book int NOT NULL Default 0,
	modify total_relationship_count int NOT NULL Default 0,
	modify months_inactive_12 int NOT NULL Default 0,
	modify contacts_count_12 int NOT NULL Default 0,
	modify credit_limit int NOT NULL Default 0,
	modify total_revolving_bal int NOT NULL Default 0,
	modify avg_open_to_buy int NOT NULL Default 0,
	modify total_trans_amt int NOT NULL Default 0,
	modify total_trans_ct int NOT NULL Default 0,
	modify avg_utilization_ratio double NOT NULL Default 0,
	modify client_id varchar(50) NOT NULL,
	add primary key (client_id),
	add constraint client_unique unique (client_id),
	add constraint fk_customer_status
	foreign key (idstatus) references customer_status (id),
	add constraint fk_education_id
	foreign key (education_id) references education_level (id),
	add constraint fk_marital_id
	foreign key (marital_id) references marital_status (id)
	add constraint fk_card_category
	foreign key (card_categoryid) references card_category (id);

commit;


	
	