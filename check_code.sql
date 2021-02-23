USE [shipping_company]
GO

-- First Execute This
---- To Add a new order ----

/*
EXEC [dbo].[spnew_order]
		@clientFname = N'Ahmed',
		@clientLname = N'Nabil',
		@clientPhone = N'+201120011981',
		@orderWeight = 20,
		@orderDimensions = N'30*30*30',
		@orderRegion = N'Al Gharbia',
		@orderArrDate = '2021-03-8',
		@recieverFname = N'Mohamed',
		@recieverLname = N'Ahmed',
		@recieverPhone = N'+201056648729',
		@orderAddressGov = N'Al Gharbia',
		@orderAddressCity = N'Tanta',
		@orderAddressSt = N'Gaish St',
		@orderAddressAdditional = N'building no. 20',
		@orderPricingID = 3

GO

SELECT * FROM [order];
SELECT * FROM [client];
SELECT * FROM custom_order_info (20);				-- Table-Valued Function			NOTE!! add an existing order id. You can know the recent added order id from the Results
SELECT * FROM custom_driver_info (204);			-- Table-Valued Function			NOTE!! add an existing driver id. You can know the recent added driver id
SELECT * FROM [log_table];

*/

-- Second Execute This
---- To change state of the order to be with driver ----
/*
EXEC [dbo].[spwith_driver]
		@orderID = 20,													-- NOTE!! add an existing order id. You can know the recent added order id from the Results
		@driverID = 204													-- NOTE!! add an existing driver id. You can know the recent added driver id

GO

SELECT * FROM custom_order_info (20);
SELECT * FROM custom_driver_info (204);
SELECT * FROM [log_table];
*/


-- Third Execute This
---- To change state of the order to be delivered ----
/*
EXEC [dbo].[spdelivered]
		@orderID = 20,													-- NOTE!! add an existing order id. You can know the recent added order id from the Results
		@driverID = 204													-- NOTE!! add an existing driver id. You can know the recent added driver id

GO

SELECT * FROM custom_order_info (20);				-- Table-Valued Function			NOTE!! add an existing order id. You can know the recent added order id from the Results
SELECT * FROM custom_driver_info (204);			-- Table-Valued Function			NOTE!! add an existing driver id. You can know the recent added driver id
SELECT * FROM [log_table];
*/


-- OR This
---- To change state of the order to be canceled ----
/*
EXEC	[dbo].[spcanceled]
		@orderID = 20																	-- NOTE!! add an existing order id. You can know the recent added order id from the Results

GO

SELECT * FROM custom_order_info (20);				-- Table-Valued Function
SELECT * FROM custom_driver_info (204);			-- Table-Valued Function
SELECT * FROM [log_table];

*/

-- Fourth Execute This

---- To check CASCADE actions when delete a driver that has orders it prevents this  ----

/*
DELETE FROM [employee] WHERE id = 204;			-- To see the effect of deletion, insert the driver or employee id you added your new order to him
SELECT * FROM [order];
SELECT * FROM [driver];
SELECT * FROM custom_driver_info (204);			-- Table-Valued Function			-- To see the effect of deletion, insert the driver id you added your new order to him
SELECT * FROM [log_table];
*/

---- To check CASCADE actions when delete a client deletes all his orders too  ----

/*
DELETE FROM [client] WHERE id=120;											-- To see the effect of deletion, insert the client id you added your new order to him
SELECT * FROM [order];
SELECT * FROM [client];
SELECT * FROM custom_driver_info (204);			-- Table-Valued Function
SELECT * FROM [log_table];
*/

-- Fifth Execute This 
---- Manager Views ----

/*
SELECT * FROM all_orders_info;
SELECT * FROM driver_orders_count;
*/

