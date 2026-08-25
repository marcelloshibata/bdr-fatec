CREATE DATABASE loja_aula;

USE loja_aula;

CREATE TABLE categoria (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT,
    id_categoria INT,

    FOREIGN KEY (id_categoria)
        REFERENCES categoria(id_categoria)
);

CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cidade VARCHAR(50),
    data_cadastro DATE
);

CREATE TABLE pedido (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    data_pedido DATE,
    id_cliente INT,

    FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
);

CREATE TABLE item_pedido (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT,
    id_produto INT,
    quantidade INT,
    preco_unitario DECIMAL(10,2),
    FOREIGN KEY (id_pedido)
        REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_produto)
        REFERENCES produto(id_produto)
);

/*INSERINDO DADOS*/

INSERT INTO categoria (nome) VALUES
('Informática'),
('Acessórios'),
('Escritório'),
('Games'),
('Celulares'),
('Eletrônicos');

INSERT INTO produto (nome, preco, estoque, id_categoria) VALUES
('Notebook Lenovo', 3500.00, 10, 1),
('Mouse Logitech', 120.00, 30, 2),
('Teclado Mecânico', 280.00, 20, 2),
('Monitor 24', 950.00, 15, 1),
('Cadeira Gamer', 1250.00, 8, 4),
('Mouse Pad', 45.00, 50, 2),
('Caneta Azul', 3.50, 100, 3),
('Caderno Executivo', 35.00, 40, 3),
('Smartphone Samsung', 2200.00, 12, 5),
('Controle Gamer', 350.00, 25, 4);

INSERT INTO produto (nome, preco, estoque, id_categoria) VALUES
('Notebook Lenovo', 3500.00, 10, 1),
('Mouse Logitech', 120.00, 30, 2),
('Teclado Mecânico', 280.00, 20, 2),
('Monitor 24', 950.00, 15, 1),
('Cadeira Gamer', 1250.00, 8, 4),
('Mouse Pad', 45.00, 50, 2),
('Caneta Azul', 3.50, 100, 3),
('Caderno Executivo', 35.00, 40, 3),
('Smartphone Samsung', 2200.00, 12, 5),
('Controle Gamer', 350.00, 25, 4);

INSERT INTO cliente (nome, cidade, data_cadastro) VALUES
('Ana Silva', 'São Paulo', '2025-02-10'),
('Bruno Costa', 'Campinas', '2025-04-15'),
('Carlos Oliveira', 'Registro', '2025-05-20'),
('Amanda Souza', 'São Paulo', '2025-07-01'),
('Mariana Santos', 'Santos', '2024-11-25'),
('Pedro Lima', 'Campinas', '2026-01-10');

INSERT INTO pedido (data_pedido, id_cliente) VALUES
('2026-08-01', 1),
('2026-08-02', 2),
('2026-08-03', 1),
('2026-08-04', 3),
('2026-08-05', 4),
('2026-08-06', 5);

INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(1, 1, 1, 3500.00),
(1, 2, 2, 120.00),
(2, 3, 1, 280.00),
(2, 6, 3, 45.00),
(3, 4, 2, 950.00),
(3, 2, 1, 120.00),
(4, 7, 10, 3.50),
(4, 8, 3, 35.00),
(5, 5, 1, 1250.00),
(5, 10, 2, 350.00),
(6, 9, 1, 2200.00),
(6, 6, 2, 45.00);

# CONSULTAS NO BANCO DE DADOS

-- Listagem de produtos
SELECT * FROM produto;

# Listagem com campos especificos
SELECT nome, preco FROM produto;

# Listagem com condição - O gerente quer descobrir os produtos que custam mais de R$ 500.00
SELECT nome, preco
FROM produto
WHERE preco > 500;

# Order by - Ordenação dos dados decrescente
SELECT nome, preco
FROM produto
WHERE preco>500
ORDER BY preco desc;

# Order by - Ordenação dos dados crescente (ascendente)
SELECT nome, preco
FROM produto
WHERE preco > 500
ORDER BY preco asc;
# ou (por padrão, o SQL já ordena crescentemente)
SELECT nome, preco
FROM produto
WHERE preco > 500
ORDER BY preco;

# Between - quais os produtos custam entre 100 e 1000
SELECT nome, preco
FROM produto
WHERE preco
BETWEEN 100 AND 1000
ORDER BY preco;

# IN - A empresa realizará uma campanha somente em São Paulo e Campinas, quais clientes pertencem a essas cidades
SELECT nome, cidade
FROM cliente
WHERE cidade
IN ('São Paulo', 'Campinas');

# Usando OR
SELECT nome, cidade
FROM cliente
WHERE cidade = 'São Paulo' or
cidade = 'Campinas';

# Like
SELECT nome
FROM cliente
WHERE nome
LIKE "a%";

SELECT nome
FROM cliente
WHERE nome
LIKE "%silva%";

# Combinando filtros
# Precisamos encontrar clientes de São Paulo ou Campinas cujo o nome comece com a letra A
SELECT nome, cidade
FROM cliente
WHERE cidade
IN ('São Paulo', 'Campinas')
AND nome
LIKE "a%";

# Count - Quantos produtos existem na loja?
SELECT count(*)
AS total_produtos
FROM produto;

# Apelido de campo - Todo campo ao ser utilizado as apelido_campo receb um apelido de referência ao campo,
# mudando assim o título da coluna da tabela resultado temporariamente
SELECT count(nome)
FROM produto;

SELECT count(*)
AS "Total de Produtos"
FROM produto;

# AVG - Qual é o preço médio dos produtos?
SELECT avg(preco)
AS "Valor médio de preço dos Produtos"
FROM produto;

# Preço médio de categoria específica
SELECT avg(preco)
AS "Valor médio"
FROM produto
WHERE id_categoria = 1;

# Arredondar casas decimais
SELECT round(avg(preco), 2)
AS "Valor médio"
FROM produto;

# Min e Max - Qual é o produto mais caro e o mais barato
SELECT min(preco)
AS "Menor Preço",
max(preco)
AS "Maior Preço"
FROM produto;

# Varias funções de agregação
SELECT count(*)
AS 'Quantidade de Produtos',
round(avg(preco), 2)
AS 'Preço Médio',
min(preco) AS 'Menor Preço',
max(preco) AS 'Maior Preço'
FROM produto;

# SUM - Qual o valor fincanceiro do estoque da loja
SELECT sum(preco)
AS "Total aproximado Estoque"
FROM produto;

SELECT sum(preco * estoque)
AS "Total do Estoque"
FROM produto;

# Agrupamento de valores - group by()
SELECT id_categoria,
round(avg(preco),2)
AS "Preço Médio"
FROM produto
GROUP BY id_categoria;

# Trazendo o nome da categoria ^
SELECT produto.id_categoria,
categoria.nome AS "categoria",
round(avg(preco),2)
AS "Preço médio"
FROM produto
INNER JOIN categoria
ON categoria.id_categoria = produto.id_categoria
GROUP BY produto.id_categoria
ORDER BY produto.id_categoria;
