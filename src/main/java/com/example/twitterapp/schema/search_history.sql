CREATE TABLE "search_history"(
     search_id SERIAL PRIMARY KEY,
     user_id int,
     port varchar(20),
     search_term TEXT,
     FOREIGN KEY(user_id)
     REFERENCES "user"(user_id)
)