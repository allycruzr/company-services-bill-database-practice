# Practical work of continuous assesstment - U. Lusófona 2019 - Bases de Dados - Prof. José Aser
![alt text](https://github.com/acr1618/company-services-bill-database-practice/blob/master/Jose_Aser_PW_BD.png)

- Create all model tables with their NN, PK, UK and CK constraints, considering:

  - PKs are marked with P and when the key is composed the column order is marked in the setting at the bottom of the rectangle;
  - Customer TIN (Tax Identification Number) cannot have repeated values;
  - In the contract the start date must be less than or equal to the end date;
  - In the invoice the payment deadline must be greater than the issue date by 20 days valor);
  - In Technical Assistance the start time must be less than the end time;
  - The client gender can only assume 3 values: F (female), M (male) or O (other);
  - The default value for membership date should be the current date;
  - A customer must be at least 18 years old on the day he signs up;

- Enter data in the tables below:
  - 11 customers:
    - A customer was born on February 3, 1980;
    - At least 2 customers live at Av. De Madrid Lote 45, on a floor of your choice;
    - One customer was born on 1980-02-12 (and only this);
  - 10 services: get inspired by telecom operators' services;
  - 10 support technicians;

- Using query statements demonstrate that the following restrictions are respected by the inserted rows:

  - We only have lines within the allowed genders;
  - No repeat TIFs inside customers (use only the commands you learned);
  - Customers are 18 years old or older;
  - Only one customer was born on 1980-02-12;
  - You insert 10 services and they are all different;
  - You insert 10 technicians and they are all different;
  - Change the birthdate of the customer who was born on February 3, 1980 to May 4, 1981.

  - Change the address of all customers who live on Avenida de Madrid Lote 45 to the same avenue, no 14, keeping the respective floors. For example, if the address was “Av. de Madrid Lote 45, 3oB”the address goes to“ Av. Madrid, no14, 3oB ”.
  - Remove the customer who was born on February 12, 1980;

  - Alter tables to implement relationships shown in diagram.

- Contrato: each customer has a contract;

- Serviço contratado:
  - All contracts have 2 contracted services and one of them has at least 3;
  - All services are requested by customers, except one service that no one has requested it;
  - The monthly cost of each contracted service is equal to the monthly reference cost of the respective service;
  
- Fatura (Invoice): all services have an invoice in October. Leave the field total invoice amount with zero;

- Detalhe de fatura (Invoice detail): each invoice has a detail line for the services contracted by the customer. The invoice detail value should be the same as the value of the respective service, except for two lines of your choice, which should be larger than the correlated service value;

- Assistência técnica (Technical assistance): insert 3 requests, that took 1, 3 and 5 hour;

- Show the customer's name and tax ID as well as the number of services contracted by each customer. One of the clients must have more than 2 services contracted;
- Show that there is a service that was not hired by any customer;
- Show that all contracted services were billed in October;
- Show how much each customer will pay in October;
- Show average, maximum and minimum time in technical assistance requests;
- Show which customers will pay for services in October above the monthly referral cost for this contract;

- The total payable on an invoice is the sum of its invoice details. Write a procedure that will be stored inside the DB and that, receiving a year and a month, updates the total value of all invoices issued in that year and month. The total value for each invoice is the sum of all its detail lines.











