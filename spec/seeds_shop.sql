TRUNCATE TABLE items, orders RESTART IDENTITY;


INSERT INTO items (name, price, quantity) VALUES ('Apple', 20, 5);
INSERT INTO items (name, price, quantity) VALUES ('Ball', 200 , 1);
INSERT INTO items (name, price, quantity) VALUES ('Chair', 7000, 10);
INSERT INTO items (name, price, quantity) VALUES ('Discoball', 2000, 0);
INSERT INTO items (name, price, quantity) VALUES ('Eggs', 150, 35);

INSERT INTO orders (customer_name, date_placed, item_id) VALUES ('Anna', '2022-10-25', 1);
INSERT INTO orders (customer_name, date_placed, item_id) VALUES ('Bob', '2022-10-26', 3);
INSERT INTO orders (customer_name, date_placed, item_id) VALUES ('Clara', '2022-10-26', 1);