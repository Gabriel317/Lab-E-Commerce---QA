# Sessões de Teste Exploratório

Sessões documentadas no formato Session-Based Test Management (charter, notas, bugs, cobertura).

---

## ET-002 — Login (saucedemo.com)

**Tester:** Gabriel de Faria
**Duração:** 30 min

**Charter:** Explorar a tela de login, analisando comportamento dos campos e botões.

**Notas da sessão:**
- Login com senha inválida → mensagem "Epic sadface: Username and password do not match any user in this service", login não autorizado.
- Login com username e password vazios → mensagem "Epic sadface: Username is required".
- Login com password vazio → mensagem "Epic sadface: Password is required".
- Login com senha correta, mas username em maiúsculo → mensagem de credenciais inválidas (mesma do primeiro item).

**Observação/Dúvida:**
Login não aceita username com maiúsculas (case-sensitive). Não fica claro se é comportamento intencional (case-sensitive por design) ou se deveria aceitar independente de maiúsculo/minúsculo — a confirmar com o time antes de tratar como bug.

**Cobertura:**
- ✅ Campos vazios/incompletos (username, password, ambos)
- ✅ Case-sensitivity do username
- Não testado: espaços em branco antes/depois do username; login com tecla Enter; comportamento com copiar/colar credenciais

---

## Bug documentado durante exploração no fluxo de checkout (error_user)

### BUG-001 — Checkout avança sem preencher campo "Last Name" obrigatório (usuário error_user)

**Passos para reproduzir:**
1. Logar com `error_user` / `secret_sauce`
2. Adicionar produto ao carrinho e ir para checkout
3. Deixar o campo "Last Name" vazio
4. Clicar em "Continue"

**Resultado obtido:** sistema avança para a próxima etapa mesmo com campo obrigatório vazio, mas depois trava e não permite finalizar no botão "Finish".
**Resultado esperado:** sistema deveria bloquear o avanço e exibir mensagem pedindo o preenchimento do campo, permitindo prosseguir apenas após a correção.
**Severidade:** Alta (bloqueia finalização de compra).

> Esse bug foi identificado durante a execução do caso `TC-011` (login com error_user), ao continuar explorando o fluxo além do login — ilustra como testes exploratórios podem surgir a partir de um caso formal.
