# Funções numéricas e condicionais
/*As funções numéricas arredondam e ajustam valores:
ROUND arredonda, FLOOR e CEIL aproximam para baixo e para cima .
Já as funções condicionais decidem o valor de saída conforme uma regra. 
O comando CASE funciona como uma estrutura de decisão dentro da consulta,
e COALESCE substitui valores nulos por uma alternativa. */


select nome, preco,
	case
		when preco >= 500 then "Premium"
        when preco >= 100 then "Intermediário"
        else "Econômico"
	end as "faixa",
    coalesce(id_categoria,0) as "Categoria Segura"
from produto;

# Visões - O que são visões?
/* Uma visão, ou view, é uma consulta armazenada que se comporta como uma tabela virtual. ELa não guarda dados próprios, mas sim a definição de um SELECT
que é executado sempre que a visão é consultada.
Silberschatz e colaboradores destacam que as visões cumprem dois papéis centrais: simplificar consultas complexas e controlar o que cada usuário pode enxergar. */

create view VW_produtos_categoria as 
select p.id_produto, p.nome as "produto",
p.preco, c.nome as "categoria" from produto p 
join categoria c on p.id_categoria = c.id_categoria;

/* Depois de criada, a visão é consultada como se fosse uma tabela comum, o que dispensa repetir a junção a cada uso: */
select * from vw_produtos_categoria where preco > 200;

# Visões como camda de segurança 
/* Além de simplificar, as visões protegem os dados.
É possível expor apenas alguams colunas de uma tabela, escondendo informações sensíveis. Uma visão que mostra
clientes sem revelar o e-mail, por exemplo, permite que rela´torios sejam gerados sem dar acesso ao dado privado.
A cláusula WITH CHECK OPTION, por sua vez, impede que atualizações
feitas através da visão violem a condição que a define */

create view vw_cliente_publico as 
select id_cliente, nome, cidade from cliente;

select * from vw_cliente_publico;

# Procedimentos (Procedures)
# Um procedimento recebe parâmetros, que podem ser de entrada (IN), de Saída (OUT) ou os dois (INOUT)
# Como o corpo do procedimento contém vários comandos separados por ponto e vírgula, é preciso redefinir
# o delimitador temporariamente com DELIMITER para que o SGBD enenda onde o procedimento termina

DELIMITER $$
CREATE PROCEDURE cadastrar_cliente(
	IN p_nome varchar(100),
    IN p_email varchar(150),
    IN p_cidade varchar(60)
)
BEGIN
	INSERT INTO cliente (nome,email,cidade) VALUES
	(p_nome, p_email, p_cidade);
END$$
DELIMITER ;

ALTER TABLE cliente ADD COLUMN email varchar(150);

# A chamada de procedimento é feita com o comando CALL, informando os valores dos parâmetros
CALL cadastrar_cliente('Bruno Lima e Silva', 'Bruno.ls@email.com', 'Cajati')

# Dentro de um procedimento é possivel tomar decisões e repetir comandos.
# As estruturas IF e CASE controlam o fluxo conforme condições, e os laços WHILE, LOOP e REPEAT
# executam blocos repetidamente. Variáveis locais, declaradas com DECLARE, guardam valores intermediários.
# O exemplo aplica um desconto diferente conforme o valor do pedido.

DELIMITER $$
CREATE PROCEDURE calcular_desconto (
	IN p_valor decimal(10,2),
    OUT p_desconto decimal(10,2)
)
BEGIN
	IF p_valor >= 1000 THEN
		SET p_desconto = p_valor * 0.10;
	ELSEIF p_valor >= 500 THEN
		SET p_desconto = p_valor * 0.05;
	ELSE
		SET p_desconto = 0;
	END IF;
END $$
DELIMITER ;

# Chamar a procedure calcular desconto
CALL calcular_desconto(1200,@desconto);

# Tratamento de erros
# Procedimentos robustos precisam lidar com situações inesperadas,
# como tentar inserir um e-mail já existente. O comando DECLARE HANDLER
# define o que fazer quando um erro ocorre, e SIGNAL SQLSTATE permite gerar erros personalizados
# Isso evita que o procedimento falhe de forma silenciosa ou deixe dados pela metade.

DELIMITER $$
CREATE PROCEDURE baixar_estoque(
	IN p_produto int,
    IN p_qtd int
)
BEGIN
	DECLARE v_estoque INT;
    SELECT estoque
    INTO v_estoque
    FROM produto
    WHERE id_produto = p_produto;
    IF v_estoque < p_qtd THEN
		SIGNAL SQLSTATE '45000'
        SET message_text = 'Estoque insuficiente';
	ELSE
		UPDATE produto SET estoque = estoque - p_qtd
        WHERE id_produto = p_produto;
	END IF;
END$$
DELIMITER ;

SELECT *
FROM produto;
CALL baixar_estoque(1,9);

# Função armazenada
# A função armazenada é parente próxima do procedimento
# mas com uma diferença essencial: ela sempre retorna um único valor
# e pode ser usada dentro de uma consulta, como se fosse uma função interna
# Procedimentos executam ações; funções calculam e devolvem resultados

DELIMITER $$
CREATE FUNCTION	total_pedido (p_pedido INT) RETURNS decimal(10,2)
DETERMINISTIC # é uma caracteristica usada em funções armazenadas do SQL
			  # para indicar que, recebndo os mesmos valores de entrada,
              # a função sempre retornará o mesmo resultado
BEGIN
	DECLARE v_total DECIMAL(10,2);
    SELECT SUM(quantidade * preco_unitario) INTO v_total
    FROM item_pedido WHERE id_pedido = p_pedido;
    RETURN COALESCE(v_total, 0);
END$$       
DELIMITER ;

SELECT id_pedido, total_pedido(id_pedido) AS valor FROM pedido; 