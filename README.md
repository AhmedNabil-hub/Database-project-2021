# Database-project-2021
## Shipping Company Database with MS SQL Server

Database course-Third Year-Tanta University Computer and Automatic control Department

### Tables

* order
* employee
* driver
* client
* pricing
* address
* log_table

### Referential Integrity Actions

* On **DELETE** -> **Cascade**
* On **UPDATE** -> **Cascade**

### Procedures

* **_spnew_order_**     : To add a new order
* **_spwith_driver_**   : To change the order state to be with a driver
* **_spdelivered_**     : To change the order state to be delivered
* **_spwcanceled_**     : To change the order state to be canceled
* **_create_trigger_**  : To create a trigger on all actions can be done on a table to add it in log_table

### Triggers

* ***AFTER*** DELETE, UPDATE and INSERT into any table, then add these actions to log_table

### Views

* **_all_orders_info_**     : Manager view the basic orders' information
* **_driver_orders_count_** : View of count of orders assigned to each driver

### Functions
_You can say is used as a dynamic views with parameters_

* **_custom_order_info_**   : Return a table with a specific order information so the client can trace its order state
* **_custom_driver_info_**  : Return a table with all orders information assigned to a specific driver so the driver can trace them


