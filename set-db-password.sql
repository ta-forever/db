USE mysql;

UPDATE user 
SET authentication_string = PASSWORD('banana')
WHERE
(user = 'root' AND host = '%') or
(user = 'faf-anope' AND host = '%') or
(user = 'faf-java-api' AND host = '%') or
(user = 'faf-policy-server' AND host = '%') or
(user = 'faf-mautic' AND host = '%') or
(user = 'faf-policy-server' AND host = '%') or
(user = 'faf-postal' AND host = '%') or
(user = 'faf-python-server' AND host = '%') or
(user = 'faf-wordpress' AND host = '%');


FLUSH PRIVILEGES;