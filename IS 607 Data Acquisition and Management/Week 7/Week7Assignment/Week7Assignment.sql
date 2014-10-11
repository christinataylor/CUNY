
--How many films contain the word bride in their title?

SELECT title FROM film WHERE title SIMILAR TO '%(B|b)ride%';

--Give one example of functionality that exists in PostgreSQL that is a superset of ANSI SQL’s functionality. 
--What are the advantages of using or not using this functionality in a database application?

--Schema are a superset of ANSI SQL's functionality. Using schema can really help in the organization of your tables, especially when you by necessity
--have multiple tables. It can help you manage your dependencies (at least by checking out the keys... Still researching how to list dependent tables.)

--Suppose someone wants to delete a customer that owes money. Describe (using the names of the 
--appropriate tables in the sample database described in the tutorial) how the database should respond to a 
--DELETE statement.

--First Lets get an idea of what the tables looks like
SELECT * FROM customer;
--Lets work with the first record
SELECT * FROM customer WHERE first_name = 'Jared' AND last_name = 'Ely';
--Take note of the keys
--customer_id = 524
--address_id = 530

DELETE FROM customer WHERE first_name = 'Jared' AND last_name = 'Ely';
--ERROR: update or delete on table "customer" violates foreign key constraint "payment_customer_id_fkey" on table "payment"
--SQL state: 23503
--Detail: Key (customer_id)=(524) is still referenced from table "payment".
--This is not letting me delete the record because there are still payments associated with this customer_id. Lets try deleting those payments

SELECT * FROM payment WHERE customer_ID = '524';
DELETE from payment WHERE customer_ID = '524';

--Now lets try deleting that customer

DELETE FROM customer WHERE first_name = 'Jared' AND last_name = 'Ely';
--ERROR: update or delete on table "customer" violates foreign key constraint "rental_customer_id_fkey" on table "rental"
--SQL state: 23503
--Detail: Key (customer_id)=(524) is still referenced from table "rental".
--Lets do that again

SELECT * FROM rental WHERE customer_id = 524;
DELETE FROM rental WHERE customer_id = 524;

DELETE FROM customer WHERE first_name = 'Jared' AND last_name = 'Ely';
--Successful, but what about the address key?

SELECT * FROM address WHERE address_id = 530;
--Weird that the addresses are able to remain...
