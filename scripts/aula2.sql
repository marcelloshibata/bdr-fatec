# Criar Banco de Dados
create database if not exists loja_virtual;

/* Apontar o banco de dados
 a ser manipulado*/
 use loja_virtual;
 
 # Criar tabelas do banco de dados
 create table if not exists cliente(
 id_cliente int primary key auto_increment,
 nome varchar(100) not null,
 email varchar(150) not null unique,
 cidade varchar(60),
 data_cadastro Date default (current_date())
 );
 
/* O ponto de partida de qualquer projeto é a criação do banco
e de suas tabelas. Cada coluna recebe um tipo de dado que define o que
ela pode armazenar. Tipos númericos como INT e DECIMAL guardam números
VARCHAR guarda texto de tamanho variável, e DATE armazena datas.
A escolha correta do tipo evita desperdício de espaõ e previne o
registro de valores inválidos. */

/* not null -> vai garantir que o campo seja obrigatório e deverá ser preenchido,
não podendo ficar vazio ou nulo. */

/* unique -> vai garantir que a informação de um determinado campo seja
única no banco de dados, não sendo possível duplicidade da informação */

/* Default -> Determina o preenchimento padrão do campo mesmo que não
seja informado.*/

/* current_date() -> puxa a data atual do sistema sem a necessidade do
preenchimento do campo */

create table if not exists categoria(
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
foreign key (id_categoria) references categoria (id_categoria)
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
/* A tabela item_pedido usa uma chave primária composta,
formada por id_pedido e id_produto juntos, porque um item só faz sentido
na combinação dos dois. A cláusula ON DELETE CASCADE determina que, ao excluir
um pedido, seus itens sejam removidos automaticamente, evitando registros órfãos. */

alter table cliente add column telefone varchar(20);