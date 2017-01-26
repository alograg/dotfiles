CREATE USER 'apacktest' identified by 'apackTest1';
GRANT ALL PRIVILEGES ON apack_test.* TO 'apacktest';
CREATE USER 'oramalocal' identified by 'oramaLocal1';
GRANT ALL PRIVILEGES ON oramaCustomers.* TO 'oramalocal';
FLUSH PRIVILEGES;