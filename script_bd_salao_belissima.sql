create table usuario (
	id serial not null primary key,
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

create table cliente (
	id int not null primary key,
	data_nascimento date not null,
	foreign key (id) references usuario(id)
);

create table cabeleireiro (
	id int not null primary key,
	rua varchar not null,
	numero int not null,
	cidade varchar(28) not null,
	estado varchar(2) not null,
	foreign key (id) references usuario(id)
);

create table feria (
	id smallserial not null primary key,
	data_inicio date not null,
	data_fim date not null,
	id_usuario int not null,
	foreign key (id_usuario) references cabeleireiro(id) on delete cascade
);

create table servico (
	id smallserial not null primary key,
	nome varchar(25) not null,
	preco numeric not null,
	descricao varchar not null,
	hora_gasta time not null
);

create type status as enum ('Marcado', 'Realizado', 'Cancelado');
create table atendimento (
	id serial not null primary key,
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
	id serial not null primary key,
	titulo varchar(40) not null,
	descricao varchar not null,
	data date not null default current_date,
	id_servico int not null,
	id_cliente int not null,
	foreign key (id_servico) references servico(id),
	foreign key (id_cliente) references cliente(id) on delete cascade
);

create table produto (
	id smallserial not null primary key,
	nome varchar(25) not null,
	marca varchar(20),
	preco numeric,
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
	id smallserial not null primary key,
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
('silvana@silvana.com', 'senha123', '111.111.111.10', 'Silvana Salomé');

select * from usuario;

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
(10, '+5535991911010');

select * from telefone;

insert into cliente values
(6, '1990-01-01'),
(7, '1991-02-02'),
(8, '1992-03-03'),
(9, '1993-04-04'),
(10, '1994-05-05');

select * from cliente;

insert into cabeleireiro values
(1, 'Rua Pereira dos Almeidas', 110, 'Pouso Alto', 'MG'),
(2, 'Rua Rio Verde', 111, 'Carmo de Minas', 'MG'),
(3, 'Rua Rio Claro', 112, 'São Lourenço', 'MG'),
(4, 'Rua Matriz de Sá', 113, 'São Paulo', 'SP'),
(5, 'Rua Imaculada Conceição', 110, 'Baependi', 'MG');

select * from cabeleireiro;

insert into feria (data_inicio, data_fim, id_usuario) values
('2020-12-20', '2021-01-02', 1),
('2020-10-21', '2021-11-03', 2),
('2020-12-22', '2021-01-04', 3),
('2020-11-23', '2021-12-05', 4),
('2020-12-24', '2021-01-06', 5);

select * from feria;

insert into servico (nome, preco, descricao, hora_gasta) values
('Selagem', 80.00, 'Selagem de qualidade! Inveje as inimigas com seu cabelo liso.', '04:30:00'),
('Botox', 50.00, 'Melhor alisamento custo benefício, mesmo levando um choque intenso não terá frizz.', '02:30:00'),
('Franja', 20.00, 'Tem vontade de ser tornar uma Kawaii? Com a franja que faremos ficará igualzinha.', '00:30:00'),
('Lavagem Intensa', 25.00, 'A melhor lavagem da região, usamos Clear Anticaspa e Desmaia Cabelo.', '00:45:00'),
('Chapinha', 18.00, 'Quer ter o cabelo liso pra ir naquele casamento e arrasar? Garantimos isso pra você.', '01:00:00');

select * from servico;

insert into atendimento (horario, data, id_servico, id_cliente, id_cabeleireiro, status) values
('13:30:00', '2020-10-02', 1, 6, 1, 'Realizado'),
('14:30:00', '2020-10-29', 2, 7, 2, 'Marcado'),
('15:30:00', '2020-11-01', 3, 8, 3, 'Marcado'),
('16:30:00', '2020-11-02', 4, 9, 4, 'Marcado'),
('17:30:00', '2020-12-05', 5, 10, 5, 'Cancelado');

select * from atendimento;

insert into comentario (titulo, descricao, data, id_servico, id_cliente) values
('Muito boa a selagem', 'Faz um ano que fiz a selagem e meu cabelo ainda continua liso.', '2020-09-09', 1, 10),
('Franjas longas', 'A franja que fiz nesse salão ficou muito grande.', '2020-08-10', 3, 9),
('Recomendo a selagem', 'Fiz a selagem e farei dnv, muuuuuito bom *----*.', '2020-10-10', 1, 6),
('Barato essa chapinha', 'Pra quem tá com o bolso furado e tem pouca grana eu recomendo a chapinha, por ser barata.', '2020-07-13', 2, 7),
('Lavagem muito boa', 'Minhas caspas sumiram com essa lavagem, gradecida imensamente! :´).', '2020-10-15', 4, 8);

select * from comentario;

insert into produto (nome, marca, preco, validade, quantidade) values
('Desmaia Cabelo', 'Olivina', 15.50, '12-12-2022', 20),
('Shampoo Clear Men', 'Clear', 10.50, '03-12-2023', 50),
('Selagem Grande', 'Fridora', 20.50, '05-10-2021', 30),
('Descolorante em pó', 'Descolorilda', 09.99, '01-05-2022', 40),
('Condicionador Chiclete', 'Havanaunana', 17.75, '25-12-2025', 74);

select * from produto;

insert into produto_servico values
(3, 1),
(2, 4),
(5, 4),
(1, 3),
(5, 1);

select * from produto_servico;

insert into fornecedor(nome, email, telefone, cnpj, cpf, id_produto) values
('Jumencio Silva', 'jumencio@jumencio.com', '5535991234567', NULL, '111.222.333-44', 5),
('Embeleza Supra', 'embelezasupra@embelezasupra.com', '5535991234588', '04.293.287/0001-46', '111.222.333-55', 4),
('Produtos Silva', 'produtossilva@produtossilva.com', '5535991234599', '11.202.494/0001-03', NULL, 3),
('Prado Prato Pratício', 'ppp@ppp.com', '5535991234500', '76.273.339/0001-23', NULL, 2),
('Antonio Serviços', 'antonioservicos@antonioservicos.com', '5535991234511', '51.211.112/0001-22', '111.222.333-66', 1);

select * from fornecedor;