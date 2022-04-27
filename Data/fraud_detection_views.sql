DROP VIEW IF EXISTS cardholder_transactions CASCADE;
DROP VIEW IF EXISTS cardholder25_transactions CASCADE;
DROP VIEW IF EXISTS small_transactions CASCADE;
DROP VIEW IF EXISTS large_transactions CASCADE;
DROP VIEW IF EXISTS transactions7_9 CASCADE;
DROP VIEW IF EXISTS transactionsNOT_7_9 CASCADE;
DROP VIEW IF EXISTS fraudulent_merchants CASCADE;

-- View of query that isolates/groups the transactiosn of each cardholder
CREATE VIEW cardholder_transactions AS
SELECT credit_card.cardholder_id, transaction.date, transaction.amount
FROM credit_card
LEFT JOIN transaction
ON credit_card.card = transaction.card;


--View of Cardholder 25 Transactions by Month Number and Day number
CREATE VIEW cardholder25_transactions AS
SELECT EXTRACT(MONTH FROM transaction.date) as month,EXTRACT(DAY FROM transaction.date) as day, transaction.amount
FROM credit_card
LEFT JOIN transaction
ON credit_card.card = transaction.card
WHERE transaction.date between '2018-01-01' and '2018-06-30' and
credit_card.cardholder_id  = 25;


-- View of the number of transactions that are less than $2.00 per cardoholder
CREATE VIEW small_transactions AS
SELECT credit_card.cardholder_id, COUNT(transaction.amount) as "Small Transactions"
FROM credit_card
LEFT JOIN transaction
ON (credit_card.card = transaction.card)
WHERE transaction.amount < 2.00
GROUP BY credit_card.cardholder_id
ORDER BY credit_card.cardholder_id ASC;


-- View of the number of transactions that are larger than $500.00 per cardoholder
CREATE VIEW large_transactions AS
SELECT credit_card.cardholder_id, COUNT(transaction.amount) as "Small Transactions"
FROM credit_card
LEFT JOIN transaction
ON (credit_card.card = transaction.card)
WHERE transaction.amount > 500
GROUP BY credit_card.cardholder_id;

-- View of top 100 transactions between 7am and 9am
CREATE VIEW transactions7_9 AS
SELECT credit_card.cardholder_id,transaction.date, transaction.amount
FROM credit_card
LEFT JOIN transaction
ON credit_card.card = transaction.card
WHERE CAST(transaction.date as time) between '07:00:00' and '09:00:00'
ORDER BY transaction.amount DESC
LIMIT 100;


-- View of top 100 transactions that occure before 7am and after 9am
CREATE VIEW transactionsNOT_7_9 AS
SELECT credit_card.cardholder_id,transaction.date, transaction.amount
FROM credit_card
LEFT JOIN transaction
ON credit_card.card = transaction.card
WHERE CAST(transaction.date as time) not between '07:00:00' and '09:00:00'
ORDER BY transaction.amount DESC
LIMIT 100;


-- View of Merchant types that have the most transactions smaller than $2.00
CREATE VIEW fraudulent_merchants AS
SELECT merchant_category.name, COUNT(transaction.amount) as "Small Transactions"
FROM transaction
JOIN merchant
	ON transaction.id_merchant = merchant.id
JOIN merchant_category
	ON merchant.id_merchant_category = merchant_category.id
WHERE transaction.amount < 2.00
GROUP BY merchant_category.name
ORDER by COUNT(transaction.amount) DESC;



