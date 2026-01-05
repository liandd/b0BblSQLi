CREATE TABLE users(
  id INTEGER,
  username VARCHAR(100),
  password VARCHAR(100)
);
INSERT INTO users(
  id,
  username,
  password
)VALUES(
  1,
  'albert',
  'einstein123123'
);
INSERT INTO users(
  id,
  username,
  password
)VALUES(
  2,
  'isaac',
  'newtonN0onoN3w'
);
INSERT INTO users(
  id,
  username,
  password
)VALUES(
  3,
  'john',
  'johndoeqwerty123'
);
SELECT * FROM users;
