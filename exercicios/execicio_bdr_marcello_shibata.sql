create database if not exists BD_Supermercado_marcelloShibata;

use bd_supermercado_marcelloshibata;

create table if not exists fornecedores(
id_fornec int primary key auto_increment,
nome varchar(60) not null);

create table if not exists produtos(
id_prod int primary key auto_increment,
id_fornec int not null,
nome varchar(120) not null,
preco decimal(10,2) not null check (preco >=0),
qtd_estoque int not null default 0,
foreign key(id_fornec) references fornecedores(id_fornec)
);

create table if not exists compras(
id_compra int primary key auto_increment,
qntd_prod int not null check (qntd_prod >0),
id_prod int,
foreign key (id_prod) references produtos(id_prod)
);

insert into fornecedores (nome) values("Aurora"),("Nepi"),("Panco"),("Del Valle");

insert into produtos (nome, preco, qtd_estoque, id_fornec) values
('Pão de forma', 10.25, 40, 1),
('Bolo', 12.04, 20, 1),
('Panetone', 20.25, 50, 1),
('Coca-cola', 10.25, 40, 2),
('Suco Laranja', 12.04, 20, 2),
('Suco Uva', 10.40, 50, 2),
('Patinho', 60.25, 60, 3),
('Acem', 102.04, 10, 3),
('Coxão mole', 105.40, 30, 3),
('Yogurt', 7.25, 10, 4),
('Danone', 2.04, 20, 4),
('Leite', 50.40, 50, 4);

insert into compras (qntd_prod, id_prod) values
(5, 1),
(6, 2),
(8, 3),
(10, 4),
(16, 5);