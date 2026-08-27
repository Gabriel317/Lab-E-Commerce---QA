-- ============================================================
-- Queries SQL de validação — E-commerce de treino (PostgreSQL)
-- Usadas para confirmar, diretamente no banco, dados manipulados
-- pela API durante os testes de integração.
-- ============================================================

-- Listar todas as tabelas do banco (ponto de partida para explorar o schema)
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';

-- Listar produtos com preço abaixo de R$ 50
SELECT *
FROM products
WHERE price < 50;

-- Buscar produtos pelo nome, ignorando maiúsculas/minúsculas
-- (ILIKE é case-insensitive no PostgreSQL; LIKE não é)
SELECT *
FROM products
WHERE name ILIKE '%cupom%';

-- Top 3 produtos mais caros
SELECT name, price
FROM products
ORDER BY price DESC
LIMIT 3;

-- Nome do produto e quantidade de cada item de carrinho
-- (JOIN entre cart_items e products, ligando product_id -> id)
SELECT products.name, cart_items.quantity
FROM products
JOIN cart_items ON products.id = cart_items.product_id;

-- Itens de carrinho com quantidade maior que 1
SELECT products.name, cart_items.quantity
FROM products
JOIN cart_items ON products.id = cart_items.product_id
WHERE cart_items.quantity > 1;

-- Pedidos agrupados por status (quantos existem de cada)
SELECT status, COUNT(*)
FROM orders
GROUP BY status;

-- Pedidos de um usuário específico, agrupados por status
SELECT status, COUNT(*)
FROM orders
WHERE user_id = 13
GROUP BY status;

-- Usuários com mais de 1 pedido
SELECT user_id, COUNT(*)
FROM orders
GROUP BY user_id
HAVING COUNT(*) > 1;

-- Pedido + e-mail do usuário que fez o pedido (JOIN orders -> users)
SELECT orders.id AS order_id, orders.status, users.email, users.name
FROM orders
JOIN users ON orders.user_id = users.id;

-- Todos os pedidos, ordenados do maior para o menor valor
SELECT *
FROM orders
ORDER BY total DESC;

-- Consulta combinada: pedidos "CRIADO", com e-mail do usuário,
-- ordenados do maior para o menor total
SELECT orders.id, users.email, orders.status, orders.total
FROM orders
JOIN users ON orders.user_id = users.id
WHERE orders.status = 'CRIADO'
ORDER BY orders.total DESC;
