# Lab E-Commerce (QA-Estudos) — Gabriel de Faria

## Sobre mim

Reforçando meus conhecimentos na área de QA, com foco em testes manuais, exploratórios, de integração e regressão, além de fundamentos de SQL e testes de API.

## Este repositório reúne exercícios práticos de teste de software desenvolvidos durante meus estudos.

## O que este repositório demonstra

- **Testes manuais**: escrita de casos de teste estruturados (pré-condição, passos, dados de entrada, resultado esperado/obtido, status)
- **Testes exploratórios**: sessões documentadas com charter, notas, bugs encontrados e cobertura (Session-Based Test Management)
- **Testes de integração via API**: validação de fluxos entre módulos (autenticação, carrinho, cupom de desconto, checkout) usando Postman
- **Testes de regressão**: priorização e seleção de casos de teste com base em uma mudança/correção de bug
- **Validação de dados via SQL**: queries para confirmar, diretamente no banco, que os dados manipulados pela API estão corretos

## Ferramentas utilizadas

- **Postman** — testes de API (requisições, autenticação JWT, assertions)
- **DBeaver** — consultas SQL em banco PostgreSQL
- **Swagger/OpenAPI** — leitura de documentação de API

## Projeto testado

Aplicação de e-commerce (ambiente de treino), com back-end em API REST (módulos de autenticação, produtos, carrinho e pedidos) e banco de dados PostgreSQL, rodando em containers Docker.

## Estrutura do repositório

```
casos-de-teste/         → casos de teste de login e de integração (cupom/checkout)
sessoes-exploratorias/  → sessões de teste exploratório documentadas
regressao/              → suíte de regressão com priorização de casos
sql/                    → queries SQL usadas para validação de dados
```


