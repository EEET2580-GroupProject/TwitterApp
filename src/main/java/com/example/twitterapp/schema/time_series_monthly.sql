CREATE TABLE "time_series_monthly"(
     id SERIAL PRIMARY KEY,
     close varchar(255),
	 high varchar(255),
	 low varchar(255),
	 month varchar(255),
     open varchar(255),
	 volume varchar(255),
	 year varchar(255),
	 symbol_id bigint,
	 FOREIGN KEY(symbol_id)
     REFERENCES "symbol"(id)
);