create table usuario (
	id serial primary key,
	email varchar not null,
	password varchar not null,
	cpf varchar(14) not null,
	nome varchar(60) not null,
	unique(email, cpf)
);

create table telefone (
	id_usuario int not null,
	telefone varchar not null,
	primary key(id_usuario, telefone),
	foreign key (id_usuario) references usuario(id)
);

create type sexo as enum ('Masculino', 'Feminino');
create table cliente (
	id int primary key,
	data_nascimento date not null,
	sexo sexo not null,
	foreign key (id) references usuario(id)
);

create table cabeleireiro (
	id int primary key,
	rua varchar not null,
	numero int not null,
	cidade varchar(28) not null,
	estado varchar(2) not null,
	foreign key (id) references usuario(id)
);

create type estadeferias as enum ('V', 'F');
create table feria (
	id smallserial not null,
	data_inicio date not null,
	data_fim date not null,
	id_usuario int not null,
	estadeferias estadeferias not null,
	primary key(id, id_usuario),
	foreign key (id_usuario) references cabeleireiro(id) on delete cascade
);

create table servico (
	id smallserial primary key,
	nome varchar(25) not null,
	preco numeric not null check(preco > 0),
	descricao varchar not null,
	hora_gasta time not null
);

create type status as enum ('Marcado', 'Realizado', 'Cancelado');
create table atendimento (
	id serial primary key,
	horario time not null,
	data date not null,
	id_servico int not null,
	id_cliente int not null,
	id_cabeleireiro int not null,
	status status not null,
	foreign key (id_servico) references servico(id),
	foreign key (id_cliente) references cliente(id),
	foreign key (id_cabeleireiro) references cabeleireiro(id)
);

create table comentario (
	id serial not null,
	titulo varchar(40) not null,
	descricao varchar not null,
	data date not null default current_date,
	id_servico int not null,
	id_cliente int not null,
	primary key(id, id_cliente),
	foreign key (id_servico) references servico(id),
	foreign key (id_cliente) references cliente(id) on delete cascade
);

create table produto (
	id smallserial primary key,
	nome varchar(25) not null,
	marca varchar(20),
	preco numeric not null default 0.00,
	validade date,
	quantidade int
);

create table produto_servico (
	id_produto int not null,
	id_servico int not null,
	primary key(id_produto, id_servico),
	foreign key (id_produto) references produto(id),
	foreign key (id_servico) references servico(id)
);

create table fornecedor (
	id smallserial primary key,
	nome varchar(65) not null,
	email varchar not null,
	telefone varchar not null,
	cnpj varchar(18),
	cpf varchar(14),
	id_produto int not null,
	unique(email, cnpj, cpf),
	foreign key (id_produto) references produto(id)
);

insert into usuario (email, password, cpf, nome) values
('marilia@marilia.com', 'senha123', '111.111.111.11', 'Marilia Dias'),
('joana@joana.com', 'senha123', '111.111.111.12', 'Joana Marta'),
('maria@maria.com', 'senha123', '111.111.111.13', 'Maria Joaquina'),
('felisbina@felisbina.com', 'senha123', '111.111.111.14', 'Felisbina Silva'),
('josue@josue.com', 'senha123', '111.111.111.15', 'Josué Antonieta'),
('mirnalva@mirnalva.com', 'senha123', '111.111.111.16', 'Mirnalva Silvana'),
('elizandra@elizandra.com', 'senha123', '111.111.111.17', 'Elizandra Ana'),
('geralda@geralda.com', 'senha123', '111.111.111.18', 'Geralda Silva'),
('matheusa@matheusa.com', 'senha123', '111.111.111.19', 'Matheusa Souza'),
('silvana@silvana.com', 'senha123', '111.111.111.10', 'Silvana Salomé'),
('rodrigadsluz@gmail.com', 'password123', '127.664.256.32', 'Rodriga Duarte'),
('joanalucas@gmail.com', 'paz123', '327.634.256.22', 'Joana Lucas'),
('zenaide@szenaid.com', 'senha123', '111.111.111.99', 'Zenaide Salomé');

insert into telefone values
(1, '+5535991011101'),
(2, '+5535991111292'),
(3, '+5535991211383'),
(4, '+5535991311474'),
(5, '+5535991411565'),
(6, '+5535991511656'),
(7, '+5535991611747'),
(8, '+5535991711838'),
(9, '+5535991811929'),
(10, '+5535991911010'),
(11, '+5535991811011'),
(12, '+5535991711012'),
(13, '+5535991611013');

insert into cabeleireiro values
(1, 'Rua Pereira dos Almeidas', 110, 'Pouso Alto', 'MG'),
(2, 'Rua Rio Verde', 111, 'Carmo de Minas', 'MG'),
(3, 'Rua Rio Claro', 112, 'São Lourenço', 'MG'),
(4, 'Rua Matriz de Sá', 113, 'São Paulo', 'SP'),
(5, 'Rua Imaculada Conceição', 110, 'Baependi', 'MG');

insert into cliente values
(6, '1990-01-01', 'Feminino'),
(7, '1991-02-02', 'Feminino'),
(8, '1992-03-03', 'Feminino'),
(9, '1993-04-04', 'Feminino'),
(10, '1994-05-05', 'Feminino'),
(11, '1998-01-29', 'Feminino'),
(12, '1997-01-21', 'Feminino'),
(13, '1992-02-02', 'Feminino');

insert into servico (nome, preco, descricao, hora_gasta) values
('Selagem', 80.00, 'Selagem de qualidade! Inveje as inimigas com seu cabelo liso.', '04:30:00'),
('Botox', 50.00, 'Melhor alisamento custo benefício, mesmo levando um choque intenso não terá frizz.', '02:30:00'),
('Franja', 20.00, 'Tem vontade de ser tornar uma Kawaii? Com a franja que faremos ficará igualzinha.', '00:30:00'),
('Lavagem Intensa', 25.00, 'A melhor lavagem da região, usamos Clear Anticaspa e Desmaia Cabelo.', '00:45:00'),
('Chapinha', 18.00, 'Quer ter o cabelo liso pra ir naquele casamento e arrasar? Garantimos isso pra você.', '01:00:00');

insert into atendimento (horario, data, id_servico, id_cliente, id_cabeleireiro, status) values
('13:30:00', '2020-10-02', 1, 6, 1, 'Realizado'),
('14:30:00', '2020-10-29', 2, 7, 2, 'Marcado'),
('15:30:00', '2020-11-01', 3, 8, 3, 'Marcado'),
('16:30:00', '2020-11-02', 4, 9, 4, 'Marcado'),
('17:30:00', '2020-12-05', 5, 10, 5, 'Cancelado');

insert into feria (data_inicio, data_fim, id_usuario, estadeferias) values
('2020-11-06', '2020-12-06', 1, 'F'),
('2020-11-21', '2020-12-21', 2, 'F'),
('2020-12-07', '2021-01-07', 3, 'F'),
('2021-01-01', '2021-02-01', 4, 'F'),
('2020-10-24', '2020-11-24', 5, 'F');

insert into comentario (titulo, descricao, data, id_servico, id_cliente) values
('Muito boa a selagem', 'Faz um ano que fiz a selagem e meu cabelo ainda continua liso.', '2020-09-09', 1, 10),
('Franjas longas', 'A franja que fiz nesse salão ficou muito grande.', '2020-08-10', 3, 9),
('Recomendo a selagem', 'Fiz a selagem e farei dnv, muuuuuito bom *----*.', '2020-10-10', 1, 6),
('Barato essa chapinha', 'Pra quem tá com o bolso furado e tem pouca grana eu recomendo a chapinha, por ser barata.', '2020-07-13', 2, 7),
('Lavagem muito boa', 'Minhas caspas sumiram com essa lavagem, gradecida imensamente! :´).', '2020-10-15', 4, 8),
('Franja legal', 'Muuuuito topster!', '2020-12-05', 3, 6),
('Recomendo a selagem', 'Parabéns querida, incrível!', '2020-11-11', 1, 12);

insert into produto (nome, marca, preco, validade, quantidade) values
('Desmaia Cabelo', 'Olivina', 15.50, '12-12-2022', 20),
('Shampoo Clear Men', 'Clear', 10.50, '03-12-2023', 50),
('Selagem Grande', 'Fridora', 20.50, '05-10-2021', 30),
('Descolorante em pó', 'Descolorilda', 09.99, '01-05-2022', 40),
('Condicionador Chiclete', 'Havanaunana', 17.75, '25-12-2025', 74),
('Joico Capilar', 'Olivina', 200.00, '12-10-2021', 20);

insert into produto_servico values
(3, 1),
(2, 4),
(5, 4),
(1, 3),
(5, 1);

insert into fornecedor(nome, email, telefone, cnpj, cpf, id_produto) values
('Jumencio Silva', 'jumencio@jumencio.com', '5535991234567', NULL, '111.222.333-44', 5),
('Embeleza Supra', 'embelezasupra@embelezasupra.com', '5535991234588', '04.293.287/0001-46', '111.222.333-55', 4),
('Produtos Silva', 'produtossilva@produtossilva.com', '5535991234599', '11.202.494/0001-03', NULL, 3),
('Prado Prato Pratício', 'ppp@ppp.com', '5535991234500', '76.273.339/0001-23', NULL, 2),
('Antonio Serviços', 'antonioservicos@antonioservicos.com', '5535991234511', '51.211.112/0001-22', '111.222.333-66', 1);

---------------------------------------------------------------------------------------------------
---------------------------------------PROJETO FINAL-----------------------------------------------

--Questão 1----------------------------- CORREÇÃO -------------------------------------------------

--Mostrar todos os clientes que fizeram comentários, bem como os que NÃO fizeram comentários.
--Os clientes são identificados por seus IDS
--Junção externa CONSULTA
select cl.id, co.id_cliente from cliente cl left outer join comentario co on cl.id = co.id_cliente;

--Junção externa AR
--Cliente _|X| cliente.id = comentario.id_cliente Comentario


--Mostrar apenas os usuários cujos nomes começam com "Ma".
--Seleção com like CONSULTA
select nome from usuario where nome like 'Ma%';

--Seleção com like AR
--σ nome = 'Ma%'(usuario)


--Mostrar a quantidade de serviço por título de comentário considerando somente aqueles títulos que tem mais de um serviço.
--Função de agregação com having CONSULTA 
select titulo, count(id_servico) from comentario group by titulo having count(id_servico) > 1;

--Função de agregação com having AR
--T <- tituloGcount(id_servico) (comentario)
--R <- σ id_servico > 1(T)
	  

--Mostrar o ID dos clientes que fizeram um comentário e que já agendaram um atendimento (seja cancelado, realizado ou marcado).
--Junção interna com mais de duas tabelas CONSULTA
select distinct cl.id from cliente cl
inner join comentario co on cl.id = co.id_cliente
inner join atendimento at on cl.id = at.id_cliente;

--Junção interna com mais de duas tabelas AR 
--X <- |¨|id(cliente |X| cliente.id = comentario.id_cliente comentario)
--Y <- |¨|id(cliente |X| cliente.id = atendimento.id_cliente atendimento)
--σ X = Y


--O email do fornecedor que oferece um produto cujo a marca é "Clear".
--Divisão CONSULTA
select email from fornecedor where id_produto = (select id from produto where marca = 'Clear');

--Divisão AR
-- |¨|email, id_produto(fornecedor |X| fornecedor.id_produto = produto.id produto) / |¨|id_produto(σ marca = 'Clear'(produto))


---------------------------------------------------------------------------------------------------
--Questão 2----------------------------- Visões ---------------------------------------------------

--Exemplo de visão atualizada e atualizável
--Uma visão que contenha todos os serviços oferecidos pelo salão, com todas as suas informações, para que o cliente possa consultar. 
--Os atributos da tabela base (servico) desta consulta tem que ser renomeados na visão, para um melhor entendimento do usuário cliente.

create view serviços as 
select id as Código,
	nome as Serviço,
	preco as Preço,
	descricao as Descrição,
	hora_gasta as TempoDuração
from servico;

--Exemplo de visão materializada
--Uma visão que pode ser consultada pelo usuário cabeleireiro, contendo informações de todos os produtos do salão. 
--Essa visão tem o nome do produto, código do produto, marca, preço, fornecedor e telefone do fornecedor.

create materialized view produtos as
select pdt.nome as Produto,
	pdt.id as código,
	pdt.marca,
	pdt.preco as preço,
	forn.nome as fonecedor,
	forn.telefone
from produto pdt join fornecedor forn on pdt.id = forn.id_produto;


---------------------------------------------------------------------------------------------------
--Questão 3----------------------------- Procedimento Armazenado ----------------------------------

--Regra de negócio

--Procedimento armazenado para verificar se o cabeleireiro está de férias

--Esse procedimento armazenado deve ser executado diariamente, para poder saber se o funcinário está de férias em relação ao seu dia atual.

--Para isso, foi criado o campo estadeferias na entidade Feria

--Se a feria estiver com a data_inicio menor ou igual a data atual e a data_final maior ou igual a data atual, estadeferias = V (Verdadeiro)
--Se o item anterior não for correto, estadeferias = F (Falso)


create or replace function estadeferias () returns void as $$
declare f feria%rowtype;
BEGIN
	for f in (select * from feria) loop
	
		if (f.data_inicio <= CURRENT_DATE and f.data_fim >= CURRENT_DATE) then
				update feria set estadeferias = 'V' where 
				id = f.id;
			 else 
			 	update feria set estadeferias = 'F' where 
				id = f.id;
			 end if;
			 
	end loop;
	return;
END;
$$
LANGUAGE 'plpgsql';

--Chama a função

select estadeferias();

-- Verifica quem está de férias (V = Verdadeiro, está férias e F = Falso, não está férias)

select * from feria;


---------------------------------------------------------------------------------------------------
--Questão 4----------------------------- Gatilhos -------------------------------------------------

--Regra de negócio

--Gatilho para verificar se o atendimento já está marcado e validar a entrada de dados

--Esse gatilho vai cancelar a operação de inserção ou atualização caso elas firam as seguintes restrições de integridade:

--Se a nova data, horário ou id_cabeleireiro já existem significa que o atendimento já foi marcado e a operação deve ser cancelada, mostrando a mensagem “Este atendimento já foi marcado!”.
--Se a nova data ou horário são inválidos ou o id_cabeleireiro não existem a operação deve ser cancelada, mostrando a mensagem “Data e horário inválidos ou o cabeleireiro não existe!”

CREATE OR REPLACE FUNCTION verifica_atendimento() RETURNS TRIGGER AS $$
BEGIN
	IF (NEW.data IN (SELECT atendimento.data FROM atendimento) and
		NEW.horario IN (SELECT atendimento.horario FROM atendimento) and 
		NEW.id_cabeleireiro IN (SELECT atendimento.id_cabeleireiro FROM atendimento WHERE horario = NEW.horario and data = NEW.data)) THEN
		RAISE EXCEPTION 'O corte para esse dia e com esse cabeleireiro neste horário não está disponível!';
	END IF;
	
	IF (NEW.data < CURRENT_DATE OR NEW.data = CURRENT_DATE AND NEW.horario < LOCALTIME OR NEW.id_cabeleireiro NOT IN (SELECT atendimento.id_cabeleireiro FROM atendimento)) THEN
		RAISE EXCEPTION 'Data e horário inválidos ou o cabeleireiro não existe!';
	END IF;
	
	RETURN NEW;
	END;
$$ 
LANGUAGE 'plpgsql';

CREATE TRIGGER atendimento_invalido
BEFORE INSERT OR UPDATE
ON atendimento
FOR EACH ROW
EXECUTE PROCEDURE verifica_atendimento();

--Adicione um novo atendimento para testar o gatilho
insert into atendimento (horario, data, id_servico, id_cliente, id_cabeleireiro, status) values
('15:30:00', '2022-07-29', 2, 7, 3, 'Marcado');

--Verifique os atendimentos já existentes
select * from atendimento;


---------------------------------------------------------------------------------------------------
--Questão 5----------------------------- Consultas abaixo em SQL e AR -----------------------------

--Junção externa CONSULTA
--*******Mostrar todos os ID dos cabeleireiros que contém alguma féria, bem como os que NÃO contém féria.
--Os cabeleireiros são identificados por seus IDS
--Junção externa CONSULTA
select distinct ca.id, fe.id_usuario from cabeleireiro ca left join feria fe on ca.id = fe.id_usuario;

--Junção externa AR
--Cabeleireiro |X|_ cabeleireiro.id = feria.id_cabeleireiro Feria


--*******Mostrar apenas os produtos cujos nomes começam com "De".
--Seleção com like CONSULTA
select nome from produto where nome like 'De%';

--Seleção com like AR
--σ nome = 'De%'(produto)


--*******Mostrar a soma dos preços dos serviços do salão.
--Função de agregação CONSULTA
select sum (preco) from servico;

--Função de agregação AR
--G sum(preco) (funcionario)


--*******Mostrar a quantia(count) do atributo "quantidade"(estoque) por marca de produto considerando somente aquelas marcas que tem mais de um produto.
--Imagine que tenha dois produtos shampoo com nomes diferentes, por exemplo, Clear Man e Clear Woman. Esses dois produtos diferentes têm a mesma marca (Clear) e também tem a mesma quantidade de itens no estoque
--(Por exemplo, os dois tem 20 itens no estoque). Essa consulta retorna a marca que eles têm em comum e quantas vezes essa mesma quantidade repete no estoque 
--(20 itens repete duas vezes no estoque). O resultado da consulta é a marca clear e o número 2, pq aparece o número "20 itens" duas vezes no banco.

--Função de agregação com having CONSULTA 
select marca, count(quantidade) from produto group by marca having count(quantidade) > 1;

--Função de agregação com having AR
--T <- marcaGcount(quantidade) (produto)
--R <- σ quantidade > 1(T)


--*******Mostrar os cabeleireiros(as) que têm alguma féria marcada e que fará um atendimento.
--Junção interna com mais de duas tabelas CONSULTA
select distinct us.nome from usuario us 
inner join feria fe on us.id = fe.id_usuario
inner join atendimento at on us.id = at.id_cabeleireiro;

--Junção interna com mais de duas tabelas AR
--X <- |¨|id(cabeleireiro |X| cabeleireiro.id = feria.id_cabeleireiro feria)
--Y <- |¨|id(cabeleireiro |X| cabeleireiro.id = atendimento.id_cabeleireiro atendimento)
--σ X = Y


--*******Mostrar todos os ID dos clientes que fizeram um comentário, já agendou um atendimento (seja cancelado, realizado ou marcado) ou as duas coisas.
--Operador de conjunto (UNION) CONSULTA
(select id_cliente from atendimento) union (select id_cliente from comentario);

--Operador de conjunto (UNION) AR
--|¨|id_cliente(atendimento) U |¨|id_cliente(comentario)

--Observação: sabemos que atendimento e comentario precisam ser da mesma aridade (o mesmo número de atributos) e os domínios de atributo precisam ser compatíveis, 
--porém, no nosso banco de dados não tinha tabelas que continham essas condições, então fizemos dessas duas tabelas só para exemplo, mesmo não tendo as condições necessárias.


--*******Mostrar a junção comparando os atributos iguais das relações feria e atendimento.
--Junção natural (NATURAL JOIN) CONSULTA
select * from feria natural join atendimento;

--Junção natural (NATURAL JOIN) AR
--feria |X| atendimento


--*******Mostrar os dados do produto cujo o id dele é igual o id_servico da tabela produto_servico onde o id_produto é igual a 2.
--Consulta aninhada com ‘=’ CONSULTA
select * from produto where id = (select id_servico from produto_servico where id_produto = 2);

--Consulta aninhada com ‘=’ AR
--X <- σ id_produto = 2(produto_servico)
--Y <- σ id_servico(produto_servico) = X
--σ id = Y(produto)


--*******Mostre todos os ID dos clientes que possuem conta e que não possuem atendimento.
--Consulta aninhada com in ou not in CONSULTA
select id from cliente where id not in(select id_cliente from atendimento);

--Consulta aninhada com in ou not in AR
--(|¨|id_cliente(cliente) - |¨|id_cliente(atendimento))


--*******A data de nascimento do cliente que tem um comentario registrado na data de "2020-08-10".
--Divisão CONSULTA
select data_nascimento from cliente where id = (select id_cliente from comentario where data = '2020-08-10');

--Divisão AR
-- |¨|data_nascimento, id_cliente(cliente |X| cliente.id = comentario.id_cliente comentario) / |¨|id_cliente(σ data_comentario = '2020-08-10'(comentario))

