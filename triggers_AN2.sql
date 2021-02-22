ALTER PROCEDURE create_trigger(
@table_name varchar(20)
)
AS
BEGIN 
  DECLARE @tr_name nvarchar(20) = 'tr_' + @table_name
  DECLARE @tr_code nvarchar(max) ;

  SET @tr_code='CREATE TRIGGER ' + @tr_name + CHAR(10) +
  'ON [dbo].[' + @table_name + ']
  AFTER
  INSERT, DELETE, UPDATE 
  AS
  BEGIN 
    DECLARE @operation varchar(7);
    DECLARE @id int;
    SET @operation = CASE 
      WHEN EXISTS (SELECT * FROM inserted)
      THEN ''insert''
      WHEN EXISTS (SELECT * FROM deleted)
      THEN ''delete''
      WHEN EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted) THEN ''update''
    END

    SELECT @id=id from inserted;
    IF (@id IS NULL)
      SELECT @id=id from deleted;
    INSERT INTO [dbo].[log_table] (operation, on_table, at_time, log_message) VALUES (@operation, '''+@table_name+''', GETDATE(), ''row '' + @operation + ''d with id = ''+ CAST(@id as varchar));
   END';
   exec (@tr_code);
END
GO

EXEC create_trigger @table_name='employee';
