-- Active: 1729274900293@@127.0.0.1@5432@itau
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
DROP TABLE clients;
CREATE TABLE IF NOT EXISTS clients (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    saldo INTEGER NOT NULL,
    limite INTEGER NOT NULL,
    CHECK (saldo >= -limite),
    CHECK (limite > 0)
);

INSERT INTO clients(saldo,limite)
VALUES
    (0,10000),
    (0,80000),
    (0, 1000000),
    (0, 10000000),
    (0, 500000);
   
CREATE TABLE IF NOT EXISTS transactions(
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tipo CHAR(1),
    descricao VARCHAR(10) NOT NULL,
    valor INTEGER NOT NULL,
    cliente_id UUID NOT NULL,
    realizada_em TIMESTAMP NOT NULL DEFAULT NOW()
);

INSERT INTO transactions (tipo, descricao, valor,cliente_id)
VALUES ('d','amarelo',80000,'e42de750-24e1-4ed2-b106-62857a9a2106');

UPDATE clients
SET saldo = saldo + 80000
WHERE id = 'e42de750-24e1-4ed2-b106-62857a9a2106';

SELECT *
FROM transactions;



