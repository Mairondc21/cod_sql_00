-- Active: 1729274900293@@127.0.0.1@5432@itau
CREATE OR REPLACE PROCEDURE realizar_transacao(
    IN p_tipo CHAR(1),
    IN p_descricao VARCHAR(10),
    IN p_valor INTEGER,
    IN p_cliente_id UUID
)
LANGUAGE plpgsql

AS $$
DECLARE 
    saldo_atual INTEGER;
    limite_cliente INTEGER;
    saldo_apos_transacao INTEGER;
BEGIN
    SELECT saldo, limite INTO saldo_atual, limite_cliente
    FROM clients
    WHERE id = p_cliente_id;

    RAISE NOTICE 'Saldo atual do cliente % ', saldo_atual;
    RAISE NOTICE 'Limite atual do cliente % ', limite_cliente;

    IF p_tipo = 'd' AND saldo_atual - p_valor < -limite_cliente THEN
        RAISE EXCEPTION 'Limite inferior ao necessario da trasação';
    END IF; 

    UPDATE clients
    SET saldo = saldo + CASE WHEN p_tipo = 'd' THEN p_valor ELSE -p_valor END
    WHERE id = p_cliente_id;

    INSERT INTO transactions (tipo, descricao, valor, cliente_id)
    VALUES(p_tipo, p_descricao, p_valor, p_cliente_id);

    SELECT saldo, limite INTO saldo_apos_transacao, limite_cliente
    FROM clients
    WHERE id = p_cliente_id;

    RAISE NOTICE 'Saldo atual do cliente apos a transacao % ', saldo_apos_transacao;
END;
$$;

CALL realizar_transacao ('d', 'amarelo',80 ,'e125f2b0-cb45-4bb5-86e1-8c250403503e');
SELECT *
FROM clients