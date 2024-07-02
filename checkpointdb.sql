DROP TABLE IF EXISTS contacts;
DROP TABLE IF EXISTS contact_types;
DROP TABLE IF EXISTS contact_categories;
DROP TABLE IF EXISTS items;


CREATE TABLE IF NOT EXISTS contacts (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	tittle VARCHAR(20),
	organization VARCHAR(30),
	CONSTRAINT uq_person UNIQUE(first_name, last_name)
);

CREATE TABLE IF NOT EXISTS contact_types (
	id SERIAL PRIMARY KEY,
	contact_type VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS contact_categories (
	id SERIAL PRIMARY KEY,
	contact_category VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS items (
	contact VARCHAR(50) NOT NULL,
	contact_id INTEGER NOT NULL,
	contact_type_id INTEGER NOT NULL,
	contact_category_id INTEGER NOT NULL,
	FOREIGN KEY (contact_id) REFERENCES contacts(id),
	FOREIGN KEY (contact_type_id) REFERENCES contact_types(id),
	FOREIGN KEY (contact_category_id) REFERENCES contact_categories(id)
);


INSERT INTO contacts(first_name, last_name, tittle, organization) VALUES
	('Erik', 'Eriksson', 'Teacher', 'Utbildning'),
	('Anna', 'Sundh', null, null),
	('Goran', 'Bregovic', 'Coach', 'Dalens'),
	('Herman', 'Appelkvist', null, null)
;

INSERT INTO contact_types(contact_type) VALUES
	('Email'), 
	('Phone'), 
	('Skype'), 
	('Instagram')
;

INSERT INTO contact_categories(contact_category) VALUES
	('Home'),
	('Work'),
	('Fax')
;

INSERT INTO items(contact, contact_id, contact_type_id, contact_category_id) VALUES
	('011-12 33 45', 3, 2, 1),
	('goran@infoab.se', 3, 1, 2),
	('010 88 55 44', 4, 2, 2),
	('erik57@hotmail.com', 1, 1, 1),
	('@annapanna99', 2, 4, 1),
	('077-563578', 2, 2, 1),
	('070-156 22 78', 3, 2, 2)
;

INSERT INTO contacts(first_name, last_name, tittle, organization) VALUES
	('Meeri', 'Forslund', 'Student', 'Data Engineer')
;

INSERT INTO items(contact, contact_id, contact_type_id, contact_category_id) VALUES
	('mfor@gmail.com', 5, 1, 1)
;

SELECT * FROM contact_types
LEFT JOIN items ON items.contact_type_id = contact_types.id
WHERE items.contact_type_id IS NULL;


CREATE VIEW view_contacts AS
SELECT contacts.first_name, contacts.last_name, items.contact, contact_types.contact_type, contact_categories.contact_category
FROM contacts
JOIN items ON contacts.id = items.contact_id
JOIN contact_types ON items.contact_type_id = contact_types.id
JOIN contact_categories ON items.contact_category_id = contact_categories.id;

SELECT * FROM view_contacts;

SELECT *
FROM contacts
JOIN items ON contacts.id = items.contact_id
JOIN contact_types ON items.contact_type_id = contact_types.id
JOIN contact_categories ON items.contact_category_id = contact_categories.id;




