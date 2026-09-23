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

# Having - Quais categorias possuem preço médio mairo que 500
SELECT id_categoria, round(avg(preco),2)
AS 'Preço Médio'
FROM produto
GROUP BY id_categoria
HAVING avg (preco) > 500;

# Inner Join
SELECT p.nome
AS "Produto", c.nome AS "Categoria", p.preco AS "Valor"
FROM produto p
INNER JOIN categoria c 
ON p.id_categoria = c.id_categoria;

# Group by + inner join - Quantos produtos exisstem em cada categoria
SELECT c.nome
AS "Categoria",
count(p.id_produto) as 'Quantidade'
FROM categoria c
INNER JOIN produto p
ON c.id_categoria = p.id_categoria
GROUP BY c.nome;

# LEFT JOIN
SELECT c.nome
AS "Categoria",
p.nome AS "Produto"
FROM categoria c
LEFT JOIN produto p
ON c.id_categoria = p.id_categoria;

# Quais clientes estão cadastrados mas nunca compraram?
SELECT c.nome
AS "Cliente"
FROM cliente c
LEFT JOIN pedido p
ON c.id_cliente = p.id_cliente
WHERE p.id_pedido
IS NULL;

# Quem comprou e em qual pedido comprou?
SELECT c.nome
AS "Cliente";

# Subconsultas
SELECT nome, preco
FROM produto
WHERE preco > (SELECT avg(preco) FROM produto);

/* Nesse exemplo, a subconsulta calcula o preço médio e a consulta externa retorna os produtos acima dessa média.*/

# Subconsultas com listas e existência
# Quando a subconsulta retorna vários valores, usam-se os operadores
# IN, EXISTS, ANY e ALL. O IN verifica se um valor pertence ao conjunto retornado.
# O EXISTS testa apenas se a subconsulta produz alguma linha, sendo bastante eficiente
# para verificar existência. O exemplo busca clientes que fizeram ao menos um pedido

SELECT nome
FROM cliente c
WHERE EXISTS
(SELECT 1 FROM pedido p WHERE p.id_cliente = c.id_cliente);

# Subconsulta no FROM e no SELECT
# A subconsulta também pode aparecer na clausula FROM,
# funcionando como uma tabela temporária, ou na lista de colunas do SELECT,
# retornando um valor único por linha. O exemploa seguir mostra cada 
# categoria ao lado da quantidade de produtos, calculada por uma subconsulta no SELECT

SELECT c.nome,
(SELECT count(*) FROM produto p
WHERE p.id_categoria = c.id_categoria)
AS "Quantidade de produtos"
FROM categoria c;

# Organizando com CTEs e combinando com UNION
# Consultas longas tornam-se dificeis de ler quando muitas subconsultas se aninham,
# A common Table Expression (CTE), introduzida pela clausula WITH, da nome a um resultado
# intermediario e melhora a clareza. Ela é especialmente util quando o mesmo subresultado
# é referneciado mais de uma vez.

WITH faturamento_cliente
AS
(SELECT p.id_cliente,
sum(ip.quantidade * ip.preco_unitario)
AS "Total"
FROM pedido p
JOIN item_pedido ip
ON p.id_pedido = ip.id_pedido
GROUP BY p.id_cliente)
SELECT c.nome, f.total
FROM faturamento_cliente f
JOIN cliente c
ON c.id_cliente = f.id_cliente
WHERE f.total > 500;

# Funções internas
# Os SGBDs oferecem um conjunto amplo de funções internas que
# processam valores durante a consulta. As funções de texto manipulam
# cadeias de caracteres. CONCAT junta Strings, UPPER e LOWER alteram a caixa,
# SUBSTRING extrai um trecho, LENGTH mede o comprimento e TRIM remove espaços nas extremidades

SELECT concat(nome, ' (', cidade, ')')
AS "Identificação",
upper(cidade) AS "Cidade em Maiusculo"
FROM cliente;

# Função Interna de tempo
# As funções de data permitem extrair e calcular informações temporais.
# NOW retorna o instante atual, DATEDIFF calcula a diferença entre datas
# e funções de formatação ajustam a exibição. O exemplo apura há quantos
# dias cada cliente está cadastrado.

SELECT nome, datediff(current_date, data_cadastro)
AS "Dias de Cadastro"
FROM cliente;

# Funções númericas e condicionais
# As funções numéricas arredondam e ajustam valores
# ROUND arredonda, FLOOR e CEIL aproximam para baixo e para cima.
# Já as funções condicionais decidem o valor de saida conforme uma regra.
# O comando CASE funciona como uma estrutura de decisão dentor da consulta,
# e COALESCE substitui valores nulos por uma alternativa

#Gatilhos (Triggers)
# O que é um gatilho?
# Um gatilho, ou trigger, é um bloco de código que o SGBD executa automatcamente
# quando ocorre um evento em uma tabela, como uma inserção, uma atualização ou uma exclusão,
# Diferente do procedimento, que precisa ser chamado, o gatilho dispara sozinho.
# Isso o torna ideal para tarefas que devem acontecer sem depender da aplicação
# como registrar ou validar uma regra.

delimiter $$
CREATE TRIGGER tg_valida_preco
BEFORE INSERT ON produto
FOR EACH ROW
BEGIN
	IF NEW.preco < 0 then
    SIGNAL SQLSTATE '45000'
    SET message_text = "Preço não pode ser negativo";
    END IF;
END$$
delimiter ;

INSERT INTO produto (nome, preco, estoque, id_categoria) VALUES
("Apagador Quadro Branco", "3.00", 30, 2);

# Os gatilhos são classificados pelo momento e pelo evento
# Quanto ao momento, podem ser BEFORE, executados antes da operação,
# ou AFTER, executados depois. Quanto ao evento, respondem a INSERT,
# UPDATE ou DELETE. Dentro do gatilho, as referências NEW e OLD dão
# acesso aos valores novos e antigos da linha afetada

# Criar uma tabela de Log para auditoria
CREATE TABLE log_preco(
id_log int PRIMARY KEY AUTO_INCREMENT,
id_produto int,
preco_antigo Decimal(10,2),
preco_novo Decimal(10,2),
alterado_em DATETIME DEFAULT current_timestamp
);

delimiter $$
CREATE TRIGGER tg_log_preco
AFTER UPDATE ON produto
FOR EACH ROW
BEGIN
	IF old.preco <> new.preco THEN
		INSERT INTO log_preco(id_produto, preco_antigo, preco_novo)
        VALUES (old.id_produto, old.preco, new.preco);
	END IF;
END $$
delimiter ;

UPDATE produto SET preco = 14.00 WHERE id_produto = 20;

SELECT * FROM produto WHERE id_produto = 1;
SELECT * FROM pedido WHERE id_cliente = 1;

# Transação (transaction)
START TRANSACTION; #inicia uma transação
UPDATE produto SET estoque = estoque -2 WHERE id_produto = 1;
INSERT INTO pedido (id_cliente, data_pedido) VALUES (1, '2026-03-20');
commit;
rollback;

SELECT
pedido.id_pedido AS "ID",
produto.nome AS "Produto",
cliente.nome AS "Nome Cliente"
FROM item_pedido
JOIN produto ON produto.id_produto = item_pedido.id_produto
JOIN pedido ON pedido.id_pedido = item_pedido.id_pedido
JOIN cliente ON cliente.id_cliente = pedido.id_cliente;

CREATE INDEX idx_nomeProd ON produto(nome);