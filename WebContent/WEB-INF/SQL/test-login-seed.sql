INSERT INTO users (email, password_hash, full_name)
SELECT 'pk@gmail.com', '12345', 'Test User'
WHERE NOT EXISTS (
    SELECT 1
    FROM users
    WHERE email = 'pk@gmail.com'
);

INSERT INTO users (email, password_hash, full_name)
SELECT 'al@gmail.com', '12345', 'Alex Laud'
WHERE NOT EXISTS (
    SELECT 1
    FROM users
    WHERE email = 'al@gmail.com'
);

INSERT INTO categories (name)
SELECT 'ROCK'
WHERE NOT EXISTS (
    SELECT 1
    FROM categories
    WHERE name = 'ROCK'
);

INSERT INTO cds (cd_id, title, artist, category_id, price, stock_quantity)
SELECT 12, 'Test Product 12', 'Test Artist', category_id, 16.00, 10
FROM categories
WHERE name = 'ROCK'
  AND NOT EXISTS (SELECT 1 FROM cds WHERE cd_id = 12);

INSERT INTO cds (cd_id, title, artist, category_id, price, stock_quantity)
SELECT 13, 'Test Product 13', 'Test Artist', category_id, 16.00, 10
FROM categories
WHERE name = 'ROCK'
  AND NOT EXISTS (SELECT 1 FROM cds WHERE cd_id = 13);
