CREATE TABLE "symbol"(
     id SERIAL PRIMARY KEY,
     cik varchar(255),
	 address varchar(255),
	 country varchar(255),
	 description TEXT,
     exchange varchar(255),
	 industry varchar(255),
	 name varchar(255),
	 sector varchar (255),
	 symbol varchar(255)
);