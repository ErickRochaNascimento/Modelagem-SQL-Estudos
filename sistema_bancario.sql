-- Criação do Banco de Dados
CREATE DATABASE IF NOT EXISTS SistemaBancario;
USE SistemaBancario;

-- Tabela de Clientes
CREATE TABLE clientes (
    cpf_cliente VARCHAR(11) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    dataNascimento DATE NOT NULL,
    telefone VARCHAR(11),
    logradouro VARCHAR(150) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(2) NOT NULL
);

-- Tabela de Contas
CREATE TABLE contas (
    numeroConta INT PRIMARY KEY AUTO_INCREMENT,
    tipoConta ENUM('corrente', 'poupanca', 'empresarial') NOT NULL,
    saldo DECIMAL(15,2) NOT NULL DEFAULT 0.00,
    cliente_CPF_cliente VARCHAR(11) NOT NULL,
    CONSTRAINT fk_conta_cliente FOREIGN KEY (cliente_CPF_cliente) REFERENCES clientes(cpf_cliente)
);

-- Tabela de Transações
CREATE TABLE transacoes (
    id_transacao INT PRIMARY KEY AUTO_INCREMENT,
    tipo ENUM('saque', 'deposito', 'transferencia') NOT NULL,
    valor DECIMAL(15,2) NOT NULL,
    dataTransacao DATETIME,
    numero_conta INT,
    CONSTRAINT fk_transacao_conta FOREIGN KEY (numero_conta) REFERENCES contas(numeroConta)
);

-- Tabela de Cartões
CREATE TABLE cartoes (
    numero VARCHAR(16) PRIMARY KEY,
    status ENUM('ativo', 'inativo') NOT NULL DEFAULT 'inativo',
    limite DECIMAL(15,2) NOT NULL DEFAULT 0.00,
    numero_conta INT,
    CONSTRAINT fk_cartao_conta FOREIGN KEY (numero_conta) REFERENCES contas(numeroConta)
);

-- Tabela de Empréstimos
CREATE TABLE emprestimos (
    id_emprestimo INT PRIMARY KEY AUTO_INCREMENT,
    valorEmprestimo DECIMAL(15,2) NOT NULL,
    valorParcela DECIMAL(15,2) NOT NULL,
    quantidadeParcelas INT,
    parcelasPagas INT,
    cliente_CPF_cliente VARCHAR(11) NOT NULL,
    CONSTRAINT fk_emprestimo_cliente FOREIGN KEY (cliente_CPF_cliente) REFERENCES clientes(cpf_cliente)
);

-- Inserção de Dados: Clientes
INSERT INTO clientes (cpf_cliente, nome, dataNascimento, telefone, logradouro, cidade, estado) VALUES
('11122233344', 'João Silva', '1985-05-12', '11988887777', 'Rua das Flores, 123', 'São Paulo', 'SP'),
('22233344455', 'Maria Oliveira', '1990-08-22', '21977776666', 'Av. Brasil, 500', 'Rio de Janeiro', 'RJ'),
('33344455566', 'Carlos Souza', '1978-03-15', '31966665555', 'Rua Amazonas, 45', 'Belo Horizonte', 'MG'),
('44455566677', 'Ana Costa', '1995-12-01', '41955554444', 'Rua Paraná, 88', 'Curitiba', 'PR'),
('55566677788', 'Pedro Santos', '1982-07-10', '51944443333', 'Av. Ipiranga, 1010', 'Porto Alegre', 'RS'),
('66677788899', 'Julia Lima', '2000-01-25', '61933332222', 'Setor Comercial, S/N', 'Brasília', 'DF'),
('77788899900', 'Ricardo Alves', '1970-11-30', '71922221111', 'Rua Bahia, 22', 'Salvador', 'BA'),
('88899900011', 'Fernanda Rocha', '1988-04-18', '81911110000', 'Rua do Sol, 99', 'Recife', 'PE'),
('99900011122', 'Lucas Pereira', '1992-09-05', '85999998888', 'Av. Beira Mar, 200', 'Fortaleza', 'CE'),
('00011122233', 'Beatriz Melo', '1997-06-14', '92988881111', 'Rua das Palmeiras, 30', 'Manaus', 'AM'),
('12345678901', 'Marcos Vinícius', '1980-02-28', '11955556666', 'Rua Augusta, 1500', 'São Paulo', 'SP'),
('23456789012', 'Camila Neves', '1993-10-12', '21944445555', 'Rua Copacabana, 12', 'Rio de Janeiro', 'RJ'),
('34567890123', 'Roberto Dias', '1975-05-20', '31933334444', 'Av. Contorno, 5000', 'Belo Horizonte', 'MG'),
('45678901234', 'Patrícia Gomes', '1989-01-08', '41922223333', 'Rua XV de Novembro, 10', 'Curitiba', 'PR'),
('56789012345', 'Thiago Martins', '1998-11-22', '51911112222', 'Rua dos Andradas, 200', 'Porto Alegre', 'RS');

-- Inserção de Dados: Contas
INSERT INTO contas (tipoConta, saldo, cliente_CPF_cliente) VALUES
('corrente', 1500.00, '11122233344'),
('poupanca', 5000.50, '11122233344'),
('corrente', 250.00, '22233344455'),
('empresarial', 50000.00, '33344455566'),
('poupanca', 1200.00, '44455566677'),
('corrente', 3400.00, '55566677788'),
('corrente', 10.00, '66677788899'),
('poupanca', 15000.00, '77788899900'),
('empresarial', 25000.00, '88899900011'),
('corrente', 450.75, '99900011122'),
('poupanca', 800.00, '00011122233'),
('corrente', 2100.00, '12345678901'),
('corrente', 50.00, '23456789012'),
('poupanca', 300.00, '34567890123'),
('empresarial', 100000.00, '45678901234');

-- Inserção de Dados: Transações
INSERT INTO transacoes (tipo, valor, dataTransacao, numero_conta) VALUES
('deposito', 500.00, '2023-10-01 10:00:00', 1),
('saque', 100.00, '2023-10-02 14:30:00', 1),
('transferencia', 200.00, '2023-10-03 09:15:00', 2),
('deposito', 1000.00, '2023-10-05 16:45:00', 3),
('saque', 50.00, '2023-10-06 11:00:00', 4),
('transferencia', 1500.00, '2023-10-07 13:20:00', 4),
('deposito', 300.00, '2023-10-08 17:00:00', 5),
('saque', 20.00, '2023-10-09 08:00:00', 6),
('deposito', 2000.00, '2023-10-10 12:00:00', 7),
('transferencia', 100.00, '2023-10-11 15:30:00', 8),
('saque', 400.00, '2023-10-12 10:10:00', 9),
('deposito', 50.00, '2023-10-13 09:00:00', 10),
('transferencia', 1000.00, '2023-10-14 14:00:00', 15),
('saque', 200.00, '2023-10-15 11:30:00', 12),
('deposito', 150.00, '2023-10-16 16:00:00', 13);

-- Inserção de Dados: Cartões
INSERT INTO cartoes (numero, status, limite, numero_conta) VALUES
('1234567812345678', 'ativo', 2000.00, 1),
('2345678923456789', 'ativo', 5000.00, 2),
('3456789034567890', 'inativo', 0.00, 3),
('4567890145678901', 'ativo', 10000.00, 4),
('5678901256789012', 'ativo', 1500.00, 5),
('6789012367890123', 'inativo', 0.00, 6),
('7890123478901234', 'ativo', 3000.00, 7),
('8901234589012345', 'ativo', 8000.00, 8),
('9012345690123456', 'ativo', 15000.00, 9),
('0123456701234567', 'inativo', 0.00, 10),
('1122334455667788', 'ativo', 2500.00, 11),
('2233445566778899', 'ativo', 4000.00, 12),
('3344556677889900', 'inativo', 0.00, 13),
('4455667788990011', 'ativo', 600.00, 14),
('5566778899001122', 'ativo', 50000.00, 15);

-- Inserção de Dados: Empréstimos
INSERT INTO emprestimos (valorEmprestimo, valorParcela, quantidadeParcelas, parcelasPagas, cliente_CPF_cliente) VALUES
(5000.00, 550.00, 12, 2, '11122233344'),
(10000.00, 1100.00, 12, 5, '22233344455'),
(50000.00, 2500.00, 24, 0, '33344455566'),
(2000.00, 210.00, 10, 8, '44455566677'),
(3000.00, 350.00, 12, 1, '55566677788'),
(15000.00, 1800.00, 10, 3, '66677788899'),
(8000.00, 850.00, 12, 6, '77788899900'),
(20000.00, 1200.00, 24, 12, '88899900011'),
(1200.00, 150.00, 10, 5, '99900011122'),
(4500.00, 480.00, 12, 0, '00011122233'),
(7000.00, 750.00, 12, 4, '12345678901'),
(1000.00, 110.00, 10, 9, '23456789012'),
(9000.00, 1000.00, 12, 2, '34567890123'),
(2500.00, 300.00, 10, 0, '45678901234'),
(150000.00, 5000.00, 48, 10, '56789012345');

-- Views para Análise de Dados

-- 1. Clientes e suas respectivas contas
CREATE VIEW clientes_contas AS
SELECT 
    cl.nome AS Clientes, 
    cl.cpf_cliente AS CPF, 
    co.numeroConta AS 'N° Conta',
    co.tipoConta AS Tipo, 
    co.saldo AS Saldo
FROM clientes cl
JOIN contas co ON cl.cpf_cliente = co.cliente_CPF_cliente
ORDER BY cl.nome;

-- 2. Clientes da região Sudeste
CREATE VIEW clientes_sudeste AS
SELECT 
    cl.nome, 
    cl.logradouro, 
    cl.cidade, 
    cl.estado
FROM clientes AS cl
WHERE cl.estado IN ('SP', 'RJ', 'MG', 'ES')
ORDER BY estado;

-- 3. Clientes com empréstimos acima de R$ 6.000,00
CREATE VIEW ClientesEmprestimosMaiorQue6000 AS
SELECT
    cl.nome AS Clientes,
    cl.cpf_cliente AS CPF,
    em.valorEmprestimo AS Valor,
    em.valorParcela AS 'Valor Parcela'
FROM clientes cl
JOIN emprestimos em ON cl.cpf_cliente = em.cliente_CPF_cliente
WHERE em.valorEmprestimo >= 6000.00
ORDER BY em.valorEmprestimo;

-- Consultas de Teste
SELECT * FROM clientes_contas;
SELECT * FROM clientes_sudeste;
SELECT * FROM ClientesEmprestimosMaiorQue6000;
