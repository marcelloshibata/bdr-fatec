create database teste_bd; /* Criar Banco de Dados "teste_bd" */

use teste_bd; /* Selecionar Banco de Dados "teste_bd" */ 

create database if not exists teste_bd; /* Criar Banco de Dados "teste_bd" somente SE ele não existir */

create table pessoas
(
/* codigo int (número máximo de digitos) */
/* auto_increment adiciona automaticamente um código a cada pessoa registrada */
codigo int auto_increment primary key,
nome varchar(255),
cpf bigint
);