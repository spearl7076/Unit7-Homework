SELECT credit_card.cardholder_id, transaction.date, transaction.amount
FROM credit_card
LEFT JOIN transaction
ON credit_card.card = transaction.card;

SELECT EXTRACT(MONTH FROM transaction.date) as month,EXTRACT(DAY FROM transaction.date) as day, transaction.amount
FROM credit_card
LEFT JOIN transaction
ON credit_card.card = transaction.card
WHERE transaction.date between '2018-01-01' and '2018-06-30' and
credit_card.cardholder_id  = 25;


