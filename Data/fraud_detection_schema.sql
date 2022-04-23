DROP TABLE IF EXISTS card_holder CASCADE;
DROP TABLE IF EXISTS credit_card CASCADE;
DROP TABLE IF EXISTS merchant_category CASCADE;
DROP TABLE IF EXISTS merchant CASCADE;
DROP TABLE IF EXISTS transaction CASCADE;



CREATE TABLE card_holder(
	id INT NOT NULL PRIMARY Key,
	name VARCHAR(200)
);

CREATE TABLE credit_card(
	card VARCHAR(20),
	card_holder_id INT NOT NULL,
	FOREIGN KEY (card_holder_id) REFERENCES card_holder(id)
);

CREATE TABLE merchant_category(
	id INT NOT NULL PRIMARY Key,
	name VARCHAR(200)
);

CREATE TABLE merchant(
	id INT NOT NULL PRIMARY Key,
	name VARCHAR(200),
	id_merchant_category INTEGER NOT NULL,
	FOREIGN KEY (id_merchant_category) REFERENCES merchant_category(id)
);

CREATE TABLE transaction(
	id INTEGER NOT NULL PRIMARY KEY,
	date TIMESTAMP,
	amount FLOAT,
	card VARCHAR(20),
	id_merchant INT NOT NULL,
	FOREIGN KEY (id_merchant) REFERENCES merchant(id)	
);

SELECT * FROM card_holder;
SELECT * FROM credit_card;
SELECT * FROM merchant_category;
SELECT * FROM merchant;
SELECT * FROM transaction;
