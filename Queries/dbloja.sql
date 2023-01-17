CREATE DATABASE loja3;
USE loja3;

CREATE TABLE Cliente(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Nome VARCHAR(50)NOT NULL,
	Telefone BIGINT NOT NULL,
	Email VARCHAR(100) UNIQUE NOT NULL
)

CREATE TABLE Vendedor(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Nome VARCHAR(50) NOT NULL
	)

CREATE TABLE Pagamento(
	Id TINYINT IDENTITY(1,1) PRIMARY KEY,
	FormaPagamento VARCHAR(50) NOT NULL
	)

CREATE TABLE Venda(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	IdCliente INT NOT NULL,
	IdPagamento TINYINT NOT NULL,
	IdVendedor INT NOT NULL,
	ValorTotal MONEY NOT NULL,
	Data DATETIME NOT NULL,
	CONSTRAINT fk_IdCliente FOREIGN KEY (IdCliente) REFERENCES Cliente(Id),
	CONSTRAINT fk_IdPagamento FOREIGN KEY (IdPagamento) REFERENCES Pagamento(Id),
	CONSTRAINT fk_IdVendedor FOREIGN KEY (IdVendedor) REFERENCES Vendedor(Id)
	)

CREATE TABLE Categoria(
	Id SMALLINT IDENTITY(1,1) PRIMARY KEY,
	Nome VARCHAR (50) NOT NULL,
)

CREATE TABLE Fornecedores(
	Id SMALLINT IDENTITY(1,1) PRIMARY KEY,
	Nome VARCHAR (50) NOT NULL,
	CNPJ BIGINT NOT NULL UNIQUE
)

CREATE TABLE Produto(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	IdCategoria SMALLINT NOT NULL,
	IdFornecedores SMALLINT NOT NULL,
	Preco MONEY NOT NULL,
	QtdEstoque SMALLINT DEFAULT NULL,
	CONSTRAINT fk_IdCategoria FOREIGN KEY (IdCategoria) REFERENCES Categoria(Id),
	CONSTRAINT fk_IdFornecedores FOREIGN KEY (IdFornecedores) REFERENCES Fornecedores(Id)
)

CREATE TABLE VendaProduto (
	Id INT IDENTITY(1,1) PRIMARY KEY,
	IdVenda INT,
	IdProduto INT
	CONSTRAINT fk_IdVenda FOREIGN KEY (IdVenda) REFERENCES Venda(Id),
	CONSTRAINT fk_IdProduto FOREIGN KEY (IdProduto) REFERENCES Produto(Id)
)


INSERT INTO Cliente VALUES
('Gabriel Gouveia',83981664646,'jose.gabriel@smn.com.br'),
('Gustavo Betoneira',83981927638,'betotiktok@smn.com.br'),
('Gustavo Gustavas',83998172367,'gustas@smn.com.br'),
('Guilherme Guigas',85902731437,'guigas@smn.com.br'),
('Rafael Adolf',65947201398,'rafael.adolf@smn.com.br'),
('Lucas Scania',11989126347,'lucas.scania@smn.com.br')

INSERT INTO Vendedor VALUES
('Ianko'),
('Waldson'),
('Dellano Derek'),
('Cayo'),
('Joao'),
('Felipe'),
('Pessoni')

INSERT INTO Pagamento VALUES
('Pix'),
('Crédito'),
('Débito'),
('Cheque'),
('Dinheiro'),
('Boleto')

INSERT INTO Venda VALUES
(1, 2, 1, 154.53,'20230116 12:45:34'),
(3, 1, 2, 75.46,'20220814 12:45:34'),
(4, 3, 5, 36.54,'20230110 10:42:39'),
(6, 4, 4, 25.27,'20190420 02:25:25'),
(2, 5, 6, 147.59,'20200305 06:53:15'),
(3, 6, 3, 50.27,'20221212 07:14:16'),
(5, 2, 7, 6253.90,'20210115 16:52:19'),
(5, 2, 7, 4682.90,'20210115 12:52:19'),
(1, 2, 1, 3248.90,'20210115 16:52:29'),
(1, 3, 1, 734.90,'20210115 13:22:11'),
(3, 2, 2, 4257.90,'20210115 17:55:59')

INSERT INTO Categoria VALUES 
('Pessoais'),
('Higienicos'),
('Automotivos'),
('Corporais'),
('Roupas'),
('Acessórios')

INSERT INTO Fornecedores VALUES 
('SHEIN',94637463215746),
('TendTudo',91892734683746),
('AutoParts',12374896123879),
('Shell',78129364129387),
('QuickSilver',71928346912874),
('Avon',12367842913848),
('Balenciaga',43172846129873)

INSERT INTO Produto VALUES 
(6, 4, 69.69, 24),
(3, 4, 34.27, 75),
(3, 3, 12.42, 35),
(6, 7, 630.00, 57),
(5, 1, 15.00, 29),
(5, 5, 49.00, 9),
(2, 6, 22.00, 16)

INSERT INTO VendaProduto VALUES 
(1, 1),
(2, 2),
(3, 5),
(4, 3),
(5, 6),
(6, 7),
(7, 4)



--Aqui é pra adicionar uma fk+fazer sua referencia em um alter table apenas--
/* 
CREATE TABLE Avaliacao(
	Id TINYINT IDENTITY(1,1) PRIMARY KEY,
	Avaliacao CHAR(5) --1 a 5 Estrelas--
)

ALTER TABLE Produto ADD IdAvaliacao TINYINT NOT NULL CONSTRAINT Fk_Avaliacao FOREIGN KEY (IdAvaliacao) REFERENCES Avaliacao(Id)
*/


/* 
Em seguida, façam scripts para alterar os dados de algumas tabelas, 
podem fazer a alteração que acharem melhor
*/
ALTER TABLE Cliente ALTER COLUMN Nome VARCHAR(60)
ALTER TABLE Produto ADD Avaliacao CHAR(5)
ALTER TABLE Produto DROP COLUMN Avaliacao



/*
Mas quero façam uma query pra que o atributo "quantidade" da tabela "produto" seja acrescido em 100 para todos os registros de uma vez.
*/
UPDATE Produto SET QtdEstoque = QtdEstoque + 100



/*
Depois eu quero que a tabela cliente deixe de ter a coluna "telefone" 
e passe a ter a coluna "contato" que deve ter entrada de dados opcional, façam uma query pra isso.
*/
EXEC sp_rename 'cliente.telefone', 'Contato';
ALTER TABLE Cliente ALTER COLUMN Contato BIGINT NULL
/*
Quero uma query que busque o valor da venda, o nome do cliente e a forma de pagamento que ele usou.
*/
SELECT cl.Nome, pg.FormaPagamento AS 'Forma de Pagamento', v.ValorTotal AS Total FROM Venda v
INNER JOIN Cliente cl
ON v.IdCliente = cl.Id
INNER JOIN Pagamento pg
ON pg.Id = v.IdPagamento
ORDER BY Total DESC



/*
Depois quero uma query que busque todos os produtos ligados a uma única venda.
*/
SELECT cl.Nome, c.Nome,p.Preco, v.ValorTotal AS Total FROM VendaProduto vp
INNER JOIN Venda v
ON vp.IdVenda = v.Id
INNER JOIN Produto p
ON p.Id = vp.IdProduto
INNER JOIN Cliente cl
ON cl.Id = v.IdCliente
INNER JOIN Categoria c
ON c.Id = p.IdCategoria
WHERE cl.Email = 'gustas@smn.com.br'
ORDER BY Total DESC



/*
E pra finalizar quero que façam uma subquery.
*/
SELECT Nome, (SELECT SUM(ValorTotal) FROM Venda WHERE IdCliente = 5) AS 'Soma Total' FROM Cliente WHERE Id = 5

