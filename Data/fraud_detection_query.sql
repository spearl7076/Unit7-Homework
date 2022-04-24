-- Isolates/groups the transactiosn of each cardholder
SELECT credit_card.cardholder_id, transaction.date, transaction.amount
FROM credit_card
LEFT JOIN transaction
ON credit_card.card = transaction.card;

--Grabs the Transaction Month Number, Day Number, and Amount for Cardholder 25
SELECT EXTRACT(MONTH FROM transaction.date) as month,EXTRACT(DAY FROM transaction.date) as day, transaction.amount
FROM credit_card
LEFT JOIN transaction
ON credit_card.card = transaction.card
WHERE transaction.date between '2018-01-01' and '2018-06-30' and
credit_card.cardholder_id  = 25;

-- Counts the transactions that are less than $2.00 per cardoholder
SELECT credit_card.cardholder_id, COUNT(transaction.amount) as "Small Transactions"
FROM credit_card
LEFT JOIN transaction
ON (credit_card.card = transaction.card)
WHERE transaction.amount < 2.00
GROUP BY credit_card.cardholder_id
ORDER BY credit_card.cardholder_id ASC;

-- Counts the transactions that are more than $500.00 per cardoholder
SELECT credit_card.cardholder_id, COUNT(transaction.amount) as "Small Transactions"
FROM credit_card
LEFT JOIN transaction
ON (credit_card.card = transaction.card)
WHERE transaction.amount > 500
GROUP BY credit_card.cardholder_id;

-- Lists the top 100 transactions between 7am and 9am
SELECT credit_card.cardholder_id,transaction.date, transaction.amount
FROM credit_card
LEFT JOIN transaction
ON credit_card.card = transaction.card
WHERE CAST(transaction.date as time) between '07:00:00' and '09:00:00'
ORDER BY transaction.amount DESC
LIMIT 100;

-- Lists the top 100 transactions that occure before 7am and after 9am
SELECT credit_card.cardholder_id,transaction.date, transaction.amount
FROM credit_card
LEFT JOIN transaction
ON credit_card.card = transaction.card
WHERE CAST(transaction.date as time) not between '07:00:00' and '09:00:00'
ORDER BY transaction.amount DESC
LIMIT 100;

-- Merchant types that have the most transactions smaller than $2.00
SELECT merchant_category.name, COUNT(transaction.amount) as "Small Transactions"
FROM transaction
JOIN merchant
	ON transaction.id_merchant = merchant.id
JOIN merchant_category
	ON merchant.id_merchant_category = merchant_category.id
WHERE transaction.amount < 2.00
GROUP BY merchant_category.name
ORDER by COUNT(transaction.amount) DESC;
