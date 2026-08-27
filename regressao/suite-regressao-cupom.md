# Suíte de Regressão — Correção de bug em cupom (JIRA-158)

**Contexto do ticket:** "Bug corrigido: cupom estava sendo aplicado mesmo em carrinho vazio. Corrigido para bloquear essa ação."

Classificação de todos os casos de teste existentes (login + integração de cupom), avaliando prioridade e relação com a área alterada (`/cart/coupon`), para decidir quais entram na rodada de regressão.

| ID | Cenário | Prioridade | Entra na regressão? | Por quê |
|---|---|---|---|---|
| TC-001 | Login com credenciais válidas | Crítico | Sim | Pré-requisito técnico — sem login não é possível acessar carrinho/checkout |
| TC-002 | Login com senha inválida | Alto | Não | Tem relação com a área, mas não afeta o bug corrigido no carrinho |
| TC-004 | Login com username inválido | Alto | Não | Idem acima |
| TC-005 | Login com username vazio | Médio | Não | Idem acima |
| TC-006 | Login com password vazio | Médio | Não | Idem acima |
| TC-007 | Login com username e password vazios | Baixo | Não | Idem acima |
| TC-008 | Login com usuário bloqueado | Alto | Não | Idem acima |
| TC-009 | Login com usuário com bug visual | Baixo | Não | Idem acima |
| TC-010 | Login com usuário com lentidão | Baixo | Não | Idem acima |
| TC-011 | Login com usuário error_user | Médio | Não | Idem acima |
| TC-101 | Checkout com cupom válido (valor decimal) | Crítico | Sim | Mesma área — verificar se a correção não alterou o cálculo com valores decimais |
| TC-102 | Checkout com cupom válido (valor redondo) | Alto | Sim | Mesma área — verificar cálculo com valor redondo |
| TC-103 | Checkout com cupom expirado | Alto | Sim | Mesma área — verificar se a correção não alterou o critério de aceite para cupom expirado |
| TC-104 | Checkout com cupom inexistente | Alto | Sim | Mesma área — verificar se a correção não alterou o critério de aceite para cupom inexistente |
| TC-105 | Checkout sem cupom (fluxo padrão) | Crítico | Sim | Mesma área — verificar se a correção não alterou o fluxo padrão de checkout |
| TC-106 | Cupom com campo "code" vazio | Médio | Sim | Mesmo endpoint alterado (`/cart/coupon`) — verificar se a correção não afetou essa validação já existente |
| TC-107 | Carrinho vazio com cupom válido | Alta | Sim | É o foco do teste regressivo — valida diretamente se o bug do carrinho vazio foi corrigido |

## Ordem de execução sugerida

1. **TC-001** — pré-requisito (login)
2. **TC-107** — validação direta da correção do bug (mais crítico para este ticket)
3. **TC-105** — fluxo padrão de checkout (sem cupom)
4. **TC-101** — cupom válido, valor decimal
5. **TC-102** — cupom válido, valor redondo (controle)
6. **TC-103** — cupom expirado
7. **TC-104** — cupom inexistente
8. **TC-106** — campo "code" vazio

## Resultado da regressão

O **TC-107 reprovou**: o sistema não bloqueou a aplicação de cupom em carrinho vazio, indicando que a correção reportada no ticket JIRA-158 não está efetiva neste ambiente/versão testada.
