create database bank_collection_db;

use bank_collection_db;

create table costumers (
	id int not null,
    costumer_id varchar(255) not null primary key,
    name varchar(100) not null,
    identity_doc varchar(20) not null,
    email varchar(255) not null,
    account_number varchar(19) not null,
    balance decimal(5, 2) not null
);

create table transaction_types (
	id int not null,
    transaction_id int not null primary key,
    transaction_type varchar(25) not null
);

create table transactions (
	id int not null,
    transaction_id varchar(255) not null primary key,
    costumer_id varchar(255) not null,
    transaction_type int not null,
    amount int not null,
    date_hour datetime not null,
    authorized_by varchar(100) not null,
    foreign key (costumer_id) references costumers(costumer_id),
    foreign key (transaction_type) references transaction_types(transaction_id)
);

create table collectors (
	id int not null,
    collector_id varchar(255) not null primary key,
    service_name int not null,
    description varchar(255) not null
);

create table payments_collectors (
	id int not null,
    payment_id varchar(255) not null primary key,
    costumer_id varchar(255) not null,
    collector_id varchar(255) not null,
    amount decimal(5,2) not null,
    date_hour datetime not null,
    foreign key (costumer_id) references costumers(costumer_id),
    foreign key (collector_id) references collectors(collector_id)
);

create table bills (
	id int not null,
    bill_id varchar(255) not null primary key,
    transaction_id varchar(255) not null,
    amount decimal(5,2) not null,
    mail_sent boolean not null,
    foreign key (transaction_id) references transactions(transaction_id)
);

create table roles (
	id int not null,
    role_id int not null primary key,
    role varchar(25) not null
);

create table users (
	id int not null,
    user_id varchar(255) not null primary key,
	username varchar(100) not null,
    password varchar(100) not null,
    email varchar(255) not null,
    role int not null,
    foreign key (role) references roles(role_id)
);

create table approvals (
	id int not null,
    approval_id varchar(255) not null primary key,
    transaction_id varchar(255) not null,
    authorizer_id varchar(255) not null,
    date_hour datetime not null,
    foreign key (authorizer_id) references users(user_id)
);

create table audit (
	id int not null,
    user_id varchar(255) not null,
    action varchar(255) not null,
    date_hour datetime not null,
    detail varchar(255) not null,
    foreign key (user_id) references users(user_id)
);