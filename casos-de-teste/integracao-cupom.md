# Casos de Teste de Integração — Cupom de Desconto e Checkout

Testes de integração via API (Postman), validando o fluxo de carrinho, aplicação de cupom e checkout no e-commerce de treino. Autenticação via JWT, com papéis CLIENTE e ADMIN.

**Escopo:** Auth → Products → Cart → Orders

---

### TC-101 — Checkout com cupom válido (valor decimal)
**Pré-condição:** usuário CLIENTE autenticado, carrinho com produtos de valores decimais
**Passos:**
1. `POST /cart/items` — adicionar produtos
2. `GET /cart` — anotar valor antes do cupom
3. `POST /cart/coupon` — aplicar cupom
4. `GET /cart` — anotar valor após o cupom
5. `POST /orders` — checkout
6. `GET /orders/{id}` — conferir valor final

**Dados de entrada:**
- Cupom: `FUTURO10` (10% de desconto)
- Valor do carrinho antes do cupom: R$ 3.399,58

**Resultado esperado:** desconto de R$ 339,96 (arredondamento padrão), total R$ 3.059,62; valor do pedido idêntico ao do carrinho.
**Resultado obtido:** desconto aplicado de R$ 339,95 (1 centavo a menos que o arredondamento padrão); total R$ 3.059,63; valor do pedido bateu exatamente com o valor final do carrinho.
**Status:** Aprovado, com observação de divergência de R$ 0,01 no cálculo do desconto — ver observação abaixo.

---

### TC-102 — Checkout com cupom válido (valor redondo, controle)
**Objetivo:** confirmar se a divergência do TC-101 é sistemática ou específica de valores decimais.

**Dados de entrada:**
- Cupom: `FUTURO10`
- Valor do carrinho antes do cupom: R$ 100,00

**Resultado esperado:** desconto de R$ 10,00, total R$ 90,00.
**Resultado obtido:** desconto de R$ 10,00, total R$ 90,00 — exato, sem divergência.
**Status:** Aprovado.

> **Observação (TC-101 + TC-102):** a divergência de R$ 0,01 não é sistemática — só ocorreu com carrinho de múltiplos itens e valores decimais (R$ 3.399,58). Hipótese: arredondamento aplicado por item, não sobre o total consolidado. Severidade: baixa, mas relevante para precisão financeira em escala.

---

### TC-103 — Checkout com cupom expirado
**Dados de entrada:**
- Cupom: `DESCONTO10` (expirado)
- Valor do carrinho antes do cupom: R$ 200,00

**Resultado esperado:** cupom expirado não é aplicado; valor final do carrinho não alterado.
**Resultado obtido:** API retornou `400 Bad Request`, mensagem "Cupom expirado"; valor do carrinho permaneceu R$ 200,00.
**Status:** Aprovado.

---

### TC-104 — Checkout com cupom inexistente
**Dados de entrada:**
- Cupom: `TESTE2026` (inexistente)
- Valor do carrinho antes do cupom: R$ 200,00

**Resultado esperado:** cupom inexistente não é aplicado (erro 400); valor final do carrinho permanece sem desconto.
**Resultado obtido:** API retornou `400 Bad Request`, mensagem "Cupom não encontrado"; valor do carrinho permaneceu R$ 200,00.
**Status:** Aprovado.

---

### TC-105 — Checkout sem cupom (fluxo padrão)
**Objetivo:** confirmar que o fluxo de checkout sem cupom (já existente antes da feature) não foi quebrado.
**Passos:** `POST /cart/items` → `GET /cart` → `POST /orders` (checkout direto, sem tocar em `/cart/coupon`) → `GET /orders/{id}`

**Dados de entrada:** valor do carrinho R$ 200,00
**Resultado esperado:** checkout concluído com sucesso, sem desconto; valor do pedido idêntico ao do carrinho.
**Resultado obtido:** pedido criado com sucesso (status "CRIADO"), total R$ 200,00, discount R$ 0,00, couponCode null.
**Status:** Aprovado.

---

### TC-106 — Cupom com campo "code" vazio
**Dados de entrada:** campo `code` enviado vazio em `POST /cart/coupon`
**Resultado esperado:** API retorna erro 400; valor do carrinho permanece sem desconto.
**Resultado obtido:** API retornou `400 Bad Request`, mensagem "code: code is required"; valor do carrinho não alterado.
**Status:** Aprovado.

---

### TC-107 — Carrinho vazio com cupom válido
**Contexto:** validação da correção do bug reportado em JIRA-158 ("cupom estava sendo aplicado mesmo em carrinho vazio").
**Pré-condição:** usuário CLIENTE autenticado, carrinho vazio
**Passos:**
1. `GET /cart` — confirmar carrinho vazio
2. `POST /cart/coupon` — aplicar cupom válido

**Dados de entrada:** cupom `FUTURO10`
**Resultado esperado:** API retorna erro 400, bloqueando a aplicação de cupom em carrinho vazio.
**Resultado obtido:** API retornou `200 OK`; cupom foi aplicado (`appliedCouponCode: "FUTURO10"`), mesmo com carrinho vazio.
**Status:** **Reprovado.** A correção do bug JIRA-158 não está funcionando neste ambiente/versão testada. Severidade sugerida: Alta (indica possível falha maior de validação, mesmo sem prejuízo financeiro direto neste teste).

---

### TC-108 — Consistência entre valor exibido no front-end e retornado pela API ao aplicar cupom
**Pré-condição:** usuário CLIENTE logado pela interface, carrinho com produto adicionado.
**Ferramentas/Ambiente:** DevTools aberto (aba Network, filtro Fetch/XHR, Keep log ativado).

**Passos:**
1. Realizar login com dados válidos
2. Clicar em Produtos
3. Adicionar produto ao carrinho
4. Clicar em Carrinho
5. Aplicar cupom
6. Verificar valores exibidos na tela (subtotal, desconto, total)
7. Na aba Network do DevTools, localizar a requisição `POST /cart/coupon` e conferir os valores da Response
8. Comparar os valores da tela com os valores da API

**Dados de entrada:**
- Cupom: `FUTURO10` (10% de desconto)
- Produto de valor R$ 100,00

**Resultado esperado:**
- Tela exibe subtotal, desconto e total corretos
- Valor exibido na tela deve ser idêntico ao valor retornado pela API na resposta de `POST /cart/coupon` (aba Network)

**Resultado obtido:**
- Tela exibiu: Subtotal R$ 100,00, Desconto R$ 10,00, Total R$ 90,00
- API retornou (aba Network, Response): `subtotal: 100.00, discount: 10.00, total: 90.00`
- Valores idênticos entre tela e API

**Status:** Aprovado

> **Observação:** este caso complementa o TC-101/TC-102 (que validam o cálculo via API isolada) ao confirmar também a integração entre front-end e back-end — ou seja, que a interface exibe fielmente o que a API calcula, sem divergência introduzida na camada de apresentação.
