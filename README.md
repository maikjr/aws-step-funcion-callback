Claro! Aqui está um exemplo de `README.md` para o seu repositório GitHub, com todas as instruções e explicações necessárias:

---

# 🛠️ Ambiente Local com LocalStack e Step Functions

Este projeto simula o uso de AWS Step Functions em ambiente local utilizando o [LocalStack](https://github.com/localstack/localstack). Ele executa lambdas e fluxos de orquestração para testes e desenvolvimento local.

## 📦 Pré-requisitos

- Docker instalado e funcionando
- Node.js e NPM instalados
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- [AWS Local CLI (awslocal)](https://github.com/localstack/awscli-local)

## 🚀 Como subir o ambiente local

### 1. Instale as dependências das Lambdas

Acesse a pasta `/lambdas` e execute:

```bash
npm install
```

### 2. Suba o LocalStack com Docker Compose

Na raiz do projeto, execute:

```bash
docker-compose up
```

Isso iniciará o LocalStack com os serviços necessários.

### 3. Execute o setup inicial do LocalStack

Rode o script de setup localizado em `setup-localstack`:

```bash
./setup-localstack/setup
```

Esse script cria e configura os recursos necessários no LocalStack, como a state machine e permissões simuladas.

---

## ✅ Comandos Úteis com `awslocal`

### 1. Iniciar uma execução da State Machine

```bash
awslocal stepfunctions start-execution \
  --state-machine-arn arn:aws:states:us-east-1:000000000000:stateMachine:MinhaCallbackStepFunction \
  --input '{"usuarioId": "abc123", "acao": "disparar"}'
```

**Descrição:** Inicia a execução da state machine `MinhaCallbackStepFunction` com um JSON de entrada simulando uma ação do usuário.

---

### 2. Listar as State Machines criadas

```bash
awslocal stepfunctions list-state-machines
```

**Descrição:** Exibe todas as state machines registradas no ambiente local do LocalStack.

---

### 3. Simular o retorno (callback) de uma tarefa

```bash
awslocal stepfunctions send-task-success \
  --task-token "TASKTOKEN_AQUI" \
  --task-output '{"resultado": "callback recebido"}'
```

**Descrição:** Envia uma resposta de sucesso para uma task pausada aguardando callback (por exemplo, via `Task.waitForTaskToken`). Substitua `"TASKTOKEN_AQUI"` pelo token retornado no `get-execution-history`.

---

### 4. Ver o histórico de execução

```bash
awslocal stepfunctions get-execution-history \
  --execution-arn <ARN_DA_EXECUCAO>
```

**Descrição:** Exibe o histórico completo da execução, incluindo transições entre estados, falhas e callbacks recebidos.

---

## 🧪 Exemplo de fluxo esperado

1. Você inicia uma execução da step function com `start-execution`.
2. A execução entra em um estado que espera um callback (`Task Token`).
3. Você envia o callback com `send-task-success`.
4. A execução continua e você pode acompanhar tudo com `get-execution-history`.

---

## 📂 Estrutura do Projeto

```
/lambdas              # Código das funções lambda
/setup-localstack     # Script de setup para criar os recursos no LocalStack
/docker-compose.yml   # Configuração do LocalStack
```

---

## 📌 Observações

- Este projeto é voltado para testes locais. Nada será de fato enviado para a AWS.
- Ideal para desenvolvimento e simulação de fluxos complexos com Step Functions e callbacks.

---
