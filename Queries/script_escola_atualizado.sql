CREATE DATABASE escola2;
USE escola2;


--PRIMEIRO VAMOS CRIAR TODAS AS TABELAS QUE N�O LEVAM FOREIGN KEYS

-- CREATE TABLE - Cria a tabela
-- Ao criar, precisamos "tipar" os dados, informando se eles ser�o int, char, varchar...
-- Tamb�m devemos setar as constraints, no caso informando se aquela coluna � NOT NULL, PRIMARY KEY, IDENTITY, UNIQUE...

CREATE TABLE sala
(id TINYINT PRIMARY KEY IDENTITY,
numero VARCHAR(5) NOT NULL,
vagas TINYINT NOT NULL);


CREATE TABLE turma 
(id TINYINT PRIMARY KEY IDENTITY,
serie VARCHAR(30) NOT NULL);

CREATE TABLE dia_hora
(id TINYINT PRIMARY KEY IDENTITY,
hora_aula VARCHAR(5) NOT NULL,
dia VARCHAR(15) NOT NULL);

CREATE TABLE endereco_aluno
(id INT PRIMARY KEY IDENTITY,
logradouro VARCHAR(120) NOT NULL,
bairro VARCHAR(60) NOT NULL,
numero VARCHAR(9) NOT NULL,
cep INT NOT NULL,
complemento VARCHAR(120),
cidade VARCHAR(60) NOT NULL,
uf CHAR(2) NOT NULL);

CREATE TABLE endereco_professor
(id INT PRIMARY KEY IDENTITY,
logradouro VARCHAR(120) NOT NULL,
bairro VARCHAR(60) NOT NULL,
numero VARCHAR(9) NOT NULL,
cep INT NOT NULL,
complemento VARCHAR(120),
cidade VARCHAR(60) NOT NULL,
uf CHAR(2) NOT NULL);

-- AGORA, CRIAREMOS AS TABELAS QUE LEVAM FOREIGN KEYS

CREATE TABLE professor
(id TINYINT PRIMARY KEY IDENTITY,
id_endereco_professor INT NOT NULL,
nome VARCHAR(40) NOT NULL,
sobrenome VARCHAR(60) NOT NULL,
materia VARCHAR(30) NOT NULL,
CONSTRAINT fk_id_endereco_professor FOREIGN KEY(id_endereco_professor) REFERENCES endereco_professor(id));


CREATE TABLE aluno
(id INT PRIMARY KEY IDENTITY,
id_turma TINYINT NOT NULL,
id_endereco_aluno INT NOT NULL,
nome VARCHAR(40) NOT NULL,
sobrenome VARCHAR(60) NOT NULL,
nascimento DATE NOT NULL,
cpf BIGINT UNIQUE NOT NULL,
alergia VARCHAR(60),
genero CHAR(1) NOT NULL,
CONSTRAINT fk_id_turma FOREIGN KEY(id_turma) REFERENCES turma(id),
CONSTRAINT fk_id_endereco_aluno FOREIGN KEY(id_endereco_aluno) REFERENCES endereco_aluno(id));

CREATE TABLE aula
(id INT PRIMARY KEY IDENTITY,
id_sala TINYINT NOT NULL,
id_turma TINYINT NOT NULL,
id_professor TINYINT NOT NULL,
id_dia_hora TINYINT NOT NULL
CONSTRAINT fk_id_sala FOREIGN KEY (id_sala) REFERENCES sala(id),
CONSTRAINT fk_id_turma2 FOREIGN KEY (id_turma) REFERENCES turma(id),
CONSTRAINT fk_id_professor2 FOREIGN KEY (id_professor) REFERENCES professor(id),
CONSTRAINT fk_id_dia_hora FOREIGN KEY (id_dia_hora) REFERENCES dia_hora(id));

CREATE TABLE contato_aluno
(id INT PRIMARY KEY IDENTITY,
id_aluno INT NOT NULL,
ddd TINYINT NOT NULL,
telefone INT NOT NULL,
email VARCHAR(120) UNIQUE NOT NULL,
CONSTRAINT fk_id_aluno FOREIGN KEY(id_aluno) REFERENCES aluno(id));

CREATE TABLE contato_professor
(id INT PRIMARY KEY IDENTITY,
id_professor TINYINT NOT NULL,
ddd TINYINT NOT NULL,
telefone INT NOT NULL,
email VARCHAR(120) UNIQUE NOT NULL
CONSTRAINT fk_id_professor FOREIGN KEY(id_professor) REFERENCES professor(id));

-- CRIADAS TODAS AS TABELAS DO DATABASE, PASSAMOS ENT�O PARA A PARTE DE INSER��ES. OU SEJA: IREMOS POPULAR AS TABELAS

INSERT INTO sala (numero,vagas) VALUES
	(1,50),
	(2,50),
	(3,50),
	(4,50),
	(5,50),
	(6,30),
	(7,30),
	(8,30),
	(9,30),
	(10,30),
	(11,30),
	(13,30),
	(14,60),
	(15,60);

INSERT INTO turma (serie) VALUES
	('6� ano A'),
	('6� ano B'),
	('7� ano A'),
	('7� ano B'), 
	('8� ano A'),
	('8� ano B'),
	('9� ano A'),
	('9� ano B'),
	('1� ano A ensino medio'),
	('1� ano B ensino medio'),
	('2� ano A ensino medio'),
	('2� ano B ensino medio'),
	('3� ano A ensino medio'),
	('3� ano B ensino medio');

INSERT INTO dia_hora (hora_aula,dia) VALUES
	('07:30','segunda-feira'),
	('08:30','segunda-feira'),
	('09:30','segunda-feira'),
	('10:30','segunda-feira'),
	('11:30','segunda-feira'),
	('13:30','segunda-feira'),
	('14:30','segunda-feira'),
	('15:30','segunda-feira'),
	('16:30','segunda-feira'),
	('17:30','segunda-feira'),
	('07:30','ter�a-feira'),
	('08:30','ter�a-feira'),
	('09:30','ter�a-feira'),
	('10:30','ter�a-feira'),
	('11:30','ter�a-feira'),
	('13:30','ter�a-feira'),
	('14:30','ter�a-feira'),
	('15:30','ter�a-feira'),
	('16:30','ter�a-feira'),
	('17:30','ter�a-feira'),
	('07:30','quarta-feira'),
	('08:30','quarta-feira'),
	('09:30','quarta-feira'),
	('10:30','quarta-feira'),
	('11:30','quarta-feira'),
	('13:30','quarta-feira'),
	('14:30','quarta-feira'),
	('15:30','quarta-feira'),
	('16:30','quarta-feira'),
	('17:30','quarta-feira'),
	('07:30','quinta-feira'),
	('08:30','quinta-feira'),
	('09:30','quinta-feira'),
	('10:30','quinta-feira'),
	('11:30','quinta-feira'),
	('13:30','quinta-feira'),
	('14:30','quinta-feira'),
	('15:30','quinta-feira'),
	('16:30','quinta-feira'),
	('17:30','quinta-feira'),
	('07:30','sexta-feira'),
	('08:30','sexta-feira'),
	('09:30','sexta-feira'),
	('10:30','sexta-feira'),
	('11:30','sexta-feira'),
	('13:30','sexta-feira'),
	('14:30','sexta-feira'),
	('15:30','sexta-feira'),
	('16:30','sexta-feira'),
	('17:30','sexta-feira');


INSERT INTO endereco_aluno(bairro,numero,cep,complemento,cidade,uf,logradouro) VALUES
	('tambauzinho',70,58145336,'Na rua da EPC','Joao Pessoa','PB','Joaquim Filho'),
	('tambau',13,58145236,'Em frente a delegacia','Joao Pessoa','PB','Das Pluminhas'),
	('pedro gondim',72,58704330,'Ao lado da escola Sagres','Joao Pessoa','PB','Deputado Acacio Figueiredo'),
	('varadouro',50,51147765,'Em frente a serigrafia do rouquinho','Joao Pessoa','PB','Pinto das neves'),
	('geisel',40,51145896,'Atr�s da rua esburacada','Joao Pessoa','PB','Serelepe'),
	('cabo branco',70,55563214,'Em frente ao supermercado Bem Mais','Joao Pessoa','PB','Joao Pedro II'),
	('bessa',33,50124479,'sem complemento','Joao Pessoa','PB','Das laranjeiras'),
	('altiplano',17,59987713,'Edificio Next Tower','Joao Pessoa','PB','Catorze'),
	('Bessa',40,58700000,'Edificio Novo mundo','Joao Pessoa','PB','Rua felizardo leite');


INSERT INTO endereco_professor (logradouro,bairro,numero,cep,complemento,cidade,uf) VALUES
	('Rua Diazepan Virgulino da Silva','Tamba�',2424,58451236,'Casa','Joao Pessoa','PB'),
	('Rua Vandick Pinto Filgueiras','Tambauzinho',2412,58003654,'Apartamento 304','Joao Pessoa','PB'),
	('Rua Deputado Geraldo Mariz','Tambauzinho',1311,58417000,'Apartamento 201','Joao Pessoa','PB'),
	('Rua Desembargador Edmundo Jordao','Bessa',127,58558713,'Casa','Joao Pessoa','PB'),
	('Rua Fernanda Beira-rio','Varadouro',696,58147586,'Casa','Joao Pessoa','PB'),
	('Rua Roberta Ca�arola','Geisel',666,58741529,'Casa','Joao Pessoa','PB'),
	('Rua Sofia Madeixas','Cui�',312,58451236,'Casa','Joao Pessoa','PB'),
	('Rua Izaline Kelly Pompeu','Cristo',177,58412358,'Casa','Joao Pessoa','PB')
 

INSERT INTO professor (id_endereco_professor,nome,sobrenome,materia) VALUES
	(1,'Lucas','Melquiades','Biologia'),
	(2,'Serafim','Augusto dos santos','Teologia'),
	(3,'Rafael','Santos Drummond','Avia��o'),
	(4,'Charles','Henriquep�dia','Gram�tica'),
	(5,'Leonardo','Zohan','Qu�mica'),
	(6,'Hortelino','Troca-letras','Gastronomia'),
	(7,'Chamber','Mazzaropio','Hist�ria'),
	(8,'Pumba','La pumba','Dan�a r�tmica')

INSERT INTO contato_professor(id_professor,ddd,telefone,email) VALUES
	(1,83,998723684,'ximbinha@gmail.com'),
	(2,83,998544123,'joelma@gmail.com'),
	(3,83,985541221,'simbinha@gmail.com'),
	(4,83,999999741,'joanamilgrau@hotmail.com'),
	(5,83,998511475,'fluttermutter@gmail.com'),
	(6,83,996654712,'evrileri@hotmail.com'),
	(7,83,999741110,'milkas10@gmail.com'),
	(8,83,991222112,'chamberdamassa@gmail.com');

INSERT INTO aluno(id_turma,id_endereco_aluno,nome,sobrenome,nascimento,cpf,alergia,genero) VALUES
	(1,1,'Flavio','Castro','20001231',1112445698,'n�o tem','M'),
	(1,2,'Ana Julia','Bates','20000114',1852364479,'camar�o','F'),
	(1,3,'Gabriel','Fleumas','19991203',01192445698,'�caro','M'),
	(1,4,'Spinardi','Haikaiss','20010811',01342445698,'poeira','M'),
	(2,5,'Fidel','Castro','20000411',01121445698,'crust�ceo','M'),
	(2,6,'C�sar','Coelho','20010809',01174445698,'dipirona','M'),
	(2,7,'Mariana','Cunha Lima','20000908',0232445698,'n�o tem','F'),
	(2,8,'Lucas','Kamion Neiro','20001004',04412445698,'tem,mas n�o sabe qual �','M'),
	(2,9,'Ana Julia','Barroso','20011114',014374445698,'beterraba','F');
	
	
INSERT INTO contato_aluno(id_aluno,ddd,telefone,email) VALUES
	(1,83,981144523,'lesma@gmail.com'),
	(2,83,983290564,'kleydison@gmail.com'),
	(3,83,997632091,'homemlipidio@gmail.com'),
	(4,83,998345302,'bombonierecomercial@hotmail.com'),
	(5,83,998743256,'digdongson@gmail.com'),
	(6,83,991239520,'elfoladino@hotmail.com'),
	(7,83,997583924,'oxitador@gmail.com'),
	(8,83,997234923,'candelabroazul@gmail.com');

INSERT INTO aula (id_sala,id_turma,id_professor,id_dia_hora) VALUES
	(1, 8, 5,13),
	(2, 7, 4,14),
	(3, 6, 3,16),
	(4, 5, 2,15),
	(5, 4, 1,11),
	(6, 3, 6,10),
	(7, 2, 7,17),
	(8, 1, 8,11);

--COM AS TABELAS J� POPULADAS, QUEREMOS ENT�O RETORNAR AS INFORMA��ES INSERIDAS, UTILIZANDO DE SINTAXES QUE IREMOS MOSTRAR ABAIXO:

--SELECT B�SICO
SELECT * FROM aluno;

--SELECT COM ORDENA��O DESCENDENTE
SELECT nome,sobrenome FROM aluno ORDER BY nome DESC;


--SELECT COM ORDENA��O ASCENDENTE
SELECT nome,nascimento FROM aluno ORDER BY nome ASC;

--SELECT UTILIZANDO PAR�METROS LIKE PARA FILTRAR NOMES QUE COME�AM COM A LETRA F
SELECT nome, sobrenome FROM aluno
WHERE nome LIKE 'F%';

--SELECT UTILIZANDO PAR�METROS NOT LIKE PARA FILTRAR NOMES QUE N�O COME�AM COM A LETRA A
SELECT nome, sobrenome FROM aluno
WHERE nome NOT LIKE 'A%';

--SELECT UTILIZANDO PAR�METROS LIKE PARA FILTRAR NOMES CUJA PRIMEIRA LETRA SEJA M, AS LETRAS SUBSEQUENTES N�O IMPORTAM, E O FINAL TERMINE COM ANA
SELECT nome,sobrenome FROM aluno
WHERE nome LIKE 'M___ana';

--SELECT UTILIZANDO PAR�METROS LIKE PARA FILTRAR NOMES CUJA PRIMEIRA LETRA ESTEJA ENTRE F AT� M
SELECT nome,sobrenome FROM aluno
WHERE nome LIKE '[^F-M]%';

--SELECT UTILIZANDO PAR�METROS LIKE PARA FILTRAR NOMES CUJA PRIMEIRA LETRA N�O ESTEJA ENTRE F AT� M
SELECT nome,sobrenome FROM aluno
WHERE nome LIKE '[^F-M]%';

--SELECT ME RETORNANDO ALUNOS CUJO ID ESTEJA ENTRE 3 E 8
SELECT nome, id FROM aluno 
WHERE id > 3 AND id < 8;

--SELECT ME RETORNANDO ALUNOS CUJO ID SEJA MENOR QUE 3 E MAIOR QUE 8
SELECT nome, id FROM aluno 
WHERE id < 3 OR id > 8;

--SELECT COM CL�USULA IN ME RETORNANDO ESPECIFICAMENTE OS ALUNOS DE ID 3 E 8 C
SELECT nome, id FROM aluno 
WHERE id IN (3,8);

--SELECT COM NOT IN QUE ME RETORNE ALUNOS CUJO ID N�O SEJA 3 E 8
SELECT nome, id FROM aluno 
WHERE id NOT IN (3,8);

--SELECT FILTRANDO COM BETWEEN(ENTRE): AQUI FILTRAMOS OS ALUNOS CUJO ID EST�O ENTRE 1 E 5
SELECT nome FROM aluno
WHERE id BETWEEN 1 AND 5;

--VAMOS SUPOR QUE EU QUEIRA MODIFICAR OU ATUALIZAR UM REGISTRO DE UMA TABELA. PODEMOS USAR O COMANDO UPDATE, JUNTAMENTE COM A CL�USULA WHERE.
UPDATE aluno 
SET sobrenome = 'Fleumas M�tico' 
WHERE id=3;

--Ou

UPDATE aluno
SET sobrenome = 'Fleumas'
WHERE nome = 'Gabriel'

--CONTANDO N�MERO DE REGISTROS DE UMA TABELA:
SELECT COUNT(*) FROM aluno;
SELECT COUNT(id) AS Total_Turmas FROM turma;


--HAVING

SELECT COUNT(p.id) AS TOTAL, ep.complemento
FROM professor p
JOIN endereco_professor ep
ON p.id_endereco_professor = ep.id
GROUP BY ep.complemento
HAVING COUNT(p.id) > 3

/* CASO EU QUEIRA DELETAR TODOS OS REGISTROS DE UMA TABELA, POSSO USAR O COMANDO TRUNCATE. ELE � MUITO MAIS R�PIDO QUE EXCLUIR OS REGISTROS UM A UM.
N�O PODE SER REVERTIDO E OS DADOS N�O PODEM SER RECUPERADOS. ENT�O, TOME CUIDADO */

TRUNCATE TABLE nome_da_tabela;

--OU UTILIZAMOS O DELETE, PREFERENCIALMENTE COM A CLAUSULA WHERE. EXEMPLO:
DELETE FROM tabela WHERE id = x

--SE DESEJAMOS RETORNAR INFORMA��ES SEM VALORES DUPLICADOS, UTILIZAMOS O SELECT DISTINCT.
SELECT DISTINCT nome,sobrenome
FROM aluno
SELECT NOME FROM ALUNO


--ALTERS
CREATE TABLE aluno3(
id INT PRIMARY KEY,
nome VARCHAR(30),
sobrenome VARCHAR(45));

INSERT INTO aluno3 VALUES (1,'Gabriel','Gouveia'),
(2,'Beto','Coringa'),
(3,'Rafa','Mamamia');

DROP TABLE aluno3;


ALTER TABLE aluno3 ALTER COLUMN nome char(45);
ALTER TABLE aluno3 DROP COLUMN sobrenome;
ALTER TABLE aluno3 ADD idade INT;
ALTER TABLE turma DROP COLUMN quantidade_alunos;


--INNER JOIN UTILIZANDO 3 TABELAS: ALUNO, TURMA E ENDERECO_ALUNO
SELECT a.id AS 'Id aluno',ea.id AS 'Id do endere�o aluno', a.nome AS 'Nome do aluno',
 a.sobrenome AS 'Sobrenome do aluno', a.cpf, t.serie, ea.logradouro, ea.bairro, ea.numero, ea.cep 
FROM aluno AS a
INNER JOIN turma AS t
ON t.id=a.id_turma
INNER JOIN endereco_aluno AS ea
ON a.id_endereco_aluno=ea.id

--O left join ir� retornar todos os registros da tabela � esquerda, mesmo que n�o haja nenhum correspondente na tabela � direita

SELECT a.nome, ca.id_aluno FROM aluno a 
LEFT JOIN contato_aluno ca 
ON a.id = ca.id_aluno


--J� o right join,retorna todos os registros da tabela � direita, mesmo que n�o haja nenhum correspondente na tabela � esquerda.

SELECT a.nome, ca.id_aluno FROM contato_aluno ca
RIGHT JOIN aluno a
ON a.id = ca.id_aluno

SELECT a.nome, ca.id_aluno FROM aluno a
INNER JOIN contato_aluno ca
ON a.id = ca.id_aluno

--O full join ir� retornar todos os registros das duas tabelas, mesmo que n�o haja nenhum correspondente na outra tabela.

SELECT a.nome, ca.id_aluno FROM contato_aluno ca
FULL JOIN aluno a
ON a.id = ca.id_aluno

SELECT a.nome, ca.id_aluno FROM aluno a
INNER JOIN contato_aluno ca
ON a.id = ca.id_aluno


--SELF JOIN
CREATE TABLE professor2(
id INT PRIMARY KEY,
nome VARCHAR(30),
sobrenome VARCHAR(45),
id_gerente INT,
CONSTRAINT fk_id_gerente FOREIGN KEY (id_gerente) REFERENCES professor2(id));

INSERT INTO professor2 VALUES (1,'Gabriel','Gouveia',NULL),
(2,'Beto','Coringa', 1),
(3,'Rafa','Mamamia', 1),
(4,'Lucas','SCANIA STREAMLINE', 3),
(5,'Chicken','Little', 3);


SELECT p1.nome, p1.sobrenome, pg.nome AS
Gerente FROM professor2 p1
INNER JOIN professor2 pg
ON pg.id = p1.id_gerente
ORDER BY Gerente


--CROSS JOIN
SELECT nome, sobrenome FROM professor;
SELECT nome, sobrenome FROM professor2;

SELECT p2.nome, p2.sobrenome, p.nome,p.sobrenome
FROM professor p
CROSS JOIN professor2 p2

select * FROM aluno
