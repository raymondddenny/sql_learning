CREATE DATABASE studi_kasus_order_history;

USE studi_kasus_order_history;

CREATE TABLE orders
(
    id                    VARCHAR(100) PRIMARY KEY,
    seller_id             VARCHAR(100),
    seller_name           VARCHAR(100),
    buyer_id              VARCHAR(100),
    buyer_name            VARCHAR(100),
    shipping_name         VARCHAR(100),
    shipping_address      VARCHAR(500),
    shipping_phone        VARCHAR(25),
    logistic_id           VARCHAR(100),
    logistic_name         VARCHAR(100),
    payment_method_id     VARCHAR(100),
    payment_method_name   VARCHAR(100),
    total_quantity        INT,
    total_weight          INT,
    total_product_amount  BIGINT,
    total_shipping_cost   BIGINT,
    total_shipping_amount BIGINT,
    service_charge        BIGINT,
    total_amount          BIGINT

) ENGINE InnoDB;

DESC orders;

CREATE TABLE order_detail
(
    id                  VARCHAR(100) PRIMARY KEY,
    order_id            VARCHAR(100),
    product_id          VARCHAR(100),
    product_name        VARCHAR(100),
    product_price       BIGINT,
    product_weight      INT,
    product_qty         INT,
    product_total_price BIGINT
) ENGINE = InnoDB;

DESC order_detail;


# add fk constraint between orders and order_detail table
ALTER TABLE order_detail
    ADD CONSTRAINT fk_order_detail_orders
        FOREIGN KEY (order_id)
            REFERENCES orders (id);

DESC order_detail;


INSERT INTO orders(id, seller_id, seller_name, buyer_id, buyer_name, shipping_name, shipping_address, shipping_phone,
                   logistic_id, logistic_name, payment_method_id, payment_method_name, total_quantity, total_weight,
                   total_product_amount, total_shipping_cost, total_shipping_amount, service_charge, total_amount)
VALUES ('001', 'S01', 'Toko Anugerah', 'B01', 'Denny Raymond', 'Kos Crystal', 'Jalan Nusantara no 50, Tangerang',
        '0858213812', 'SA', 'SampaiAJA', 'P01', 'COD', 10, 5, 250000, 10000, 251000, 5000, 256000);

SELECT * FROM orders;

ALTER TABLE orders MODIFY COLUMN created_at TIMESTAMP DEFAULT NOW();

UPDATE orders SET created_at = NOW() WHERE id = '001';

INSERT INTO order_detail(id, order_id, product_id, product_name, product_price, product_weight, product_qty, product_total_price)
VALUES('002','001','P001','Charger Laptop Gaming Asus',250000,1000,1,250000);



# JOIN TABLE to get the order history
SELECT * FROM orders o JOIN order_detail od ON o.id = od.order_id;


# single query
SELECT * FROM orders WHERE id = '001';

SELECT * FROM order_detail WHERE order_id = '001';