CREATE DATABASE IF NOT EXISTS techstore;
USE techstore;

-- ========================
-- CLIENTE
-- ========================
CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    cpf VARCHAR(11) UNIQUE,
    telefone VARCHAR(15),
    data_cadastro DATETIME NOT NULL
);

-- ========================
-- ENDERECO
-- ========================
CREATE TABLE endereco (
    id_endereco INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    rua VARCHAR(100),
    numero VARCHAR(10),
    cidade VARCHAR(50),
    estado VARCHAR(2),
    cep VARCHAR(8),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- ========================
-- CATEGORIA
-- ========================
CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50)
);

-- ========================
-- PRODUTO
-- ========================
CREATE TABLE produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2),
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

-- ========================
-- FORNECEDOR
-- ========================
CREATE TABLE fornecedor (
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    cnpj VARCHAR(14) UNIQUE
);

-- ========================
-- PRODUTO_FORNECEDOR (N:N)
-- ========================
CREATE TABLE produto_fornecedor (
    id_produto INT NOT NULL,
    id_fornecedor INT NOT NULL,
    preco_fornecedor DECIMAL(10,2),
    PRIMARY KEY (id_produto, id_fornecedor),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor)
);

-- ========================
-- ESTOQUE (1:1)
-- ========================
CREATE TABLE estoque (
    id_produto INT PRIMARY KEY,
    quantidade INT NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

-- ========================
-- PEDIDO
-- ========================
CREATE TABLE pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    data_pedido DATETIME,
    status VARCHAR(20),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- ========================
-- PEDIDO_ITEM
-- ========================
CREATE TABLE pedido_item (
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT,
    preco_unitario DECIMAL(10,2),
    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

-- ========================
-- PAGAMENTO
-- ========================
CREATE TABLE pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    tipo VARCHAR(20),
    status VARCHAR(20),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);

-- ========================
-- TRANSPORTADORA
-- ========================
CREATE TABLE transportadora (
    id_transportadora INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100)
);

-- ========================
-- ENTREGA
-- ========================
CREATE TABLE entrega (
    id_entrega INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_transportadora INT,
    codigo_rastreio VARCHAR(50),
    status VARCHAR(20),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_transportadora) REFERENCES transportadora(id_transportadora)
);

-- ========================================
-- CARGA DE DADOS DE TESTE
-- ========================================

-- CLIENTES
INSERT INTO cliente (nome, email, cpf, telefone, data_cadastro) VALUES
('Luisa Pereira', 'luisa@email.com', '12345678901', '11999999999', NOW()),
('João Silva', 'joao@email.com', '98765432100', '11988888888', NOW()),
('Maria Souza', 'maria@email.com', '11122233344', '11977777777', NOW());

-- ENDERECOS
INSERT INTO endereco (id_cliente, rua, numero, cidade, estado, cep) VALUES
(1, 'Rua A', '100', 'São Paulo', 'SP', '01000000'),
(2, 'Rua B', '200', 'Rio de Janeiro', 'RJ', '20000000'),
(3, 'Rua C', '300', 'Belo Horizonte', 'MG', '30000000');

-- CATEGORIAS
INSERT INTO categoria (nome) VALUES
('Notebook'),
('Celular'),
('Acessórios');

-- PRODUTOS
INSERT INTO produto (nome, descricao, preco, id_categoria) VALUES
('Notebook Dell', 'Notebook i5', 3500.00, 1),
('iPhone 14', 'Smartphone Apple', 6000.00, 2),
('Mouse Logitech', 'Mouse sem fio', 150.00, 3);

-- FORNECEDORES
INSERT INTO fornecedor (nome, cnpj) VALUES
('Fornecedor Tech', '12345678000100'),
('Distribuidora Digital', '98765432000100');

-- PRODUTO_FORNECEDOR
INSERT INTO produto_fornecedor VALUES
(1, 1, 3000.00),
(2, 2, 5500.00),
(3, 1, 100.00);

-- ESTOQUE
INSERT INTO estoque VALUES
(1, 10),
(2, 5),
(3, 20);

-- PEDIDOS
INSERT INTO pedido (id_cliente, data_pedido, status) VALUES
(1, NOW(), 'Concluído'),
(2, NOW(), 'Pendente');

-- PEDIDO_ITEM
INSERT INTO pedido_item VALUES
(1, 1, 1, 3500.00),
(1, 3, 2, 150.00),
(2, 2, 1, 6000.00);

-- PAGAMENTOS
INSERT INTO pagamento (id_pedido, tipo, status) VALUES
(1, 'PIX', 'Aprovado'),
(2, 'Cartão', 'Pendente');

-- TRANSPORTADORA
INSERT INTO transportadora (nome) VALUES
('Correios'),
('Transportadora X');

-- ENTREGA
INSERT INTO entrega (id_pedido, id_transportadora, codigo_rastreio, status) VALUES
(1, 1, 'BR123456789', 'Entregue'),
(2, 2, 'BR987654321', 'Em transporte');