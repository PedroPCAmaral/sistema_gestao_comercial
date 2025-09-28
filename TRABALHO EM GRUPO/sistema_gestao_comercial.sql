-- ==========================================
-- Banco de dados: Sistema de Gestão Comercial
-- ==========================================

-- 1. Criar banco de dados
CREATE DATABASE IF NOT EXISTS sistema_gestao_comercial;
USE sistema_gestao_comercial;

-- ==========================================
-- 2. Tabelas
-- ==========================================

-- Tabela Clientes
CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    endereco VARCHAR(200),
    data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Tabela Projetos
CREATE TABLE Projetos (
    id_projeto INT AUTO_INCREMENT PRIMARY KEY,
    nome_projeto VARCHAR(100) NOT NULL,
    descricao TEXT,
    id_cliente INT NOT NULL,
    data_inicio DATETIME NOT NULL,
    data_fim DATETIME,
    status VARCHAR(20) DEFAULT 'Em andamento',
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- Tabela Tarefas
CREATE TABLE Tarefas (
    id_tarefa INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    descricao TEXT,
    id_projeto INT NOT NULL,
    responsavel VARCHAR(100),
    data_inicio DATETIME,
    data_fim DATETIME,
    status VARCHAR(20) DEFAULT 'Pendente',
    FOREIGN KEY (id_projeto) REFERENCES Projetos(id_projeto)
);

-- Tabela Pagamentos
CREATE TABLE Pagamentos (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    data_pagamento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    metodo_pagamento VARCHAR(50),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- ==========================================
-- 3. Inserção de dados de exemplo
-- ==========================================

-- Clientes
INSERT INTO Clientes (nome, email, telefone, endereco) VALUES
('João Silva', 'joao@email.com', '11988887777', 'Rua A, 123, São Paulo'),
('Maria Oliveira', 'maria@email.com', '11977776666', 'Rua B, 456, Rio de Janeiro');

-- Projetos
INSERT INTO Projetos (nome_projeto, descricao, id_cliente, data_inicio) VALUES
('Sistema ERP', 'Desenvolvimento de ERP para gestão financeira', 1, NOW()),
('Website Institucional', 'Criação de site para divulgação da empresa', 2, NOW());

-- Tarefas
INSERT INTO Tarefas (titulo, descricao, id_projeto, responsavel, data_inicio) VALUES
('Planejamento', 'Definir escopo e cronograma', 1, 'Carlos', NOW()),
('Desenvolvimento Frontend', 'Criar telas do sistema', 1, 'Ana', NOW()),
('Criação do Layout', 'Desenvolver layout do site', 2, 'Rafael', NOW());

-- Pagamentos
INSERT INTO Pagamentos (id_cliente, valor, metodo_pagamento) VALUES
(1, 1500.00, 'Boleto'),
(2, 800.00, 'Cartão');

-- ==========================================
-- 4. Consultas de exemplo
-- ==========================================

-- Listar todos os clientes
SELECT * FROM Clientes;

-- Listar projetos de um cliente
SELECT * FROM Projetos WHERE id_cliente = 1;

-- Listar tarefas de um projeto
SELECT * FROM Tarefas WHERE id_projeto = 1;

-- Total de pagamentos de um cliente
SELECT id_cliente, SUM(valor) AS total_pago FROM Pagamentos GROUP BY id_cliente;

-- ==========================================
-- 5. Atualizações de exemplo
-- ==========================================

-- Atualizar status de projeto
UPDATE Projetos SET status = 'Concluído' WHERE id_projeto = 1;

-- Atualizar status de tarefa
UPDATE Tarefas SET status = 'Concluída' WHERE id_tarefa = 1;

-- by Pedro Amaral