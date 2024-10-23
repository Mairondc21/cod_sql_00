-- Active: 1729274900293@@127.0.0.1@5432@trigger@public
CREATE OR REPLACE FUNCTION registrar_auditoria_salario()
RETURNS TRIGGER
AS $$
BEGIN

    INSERT INTO funcionario_auditoria (id, salario_antigo, novo_salario)
    VALUES (OLD.id, OLD.salario, NEW.salario);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tgr_salario_modificado
AFTER UPDATE OF salario ON funcionario
FOR EACH ROW
EXECUTE FUNCTION registrar_auditoria_salario();

SELECT *
FROM funcionario_auditoria;

UPDATE funcionario
SET salario = 4300.00
WHERE nome = 'Ana'