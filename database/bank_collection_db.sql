CREATE DATABASE bank_collection_db;

USE bank_collection_db;

CREATE TABLE customers (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    identity_doc VARCHAR(20) NOT NULL,
    email VARCHAR(255) NOT NULL,
    account_number VARCHAR(19) NOT NULL,
    balance DECIMAL(10, 2) NOT NULL
);

CREATE TABLE transaction_types (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    transaction_type_id VARCHAR(255) NOT NULL,
    transaction_type VARCHAR(25) NOT NULL
);

CREATE TABLE transactions (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    transaction_id VARCHAR(255) NOT NULL,
    customer_id INT NOT NULL,
    transaction_type_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    date_hour DATETIME NOT NULL,
    authorized_by VARCHAR(100) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers (id),
    FOREIGN KEY (transaction_type_id) REFERENCES transaction_types (id)
);

CREATE TABLE denominations (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    denomination_id VARCHAR(255) NOT NULL,
    value DECIMAL(10, 2) NOT NULL,
    type VARCHAR(50) NOT NULL
);

CREATE TABLE transaction_denominations (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    transaction_id INT NOT NULL,
    denomination_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (transaction_id) REFERENCES transactions (id),
    FOREIGN KEY (denomination_id) REFERENCES denominations (id)
);

CREATE TABLE collectors (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    collector_id VARCHAR(255) NOT NULL,
    service_name VARCHAR(100) NOT NULL,
    description VARCHAR(255) NOT NULL
);

CREATE TABLE payments_collectors (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    payment_id VARCHAR(255) NOT NULL,
    customer_id INT NOT NULL,
    collector_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    date_hour DATETIME NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers (id),
    FOREIGN KEY (collector_id) REFERENCES collectors (id)
);

CREATE TABLE bills (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    bill_id VARCHAR(255) NOT NULL,
    transaction_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    mail_sent BOOLEAN NOT NULL,
    FOREIGN KEY (transaction_id) REFERENCES transactions (id)
);

CREATE TABLE roles (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    role_id INT NOT NULL,
    role VARCHAR(25) NOT NULL
);

CREATE TABLE users (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    username VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    role_id INT NOT NULL,
    FOREIGN KEY (role_id) REFERENCES roles (id)
);

CREATE TABLE approvals (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    approval_id VARCHAR(255) NOT NULL,
    transaction_id INT NOT NULL,
    authorizer_id INT NOT NULL,
    date_hour DATETIME NOT NULL,
    FOREIGN KEY (transaction_id) REFERENCES transactions (id),
    FOREIGN KEY (authorizer_id) REFERENCES users (id)
);

CREATE TABLE audit (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    action VARCHAR(255) NOT NULL,
    date_hour DATETIME NOT NULL,
    detail VARCHAR(255) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id)
);