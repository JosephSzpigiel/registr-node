CREATE TABLE customer_types (
  id INT PRIMARY KEY AUTO_INCREMENT,
  type_name VARCHAR(255)
);

CREATE TABLE event_types (
  id INT PRIMARY KEY AUTO_INCREMENT,
  type_name VARCHAR(255)
);

CREATE TABLE event_groups (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255),
  img_url VARCHAR(255),
  description TEXT
);

CREATE TABLE customers (
  id INT PRIMARY KEY AUTO_INCREMENT,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  last_login TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  img_url VARCHAR(255),
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  email VARCHAR(255) UNIQUE,
  customer_type_id INT,
  FOREIGN KEY (customer_type_id) REFERENCES customer_types (id)
);

CREATE TABLE customer_groups (
  id INT PRIMARY KEY AUTO_INCREMENT,
  joined_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  customer_id INT,
  admin BOOL,
  group_id INT,
  FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE CASCADE,
  FOREIGN KEY (group_id) REFERENCES event_groups (id) ON DELETE CASCADE
);

CREATE TABLE events (
  id INT PRIMARY KEY AUTO_INCREMENT,
  image_url VARCHAR(255),
  name VARCHAR(255),
  description TEXT,
  created_by_id INT,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  event_type_id INT,
  group_id INT,
  start_time TIMESTAMP,
  end_time TIMESTAMP,
  max_tickets INT NOT NULL,
  FOREIGN KEY (created_by_id) REFERENCES customers (id),
  FOREIGN KEY (event_type_id) REFERENCES event_types (id),
  FOREIGN KEY (group_id) REFERENCES event_groups (id) ON DELETE CASCADE
);

CREATE TABLE registrations (
  id INT PRIMARY KEY AUTO_INCREMENT,
  registration_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  event_id INT,
  customer_id INT,
  tickets INT,
  FOREIGN KEY (event_id) REFERENCES events (id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE CASCADE ON UPDATE CASCADE
);