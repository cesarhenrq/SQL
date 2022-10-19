-- Criação do banco de dados para o cenário de E-Commerce.
CREATE DATABASE ecommerce;
USE ecommerce;

-- Cria tabela cliente.
CREATE TABLE clients (
		idClient INT AUTO_INCREMENT,
        idClientIdentification INT,
        fName VARCHAR(10), 
        mInit CHAR (3),
        lName VARCHAR(20),
        adress VARCHAR(30),
        CONSTRAINT pk_clients PRIMARY KEY (idClient, idClientIdentification),
        CONSTRAINT Fk_identification_clients FOREIGN KEY (idClientIdentification) REFERENCES identification (idIdentification)
);

-- Cria tabela identificação.
CREATE TABLE identification (
		idIdentification INT AUTO_INCREMENT PRIMARY KEY,
        kindPerson ENUM("Física","Jurídica") DEFAULT "Física",
        identificationNumber VARCHAR(20) NOT NULL,
        CONSTRAINT unique_identificationNumber_identification UNIQUE (identificationNumber)
);
                
-- Cria tabela produto.
CREATE TABLE product (
		idProduct INT AUTO_INCREMENT PRIMARY KEY,
        pName VARCHAR(10) NOT NULL,
        classificationKids BOOL DEFAULT FALSE,
        category ENUM("Eletrônico", "Vestimenta", "Brinquedos", "Alimentos","Móveis") NOT NULL,
		avaliation FLOAT DEFAULT 0,
        size VARCHAR(10),
        productPrice FLOAT,
        productDescription VARCHAR(45)
);

-- Cria tabela pedido.
CREATE TABLE request (
		idRequest INT AUTO_INCREMENT PRIMARY KEY,
        idRequestClient INT,
        idRequestDelivery INT,
        requestStatus ENUM("Cancelado", "Confirmado", "Em processamento") NOT NULL,
        requestDescription VARCHAR(255),
        requestPrice FLOAT DEFAULT 10,
        CONSTRAINT fk_request_client FOREIGN KEY (idRequestClient) REFERENCES clients (idClient),
        CONSTRAINT fk_request_delivery FOREIGN KEY (idRequestDelivery) REFERENCES delivery (idDelivery)
);

-- Cria tabela pagamento.
CREATE TABLE payment (
		idPayment INT AUTO_INCREMENT PRIMARY KEY,
        idPaymentCliente INT,
        idPaymentDelivery INT,
        paymentStatus ENUM("Pago", "Em processamento") DEFAULT "Em processamento",
        paymentWay ENUM("Cartão de crédito","Pix", "Boleto","Cartão de débito") NOT NULL,
        creditCardNumber CHAR(16),
        paymentPrice FLOAT NOT NULL,
        CONSTRAINT fk_payment_client FOREIGN KEY (idPaymentCliente) REFERENCES clients(idClient),
        CONSTRAINT fk_delivery_client FOREIGN KEY (idPaymentDelivery) REFERENCES delivery(idDelivery)
);

-- Cria tabela entrega.
CREATE TABLE delivery (
		idDelivery INT AUTO_INCREMENT PRIMARY KEY,
        deliveryStatus ENUM("Entregue","A Caminho")
);

-- Cria tabela estoque.
CREATE TABLE productStorage (
		idProductStorage INT AUTO_INCREMENT PRIMARY KEY,
        storageLocation VARCHAR(255),
        productQuantity INT DEFAULT 0
);

-- Cria tabela fornecedor.
CREATE TABLE provider (
		idProvider INT AUTO_INCREMENT PRIMARY KEY,
        contact CHAR(11) NOT NULL,
        corporateName VARCHAR(45) NOT NULL,
        CNPJ CHAR(14) NOT NULL,
        CONSTRAINT unique_CNPJ_provider UNIQUE (CNPJ)
);

-- Cria tabela vendedor.
CREATE TABLE seller (
		idSeller INT AUTO_INCREMENT PRIMARY KEY,
        contact CHAR(11) NOT NULL,
        adress VARCHAR(255) NOT NULL,
        corporateName VARCHAR(45) NOT NULL,
        CNPJ CHAR(14),
		CPF CHAR(9),
        CONSTRAINT unique_CNPJ_seller UNIQUE (CNPJ),
        CONSTRAINT unique_CPF_seller UNIQUE (CPF)
);

-- Cria tabela produto/vendedor.
CREATE TABLE productSeller (
		idSeller INT AUTO_INCREMENT,
        idProduct INT AUTO_INCREMENT,
        quantity INT NOT NULL DEFAULT 1,
        CONSTRAINT pk_product_seller PRIMARY KEY (idProductSeller, idProduct),
        CONSTRAINT fk_seller FOREIGN KEY (idSeller) REFERENCES seller(idSeller),
        CONSTRAINT fk_product FOREIGN KEY (idProduct) REFERENCES product(idProduct)
);

-- Cria tabela produto/estoque.
CREATE TABLE productInStorage (
		idProduct INT AUTO_INCREMENT,
        idStorage INT AUTO_INCREMENT,
        location VARCHAR(255),
        CONSTRAINT pk_product_in_storage PRIMARY KEY (idStorage, idProduct),
        CONSTRAINT fk_storage FOREIGN KEY (idStorage) REFERENCES seller(idStorage),
        CONSTRAINT fk_product FOREIGN KEY (idProduct) REFERENCES product(idProduct)
);


