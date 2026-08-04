create database if not exists teste_bd;
use teste_bd;

create table pessoas(
codigo int auto_increment primary key,
nome varchar(255),
cpf bigint
);