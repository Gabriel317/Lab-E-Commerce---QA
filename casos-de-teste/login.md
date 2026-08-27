# Casos de Teste — Login (saucedemo.com)

Suíte de casos de teste manuais para a funcionalidade de login, cobrindo cenários positivos, negativos e usuários especiais do sistema.

---

### TC-001 — Login com credenciais válidas
**Pré-condição:** usuário na tela de login, deslogado
**Passos:**
1. Inserir usuário no campo "Username"
2. Inserir senha no campo "Password"
3. Clicar no botão "Login"

**Dados de entrada:**
- Username: `standard_user`
- Password: `secret_sauce`

**Resultado esperado:** sistema redireciona para a tela de produtos (inventory.html), exibindo a lista de itens.

---

### TC-002 — Login com senha inválida
**Pré-condição:** usuário na tela de login, deslogado
**Passos:**
1. Inserir usuário no campo "Username"
2. Inserir senha no campo "Password"
3. Clicar no botão "Login"

**Dados de entrada:**
- Username: `standard_user`
- Password: `senha_errada_123`

**Resultado esperado:** sistema exibe mensagem de erro "Epic sadface: Username and password do not match any user in this service" e permanece na tela de login.

---

### TC-004 — Login com username inválido (não cadastrado)
**Pré-condição:** usuário na tela de login, deslogado
**Dados de entrada:**
- Username: `teste01`
- Password: `teste01`

**Resultado esperado:** sistema exibe mensagem de erro "Epic sadface: Username and password do not match any user in this service" e permanece na tela de login.

---

### TC-005 — Login com username vazio
**Dados de entrada:**
- Username: *(vazio)*
- Password: `teste01`

**Resultado esperado:** sistema exibe mensagem "Epic sadface: Username is required" e permanece na tela de login.

---

### TC-006 — Login com password vazio
**Dados de entrada:**
- Username: `standard_user`
- Password: *(vazio)*

**Resultado esperado:** sistema exibe mensagem "Epic sadface: Password is required" e permanece na tela de login.

---

### TC-007 — Login com username e password vazios
**Dados de entrada:**
- Username: *(vazio)*
- Password: *(vazio)*

**Resultado esperado:** sistema exibe mensagem "Epic sadface: Username is required" (a validação do username ocorre primeiro).

---

### TC-008 — Login com usuário bloqueado
**Dados de entrada:**
- Username: `locked_out_user`
- Password: `secret_sauce`

**Resultado esperado:** sistema exibe mensagem "Epic sadface: Sorry, this user has been locked out." e permanece na tela de login.

---

### TC-009 — Login com usuário com bug visual (problem_user)
**Dados de entrada:**
- Username: `problem_user`
- Password: `secret_sauce`

**Resultado esperado:** sistema redireciona para a tela de produtos (inventory.html) com login bem-sucedido. Porém, todas as imagens dos produtos exibem a mesma imagem incorreta (foto de cachorro), ao invés das imagens específicas de cada item.

---

### TC-010 — Login com usuário com lentidão (performance_glitch_user)
**Dados de entrada:**
- Username: `performance_glitch_user`
- Password: `secret_sauce`

**Resultado esperado:** sistema redireciona para a tela de produtos com login bem-sucedido, porém o carregamento leva significativamente mais tempo que o normal.

---

### TC-011 — Login com usuário error_user
**Dados de entrada:**
- Username: `error_user`
- Password: `secret_sauce`

**Resultado esperado (hipótese):** sistema exibiria mensagem de erro e permaneceria na tela de login.
**Resultado obtido:** sistema realiza login com sucesso e redireciona para a tela de produtos, sem exibir erro.
**Status:** Falhou em relação à hipótese inicial, mas sem impacto negativo aparente no login em si.

> **Achado relacionado:** ao prosseguir para o checkout com esse usuário, identificado um bug documentado separadamente — ver `BUG-001` nas sessões exploratórias.
