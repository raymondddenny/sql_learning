CREATE DATABASE studi_kasus_multi_bahasa;

USE studi_kasus_multi_bahasa;

CREATE TABLE categories(
    id VARCHAR(100),
    position INT,
    PRIMARY KEY (id)
    ) ENGINE = InnoDB;


DESC categories;

INSERT INTO categories (id, position) VALUES('FOOD',1);
INSERT INTO categories (id, position) VALUES('GADGET',2);
INSERT INTO categories (id, position) VALUES('FASHION',3);


SELECT * FROM categories ORDER BY position;

CREATE TABLE categories_translations(
    category_id VARCHAR(100) NOT NULL,
    language VARCHAR(100) NOT NULL,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(100),
    PRIMARY KEY (category_id,language)
    )ENGINE = InnoDB;


# change position to not null
ALTER TABLE categories MODIFY position INT NOT NULL ;

DESC categories;


# add constraint
ALTER TABLE categories_translations
    ADD CONSTRAINT fk_categories_translations_categories
        FOREIGN KEY (category_id)
            REFERENCES categories(id);

DESC categories_translations;


SELECT * FROM categories c
    JOIN categories_translations ct ON c.id = ct.category_id;

INSERT INTO categories_translations (category_id, language, name, description)
VALUES('FOOD','in_ID','Makanan','Deskripsi Makanan');

INSERT INTO categories_translations (category_id, language, name, description)
VALUES('FOOD','en_US','Food','Food Description here');

INSERT INTO categories_translations (category_id, language, name, description)
VALUES('GADGET','en_US','Gadget','Gadget Description here');

INSERT INTO categories_translations (category_id, language, name, description)
VALUES('GADGET','in_ID','Gawai','Gawai deskripsi disini');


SELECT * FROM categories c
    JOIN categories_translations ct ON c.id = ct.category_id
         WHERE ct.language = 'in_ID' ORDER BY c.position;


