DROP TABLE IF EXISTS "user";
CREATE TABLE "user"(
    user_id SERIAL PRIMARY KEY,
    username varchar(100),
    password TEXT,
    email varchar(100),
    first_name varchar(50),
    last_name varchar(50),
    phone TEXT,
    gender varchar(20),
    age INT
)