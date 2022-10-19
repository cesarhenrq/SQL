USE ecommerce;

-- Queries para que respodem algumas questões a cerca do banco de dados.

desc provider;

-- Quantos pedidos foram feitos por cada cliente? 
SELECT CONCAT(fName, " ",lName) AS Client, COUNT(idClient) AS Number_of_Request 
			FROM clients AS c, request AS r
			WHERE c.idClient = r.idRequestClient
			GROUP BY idClient
;
                
-- Algum vendedor também é fornecedor?
SELECT p.corporateName AS Corporate_Name, p.CNPJ AS CNPJ, p.contact AS Contact, s.adress AS Adress 
			FROM provider AS p
			INNER JOIN seller AS s ON s.CNPJ = p.CNPJ
;
                
-- Relação de produtos, fornecedores e estoques;
SELECT pName as Product_Name, category as Category, corporateName AS Corporate_Name, quantity As Quantity, storageLocation AS Storage_Location
		FROM product, provider, productStorage, productInStorage, productProvider
		WHERE product.idProduct = productInStorage.idProduct AND
			  productStorage.idProductStorage = productInStorage.idStorage AND
			  provider.idProvider = productInStorage.idProvider 
;

-- Relação de nomes dos fornecedores e nomes dos produtos;
SELECT pName as Product_Name, category as Category, productPrice as Price, corporateName AS Corporate_Name, quantity As Quantity 
		FROM product, provider, productProvider
		WHERE (productProvider.idProvider = provider.idProvider
        AND productProvider.idProduct = product.idProduct)
;


				
		