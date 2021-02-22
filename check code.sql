USE [shipping_company]
GO

-- First Execute This
---- To Add a new order ----
---- If you want to re execute this, you should increment the id of client and address if you want to add a new one ----

/*
EXEC [dbo].[spnew_order]
		@clientID = 6,
		@clientFname = N'Ahmed',
		@clientLname = N'Nabil',
		@clientPhone = N'+201120011981',
		@orderID = 6,
		@addressID = 19,
		@orderWeight = 20,
		@orderDimensions = N'30*30*30',
		@orderRegion = N'Al Gharbia',
		@orderArrDate = '2021-03-8',
		@recieverFname = N'Mohamed',
		@recieverLname = N'Ahmed',
		@recieverPhone = N'+201056648729',
		@orderAddressGov = N'Al Gharbia',
		@orderAddressCity = N'Tanta',
		@orderAddressSt = NULL,
		@orderAddressAdditional = NULL,
		@orderPricingID = 3

GO

SELECT * FROM [order];
SELECT * FROM [client];
SELECT * FROM custom_order_info (6);				-- Table-Valued Function
SELECT * FROM custom_driver_info (203);			-- Table-Valued Function
SELECT * FROM [log_table];

*/

-- Second Execute This
---- To change state of the order to be with driver ----
/*
EXEC [dbo].[spwith_driver]
		@orderID = 6,
		@driverID = 203

GO

SELECT * FROM custom_order_info (6);
SELECT * FROM custom_driver_info (203);
SELECT * FROM [log_table];

*/

-- Third Execute This
---- To change state of the order to be delivered ----
/*
EXEC [dbo].[spdelivered]
		@orderID = 6,
		@driverID = 203

GO

SELECT * FROM custom_order_info (6);				-- Table-Valued Function
SELECT * FROM custom_driver_info (203);			-- Table-Valued Function
SELECT * FROM [log_table];

*/

-- OR This
---- To change state of the order to be canceled ----
/*
EXEC	[dbo].[spcanceled]
		@orderID = 6

GO

SELECT * FROM custom_order_info (6);				-- Table-Valued Function
SELECT * FROM custom_driver_info (203);			-- Table-Valued Function
SELECT * FROM [log_table];

*/

-- Fourth Execute This

---- To check CASCADE actions when delete a driver that has orders it prevents this  ----

/*
DELETE FROM [employee] WHERE id = 203;
SELECT * FROM [order];
SELECT * FROM [driver];
SELECT * FROM custom_driver_info (203);			-- Table-Valued Function
SELECT * FROM [log_table];
*/

---- To check CASCADE actions when delete a client deletes all his orders too  ----

/*
DELETE FROM [client] WHERE id=6;
SELECT * FROM [order];
SELECT * FROM [client];
SELECT * FROM custom_driver_info (203);			-- Table-Valued Function
SELECT * FROM [log_table];
*/

-- Fifth Execute This 
---- Manager Views ----

/*
SELECT * FROM all_orders_info;
SELECT * FROM driver_orders_count;
*/
