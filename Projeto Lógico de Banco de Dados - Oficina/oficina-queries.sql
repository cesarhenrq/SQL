-- Queries para responder questões relacionadas ao banco de dados de uma oficina.

-- Qual o valor total de uma ordem de serviço?
SELECT orderTask.idOrderTask, ((partordertask.quantity * partPrice) + (taskordertask.quantity * taskPrice)) AS Valor_Ordem_de_Serviço 
			FROM part, task, ordertask, taskordertask, partordertask
			WHERE part.idPart = partordertask.idPart
            AND ordertask.idOrderTask = partordertask.idOrderTask
            AND task.idTask = taskordertask.idTask
            AND ordertask.idOrderTask = taskordertask.idOrderTask
            ORDER BY Valor_Ordem_de_Serviço DESC
;

-- Quantos veículos cada cliente tem na oficina?
SELECT CONCAT(fName, " ",lName) AS Client_Name, COUNT(*)  
			FROM clients AS c, vihicle AS v
			WHERE idClientVehicle = idClient
            GROUP BY idClient
;

-- Quais clientes autorizaram a ordem de serviço?
SELECT clients.Fname, clients.autorization 
			FROM clients
			INNER JOIN ordertask ON (clients.idClient = ordertask.idClientOrderTask)
            HAVING clients.autorization = "Autorizado"
;

-- Quais clientes possuem moto? 
SELECT fName, model, brand
			FROM clients , vihicle 
			WHERE idClient = idClientVehicle 
            AND vehicleType = "Moto"
