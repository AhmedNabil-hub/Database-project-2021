-- Procedure to create a new order
CREATE PROCEDURE spnew_order (
@clientID int,
@clientFname varchar(50),
@clientLname varchar(50),
@clientPhone varchar(50),
@orderID int,
@addressID int,
@orderWeight int,
@orderDimensions varchar(50),
@orderRegion varchar(50),
@orderArrDate date,
@recieverFname varchar(50),
@recieverLname varchar(50),
@recieverPhone varchar(50),
@orderAddressGov varchar(50),
@orderAddressCity varchar(50),
@orderAddressSt varchar(50),
@orderAddressAdditional varchar(50),
@orderPricingID int
)
AS
BEGIN
  DECLARE @address_id int = @addressID;
  DECLARE @client_id int = @clientID;
  DECLARE @error int = 1;
  
  BEGIN TRANSACTION new_order
    BEGIN TRY
      IF NOT EXISTS (SELECT * FROM [dbo].[address]
              WHERE governorate = @orderAddressGov
              AND city = @orderAddressCity
              AND street = @orderAddressSt
              AND additional = @orderAddressAdditional)
        BEGIN
          INSERT INTO [dbo].[address] (id, governorate, city, street, additional)
          VALUES (@address_id, @orderAddressGov, @orderAddressCity, @orderAddressSt, @orderAddressAdditional);
        END
      ELSE
        BEGIN
          SELECT @address_id = id from [dbo].[address]
              WHERE governorate = @orderAddressGov
              AND city = @orderAddressCity
              AND street = @orderAddressSt
              AND additional = @orderAddressAdditional;
          PRINT N'This address already stored at id';
          PRINT @address_id;
        END
    END TRY

    BEGIN CATCH
      PRINT N'INSERT INTO ADDRESS ERROR';
      SET @error = -1;
    END CATCH

    BEGIN TRY
      IF NOT EXISTS (SELECT * FROM [dbo].[client]
              WHERE first_name = @clientFname
              AND last_name = @clientLname
              AND phone_no = @clientPhone)
          BEGIN
          INSERT INTO [dbo].[client] (id, first_name,last_name, phone_no)
          VALUES (@client_id, @clientFname, @clientLname, @clientPhone);
        END
      ELSE
        BEGIN
          SELECT @client_id = id FROM [dbo].[client]
                      WHERE first_name = @clientFname
                      AND last_name = @clientLname
                      AND phone_no = @clientPhone;
          PRINT N'This client already stored at id';
          PRINT @client_id;
        END
    END TRY

    BEGIN CATCH
      PRINT N'INSERT INTO CLIENT ERROR';
      SET @error = -1;
    END CATCH

    BEGIN TRY
      INSERT INTO [dbo].[order](id, client_id, address_id, weight, dimensions, region, state, pricing_id, arrival_date, reciever_first_name, reciever_last_name, reciever_phone_no)
      VALUES (@orderID, @client_id, @address_id, @orderWeight, @orderDimensions, @orderRegion, 'Pending', @orderPricingID, @orderArrDate, @recieverFname, @recieverLname, @recieverPhone);
    END TRY
      
    BEGIN CATCH
      PRINT N'INSERT INTO ORDER ERROR';
      SET @error = -1;
    END CATCH

    IF (@error > 0)
      BEGIN
        COMMIT TRANSACTION new_order;
        PRINT N'a new order added';
      END
    
    ELSE
      BEGIN
        ROLLBACK TRANSACTION new_order;
        PRINT N'new order creation failed';
      END
END
GO

-- Procedure to assign order to driver
CREATE PROCEDURE spwith_driver(
@orderID int,
@driverID int
)
AS
BEGIN

  BEGIN TRY
    BEGIN TRANSACTION with_driver
      UPDATE [dbo].[order]
	    SET driver_id = @driverID, state = 'With Driver'
	    WHERE id = @orderID;
    COMMIT TRANSACTION with_driver;
    PRINT N'order modified successfully';
  END TRY

  BEGIN CATCH
    ROLLBACK TRANSACTION with_driver;
    PRINT N'order modification failed';
  END CATCH

END;
GO


--Procedure when order is delivered
CREATE PROCEDURE spdelivered(
@orderID int,
@driverID int
)
AS
BEGIN
  BEGIN TRY

  BEGIN TRANSACTION delivered
    UPDATE [dbo].[order]
    SET state = 'Delivered'
    WHERE driver_id = @driverID and id = @orderID;

	COMMIT TRANSACTION delivered;
  PRINT N'order modified successfully';
  END TRY

  BEGIN CATCH
    ROLLBACK TRANSACTION delivered;
    PRINT N'order modification failed';
  END CATCH

END
GO


--Procedure when order is canceled
CREATE PROCEDURE spcanceled (
@orderID int
)
AS
BEGIN

  BEGIN TRY
    BEGIN TRANSACTION canceled
      UPDATE [dbo].[order]
      SET state = 'Canceled'
      WHERE id = @orderID;
    COMMIT TRANSACTION canceled;
    PRINT N'order canceled successfully';
  END TRY

  BEGIN CATCH
    ROLLBACK TRANSACTION canceled;
    PRINT N'order cancelation failed';
  END CATCH

END
GO


-- Manager view the basic orders' information
CREATE VIEW [all_orders_info]
AS
SELECT O.id, O.reciever_first_name, O.reciever_last_name, O.reciever_phone_no, O.state, O.arrival_date, A.governorate, A.city, A.street, A.additional
FROM [order] AS O 
JOIN address AS A
ON O.address_id = A.id;
GO


--View of number of order for each driver 
CREATE VIEW [driver_orders_count]
AS 
SELECT driver_id,
COUNT (*) AS 'orders_number' FROM [order]
GROUP BY driver_id;
GO


-- Function for client view his order state
CREATE FUNCTION custom_order_info(
@orderID int
)
RETURNS TABLE
AS
RETURN(
	SELECT O.id, O.state, O.arrival_date, O.arrival_note, E.first_name AS driver_first_name, E.last_name AS driver_last_name, E.phone_no AS driver_phone_no
	FROM [order] AS O, employee AS E
	WHERE O.id = @orderID AND E.id = O.driver_id
	)
GO

 
 -- Function for manager view drivers' info
CREATE FUNCTION custom_driver_info(
@driverID int
)
RETURNS TABLE
AS
RETURN(
	SELECT O.id, O.state, O.arrival_date, O.arrival_note, O.reciever_first_name , O.reciever_last_name, O.reciever_phone_no
	FROM [order] AS O
	WHERE O.driver_id = @driverID
	)
GO
