CREATE OR REPLACE FUNCTION verifica_estoque() 
RETURNS TRIGGER AS $$
DECLARE
    qted_atual INTEGER;
BEGIN
    SELECT qtde_disponivel INTO qted_atual
    FROM Produto WHERE cod_prod = NEW.cod_prod;
    IF qted_atual < NEW.qtde_vendida THEN
        RAISE EXCEPTION 'Quantidade indisponivel em estoque';
    ELSE
        UPDATE Produto SET qtde_disponivel = qtde_disponivel - NEW.qtde_vendida
        WHERE cod_prod = NEW.cod_prod;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tgr_registro_vendas
BEFORE INSERT ON registrovendas
FOR EACH ROW
EXECUTE FUNCTION verifica_estoque();

SELECT * 
FROM produto;

INSERT INTO registrovendas (cod_prod, qtde_vendida)
VALUES (3,5)