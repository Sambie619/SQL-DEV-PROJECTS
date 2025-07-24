
 -- 1.Define schema: Movies, Ratings, Users, Reviews.
 CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE movies (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    genres VARCHAR(255)
);

CREATE TABLE ratings (
    user_id INTEGER REFERENCES users(id),
    movie_id INTEGER REFERENCES movies(id),
    rating FLOAT NOT NULL,
    rating_date DATE,
    PRIMARY KEY (user_id, movie_id)
);

CREATE TABLE reviews (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    movie_id INTEGER REFERENCES movies(id),
    review_text TEXT,
    review_date DATE
);
-- 2.Insert sample IMDb-style data.
--inserting  26 sample  users

INSERT INTO users (username) VALUES ('alice'), ('bob'), ('carol'),('Dan'),('Eli'),('Faza'),('Greg'),('Ham'),('Ian'),('Jack'),('Kim'),('Liz'),('Mo'),('Neil'),('Om'),
('pete'),('Qureshi'),('Roy'),('Sabin'),('Tina'),('Umm'),('Vasu'),('wilson'),('xerxes'),('Yom'),('Zebron');


INSERT INTO movies (title, genres) VALUES
('Titanic', 'Romance,Drama'),
('The Godfather', 'Crime,Drama'),
('Toy Story', 'Animation,Comedy'),
('The Matrix','Action'),
('12 Angry Men','Drama'),
('Dictator','Comedy'),
('The Exorcist','Horror'),
('The Shining','Horror'),
('Harry Potter series','Fantasy'),
('Interstellar','Adventure, Drama, Sci-Fi'),
('Inception','Action, Adventure,Sci-Fi'),
('Blade Runner','Sci-Fi'),
('Seven','Thriller,Crime'),
('Spirited Away','Animated'),
('La La Land','Musical'),
('The Sixth Sense','Thriller'),
('Shrek','Family'),
('The Dark Knight','Superhero, Crime, Thriller'),
('Gladiator','Historical Drama, Action'),
('Pirates of the Caribbean: The Curse of the Black Pearl','Adventure, Fantasy'),
('The Notebook','Romantic Drama'),
('The Shawshank Redemption','Drama'),
('Forrest Gump','Drama, Romance'),
('Fight Club','Drama'),
('Gladiator',' Action, Adventure, Drama'),
('Schindlers List','Biography, Drama, History'),
('Parasite','Comedy, Drama, Thriller'),
('The Prestige',' Drama, Mystery, Sci-Fi'),
('The Departed','Crime, Drama, Thriller'),
('Avengers: Endgame','Action, Adventure, Drama'),
('Joker (2019)','Crime, Drama, Thriller'),
('The Pianist','Biography, Drama, Music'),
('WALL·E','Animation, Adventure, Family'),
('The Intouchables','Biography, Comedy, Drama'),
('The Wolf of Wall Street','Biography, Crime, Drama'),
('The Lion King (1994)','Animation, Adventure, Drama'),
('Life Is Beautiful','Comedy, Drama, Romance'),
('The Truman Show','Comedy, Drama, Sci-Fi'),
('Shutter Island','Mystery, Thriller'),
('Oldboy (2003)','Action, Drama, Mystery'),
('Inside Out','Animation, Adventure, Comedy'),
('The Revenant','Action, Adventure, Drama'),
('Blade Runner 2049','Action, Drama, Sci-Fi'),
('The Grand Budapest Hotel','Adventure, Comedy, Crime');

--viewing movies table 
select * from movies;

--inserting into ratings
INSERT INTO ratings (user_id, movie_id, rating, rating_date) VALUES
(1, 1, 4.5, '2025-07-01'),
(1, 2, 4.0, '2025-07-02'),
(2, 3, 5.0, '2025-07-03'),
(2, 4, 3.5, '2025-07-03'),
(3, 5, 4.7, '2025-07-04'),
(3, 6, 4.0, '2025-07-04'),
(4, 7, 2.8, '2025-07-05'),
(4, 8, 4.1, '2025-07-05'),
(5, 9, 3.9, '2025-07-06'),
(5, 10, 5.0, '2025-07-06'),
(6, 11, 4.8, '2025-07-07'),
(6, 12, 3.9, '2025-07-07'),
(7, 13, 4.3, '2025-07-08'),
(7, 14, 4.0, '2025-07-08'),
(8, 15, 3.5, '2025-07-09'),
(8, 16, 4.2, '2025-07-09'),
(9, 17, 4.7, '2025-07-10'),
(9, 18, 5.0, '2025-07-10'),
(10, 19, 3.8, '2025-07-11'),
(10, 20, 4.1, '2025-07-11'),
(11, 21, 4.6, '2025-07-12'),
(11, 22, 5.0, '2025-07-12'),
(12, 23, 4.2, '2025-07-13'),
(12, 24, 4.0, '2025-07-13'),
(13, 25, 4.9, '2025-07-14'),
(13, 26, 5.0, '2025-07-14'),
(14, 27, 4.3, '2025-07-15'),
(14, 28, 4.8, '2025-07-15'),
(15, 29, 3.6, '2025-07-16'),
(15, 30, 4.4, '2025-07-16'),
(16, 31, 4.1, '2025-07-17'),
(16, 32, 4.0, '2025-07-17'),
(17, 33, 4.9, '2025-07-18'),
(17, 34, 4.5, '2025-07-18'),
(18, 35, 4.0, '2025-07-19'),
(18, 36, 4.3, '2025-07-19'),
(19, 37, 4.6, '2025-07-20'),
(19, 38, 3.7, '2025-07-20'),
(20, 39, 4.8, '2025-07-21'),
(20, 40, 3.5, '2025-07-21'),
(21, 41, 4.2, '2025-07-22'),
(21, 42, 4.6, '2025-07-22'),
(22, 43, 3.9, '2025-07-23'),
(22, 44, 4.4, '2025-07-23'),
(23, 45, 4.7, '2025-07-24'),
(24, 46, 3.6, '2025-07-25'),
(25, 47, 4.5, '2025-07-26');


--inserting reviews
INSERT INTO reviews (user_id, movie_id, review_text, review_date) VALUES
(1, 1, 'A timeless romantic tragedy. Truly touching.', '2025-07-01'),
(1, 2, 'Masterful storytelling and acting. A classic.', '2025-07-02'),
(2, 3, 'A heartwarming and fun animated journey.', '2025-07-03'),
(2, 4, 'A genre-defining sci-fi movie.', '2025-07-03'),
(3, 5, 'One of the best courtroom dramas ever made.', '2025-07-04'),
(3, 6, 'Funny and sharp political satire.', '2025-07-04'),
(4, 7, 'Absolutely terrifying. A horror classic.', '2025-07-05'),
(4, 8, 'Creepy and disturbing in the best way.', '2025-07-05'),
(5, 9, 'Magical and full of adventure.', '2025-07-06'),
(5, 10, 'A breathtaking journey through space and time.', '2025-07-06'),
(6, 11, 'Inception-level brilliance. Visually stunning.', '2025-07-07'),
(6, 12, 'Ahead of its time. Loved the dystopian feel.', '2025-07-07'),
(7, 13, 'Dark, twisted, and absolutely gripping.', '2025-07-08'),
(7, 14, 'A beautiful animated fantasy.', '2025-07-08'),
(8, 15, 'Stylish and emotional. Music is amazing.', '2025-07-09'),
(8, 16, 'Chilling and brilliantly directed.', '2025-07-09'),
(9, 17, 'Fun for all ages. Shrek is love!', '2025-07-10'),
(9, 18, 'Best superhero film of all time.', '2025-07-10'),
(10, 19, 'Epic battles and strong story. Gladiator is a legend.', '2025-07-11'),
(10, 20, 'Pirates + adventure = pure entertainment.', '2025-07-11'),
(11, 21, 'A tearjerker. Beautiful story.', '2025-07-12'),
(11, 22, 'Powerful prison drama with hope at its core.', '2025-07-12'),
(12, 23, 'Inspiring and full of heart.', '2025-07-13'),
(12, 24, 'A mind-bending masterpiece.', '2025-07-13'),
(13, 25, 'Dark and deep. Not for everyone, but brilliant.', '2025-07-14'),
(13, 26, 'A haunting depiction of the Holocaust.', '2025-07-14'),
(14, 27, 'Social class divide shown powerfully.', '2025-07-15'),
(14, 28, 'Amazing twist. Nolan is a genius.', '2025-07-15'),
(15, 29, 'A thrilling end to the Avengers saga.', '2025-07-16'),
(15, 30, 'A dark and emotional portrayal of Joker.', '2025-07-16'),
(16, 31, 'Emotional and beautifully shot.', '2025-07-17'),
(16, 32, 'So pure and charming. Great for families.', '2025-07-17'),
(17, 33, 'A film that warms your heart.', '2025-07-18'),
(17, 34, 'Wild and outrageous. Scorsese brilliance.', '2025-07-18'),
(18, 35, 'An animated masterpiece for all generations.', '2025-07-19'),
(18, 36, 'Emotional, funny, and heartbreaking.', '2025-07-19'),
(19, 37, 'Very clever and ahead of its time.', '2025-07-20'),
(19, 38, 'A gripping psychological thriller.', '2025-07-20'),
(20, 39, 'One of the most intense thrillers ever.', '2025-07-21'),
(20, 40, 'Visually epic and emotional journey.', '2025-07-21'),
(21, 41, 'Creative and colorful. Pixar magic again.', '2025-07-22'),
(21, 42, 'Bleak, cold, and powerful survival story.', '2025-07-22'),
(22, 43, 'Visually stunning and deeply artistic.', '2025-07-23'),
(22, 44, 'Unique Wes Anderson charm.', '2025-07-23'),
(23, 45, 'Hilarious and beautifully filmed.', '2025-07-24'),
(24, 46, 'Raw, gritty, and well-acted.', '2025-07-25'),
(25, 47, 'Beautifully designed and quirky storyline.', '2025-07-26');



--3.Write average rating and ranking queries.
--Average Rating for Each Movie:

SELECT m.id, m.title,
       ROUND(AVG(r.rating)::numeric, 2) AS avg_rating,
       COUNT(r.rating) AS num_ratings
FROM movies m
LEFT JOIN ratings r ON m.id = r.movie_id
GROUP BY m.id, m.title
ORDER BY avg_rating DESC NULLS LAST;
--rank movies by avg rating
SELECT m.id, m.title, avg_rating, RANK() OVER (ORDER BY avg_rating DESC) AS rank
FROM (
    SELECT m.id, m.title, AVG(r.rating) AS avg_rating
    FROM movies m
    LEFT JOIN ratings r ON m.id = r.movie_id
    GROUP BY m.id, m.title
) m;


-- 4.Create views for recommended movies.
CREATE VIEW recommended_movies AS
SELECT
    m.id,
    m.title,
    ROUND(AVG(r.rating)::numeric, 2) AS avg_rating,
    COUNT(r.rating) AS num_ratings
FROM movies m
LEFT JOIN ratings r ON m.id = r.movie_id
GROUP BY m.id, m.title
HAVING COUNT(r.rating) > 0
ORDER BY avg_rating DESC
LIMIT 10;

SELECT * FROM recommended_movies;

--5.Use window functions to track top-rated content.
--say Top 3 Movies Per Genre:

WITH avg_ratings AS (
    SELECT m.id, m.title, m.genres, AVG(r.rating) AS avg_rating
    FROM movies m
    LEFT JOIN ratings r ON m.id = r.movie_id
    GROUP BY m.id, m.title, m.genres
),
ranked AS (
    SELECT
        id,
        title,
        split_part(genres, ',', 1) AS primary_genre,
        avg_rating,
        RANK() OVER (PARTITION BY split_part(genres, ',', 1) ORDER BY avg_rating DESC) AS genre_rank
    FROM avg_ratings
    WHERE avg_rating IS NOT NULL
)
SELECT *
FROM ranked
WHERE genre_rank <= 3;
















