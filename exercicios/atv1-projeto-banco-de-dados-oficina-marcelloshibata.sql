create database if not exists Oficina_MarcelloShibata;
use oficina_marcelloshibata;

create table if not exists clientes(
id_cliente int primary key auto_increment,
nome varchar(120) not null,
endereco varchar(200) not null,
telefone varchar(20)
);

create table if not exists veiculos(
id_veiculo int primary key auto_increment,
id_cliente int,
placa varchar(7) not null,
modelo varchar(50),
ano int,
foreign key (id_cliente) references clientes(id_cliente)
);

create table if not exists ordensDeServico(
id_ordem int primary key auto_increment,
id_veiculo int,
data_entrada date,
data_saida date,
descricao varchar(120),
status varchar(20) default "Aberto",
foreign key (id_veiculo) references veiculos(id_veiculo)
);

insert into clientes (nome, endereco, telefone) values
('João Silva', 'Rua das Flores, 123', '1234-5678'),
('Maria Oliveira', 'Avenida Central, 456', '2345-6789'),
('Pedro Santos', 'Rua do Comércio, 789', '3456-7890'),
('Ana Costa', 'Praça da Liberdade, 101', '4567-8901');

insert into veiculos(id_cliente, placa, modelo, ano) values
(1, 'ABC1234', 'Fusca', 1978),
(2, 'XYZ5678', 'Civic', 2020),
(3, 'DEF9876', 'Corolla', 2015),
(4, 'GHI5432', 'Onix', 2022);

insert into ordensDeServico(id_veiculo, data_entrada, data_saida, descricao, status) values
(1, '2024-08-01', '2024-08-05', 'Troca de óleo e revisão geral', 'Concluída'),
(2, '2024-08-10', null, 'Alinhamento e balanceamento', 'Em andamento'),
(3, '2024-08-15', '2024-08-20', 'Troca de pneus e alinhamento', 'Concluída'),
(4, '2024-08-20', null, 'Revisão completa e troca de óleo', default);

# 1. Liste todos os clientes do banco de dados.
select * from clientes;

# 2. Encontre todos os veiculos que foram fabricados no ano de 2020.
select * from veiculos where ano = 2020;

# 3. Mostre os detalhes das ordens de serviço que estão no status "Em andamento".
select * from ordensdeservico where status = 'Em andamento';

# 4. Liste todos os veículos que tiveram ordens de serviços concluídas entre '2024-08-01' e '2024-08-15'.
select id_veiculo from ordensdeservico where data_saida between '2024-08-01' and '2024-08-15';