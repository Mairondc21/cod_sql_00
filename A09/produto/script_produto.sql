-- Criação da tabela Produto
CREATE TABLE Produto (
    cod_prod INT PRIMARY KEY,
    descricao VARCHAR(50) UNIQUE,
    qtde_disponivel INT NOT NULL DEFAULT 0
);

-- Inserção de produtos
INSERT INTO Produto VALUES (1, 'Basica', 10);
INSERT INTO Produto VALUES (2, 'Dados', 5);
INSERT INTO Produto VALUES (3, 'Verao', 15);

-- Criação da tabela RegistroVendas
CREATE TABLE RegistroVendas (
    cod_venda SERIAL PRIMARY KEY,
    cod_prod INT,
    qtde_vendida INT,
    FOREIGN KEY (cod_prod) REFERENCES Produto(cod_prod) ON DELETE CASCADE
);