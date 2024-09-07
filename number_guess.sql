CREATE DATABASE number_guess;

CREATE TABLE users(user_id SERIAL PRIMARY KEY, name VARCHAR(22) NOT NULL, games_played INT NOT NULL, best_game INT );

