#criar banco de dados

create database if not exists loja_virtual;
/* Apontar o banco de dados a ser manipulado */
use loja_virtual;

#Criar Tabelas do banco de dados
create table if not exists cliente 
(
id_cliente int primary key auto_increment,
nome varchar(100) not null,
email varchar(150) not null unique,
cidade varchar(60),
data_cadastro date default (current_date())
);

/*
O ponto de partida de qualquer projeto é a criação do banco e de suas tabelas. Cada coluna recebe um tipo de dado que define o que ela pode armazenar.
Tipos numéricos como INT e DECIMAL guardam números, VARCHAR guarda texto de tamanho variável, e DATE armazena datas.
A escolha correta do tipo evita desperdício de espaço e previne o registro de valores inválidos
*/

/*
not null -> Vai garantir que o campo seja obrigatório e deverá ser preenchido, não podendo ficar vazio ou nulo.
*/

/*
Unique -> Vai garantir que a informação de um determinado campo seja unica no banco de dados, não sendo possível duplicidade da informação.
*/

/*
Default -> Determina o preenchimento padrão do campo mesmo que não seja informado. 
*/

/*
Current_date() -> Puxa a data atual do sistema sem a necessidade do preenchimento do campo.
*/

create table if not exists categoria
(
id_categoria int primary key auto_increment,
nome varchar(60) not null
);

create table if not exists produto
(
id_produto int primary key auto_increment,
nome varchar(120) not null,
preco decimal(10,2) not null check (preco >=0),
estoque int not null default 0,
id_categoria int,
foreign key(id_categoria) references categoria (id_categoria)
);

create table if not exists pedido
(
id_pedido int primary key auto_increment,
id_cliente int not null,
data_pedido datetime default current_timestamp,
status varchar(20) default "aberto",
foreign key (id_cliente) references cliente (id_cliente)
);

create table if not exists item_pedido
(
id_pedido int,
id_produto int,
quantidade int not null check (quantidade >0),
preco_unitario decimal (10,2) not null,
primary key (id_pedido, id_produto),
foreign key (id_pedido) references pedido(id_pedido) on delete cascade,
foreign key (id_produto) references produto(id_produto)
);

/*
A tabela item_pedido usa uma chave primária composta, formada por id_pedido e id_produto juntos,
porque um item só faz sentido na combinação dos dois. A cláusula ON DELETE CASCADE determina que, ao excluir um pedido,
seus itens sejam removidos automaticamente, evitando registrios órfãos.
*/

/* Alterando a estrutura da tabela já existente */

alter table cliente add column telefone varchar(20);

#adicionar validação no campo da tabela
alter table produto add constraint chk_estoque check(estoque>=0);

#Remover Coluna de uma tabela
alter table cliente drop column telefone;

#inserção de dados na tabela
insert into categoria (nome) values("perifericos"),("Mobiliário");

insert into cliente (nome, email, cidade) values
("Ana Silva", "ana@email.com", "São Paulo");

insert into produto (nome, preco, estoque, id_categoria) values
('Teclado Mecânico', 250.00, 15, 1),
('Mouse sem fio', 90.00, 40, 1),
('Cadeira Gamer', 899.00, 8, 2);
 
#Atualizar o valor de um dado no campo já inserido
update produto set preco = 239.90 where id_produto = 1;

#Excluir registros especificos
delete from produto where estoque = 0;

# Consulta básica
select nome, preco from produto where preco > 100;

# Consulta básica sem condição
select nome, preco from produto;

#Consulta básica todos os campos sem condional
select * from produto;

#Consulta básica todos os campos com condicional
select * from produto where preco > 100;

SELECT nome, cidade
FROM cliente
WHERE cidade IN ('São Paulo', 'Campinas')
AND nome LIKE 'A%' AND
data_cadastro BETWEEN '2026-01-01' AND '2026-12-31';

insert into cliente (nome, email, cidade) values
('Gustavo Marcondes', 'gu.M@email.com', 'São Paulo'),
('João Victor Toth', 'jut@mail.com', 'Campinas'),
('Alice Silva', 'alice.silva@outlook.com', 'Campinas'),
('Isis Marcondes', 'isis.marc@email.com', 'Cajati'),
('Iury Guedes', 'iury.guedes@gmail.com', 'Registro');

select * from cliente;

# Retornar o nome, cidade, email dos clientes que possuem email @outlook
SELECT nome, cidade, email
FROM cliente
WHERE email LIKE '%outlook%';

# Retornar produtos que tenham preco entre 50,00 a 300,00
SELECT *
FROM produto
WHERE preco BETWEEN 50.00 AND 300.00;