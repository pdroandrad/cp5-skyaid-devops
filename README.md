# SkyAid 🚁

## 📌 Descrição do Projeto

O **SkyAid** é uma solução inovadora que utiliza **drones autônomos** para **resgate de vítimas** e **entrega de suprimentos** em áreas isoladas por desastres naturais, como enchentes e deslizamentos.  

Este repositório contém a **API RESTful** desenvolvida em **Java com Spring Boot**, responsável por gerenciar **drones**, **missões**, **operadores** e **registros de sensores**, garantindo uma operação **coordenada**, **eficiente** e **segura**.  

A aplicação possibilita:
- Cadastro e autenticação de operadores;
- Gerenciamento completo de drones e missões;
- Acompanhamento de status das missões (em andamento, concluída, cancelada);
- Registro e monitoramento de dados de sensores (temperatura, altitude, etc.);
- Integração com banco de dados SQL hospedado na **Azure Cloud**;
- Documentação e testes interativos via **Swagger UI**.

## Integrantes
- Pedro Abrantes Andrade | RM558186
- Ricardo Tavares de Oliveira Filho | RM556092
- Victor Alves Carmona | RM555726

## 🧱 Tecnologias Utilizadas

- **Java 21**  
- **Spring Boot 3.5.0**  
- **Maven**  
- **Spring Data JPA**  
- **Bean Validation (Jakarta Validation)**  
- **Oracle Database / Azure SQL**  
- **Swagger / OpenAPI**  
- **Render (Deploy em Nuvem)**  
- **Azure CLI & GitHub Actions (CI/CD)** 

## 📂 Estrutura do Projeto

| Pacote         | Descrição                                           |
| -------------- | --------------------------------------------------- |
| `model`        | Entidades JPA mapeando as tabelas do banco de dados |
| `repository`   | Interfaces Spring Data JPA para persistência        |
| `service`      | Camada de regras de negócio                         |
| `controller`   | Endpoints REST da API                               |
| `dto.request`  | Objetos de requisição (entrada de dados)            |
| `dto.response` | Objetos de resposta (saída de dados)                |
| `util`         | Enumerações (StatusDrone, StatusMissao, etc.)       |
| `exception`    | Tratamento global de exceções                       |

## 🌐 Endpoints da API

### 🚁 Drones (/api/drones)
| Método | Endpoint                      | Descrição                                         |
| ------ | ----------------------------- | ------------------------------------------------- |
| GET    | `/api/drones`                 | Lista todos os drones                             |
| GET    | `/api/drones/{id}`            | Busca drone por ID                                |
| GET    | `/api/drones/status/{status}` | Filtra drones por status (DISPONIVEL, EM_MISSAO)  |
| POST   | `/api/drones`                 | Cria um novo drone                                |
| PUT    | `/api/drones/{id}`            | Atualiza dados de um drone                        |
| DELETE | `/api/drones/{id}`            | Remove um drone                                   |

### 🎯 Missões (/api/missoes)
| Método | Endpoint                       | Descrição                                            |
| ------ | ------------------------------ | ---------------------------------------------------- |
| GET    | `/api/missoes`                 | Lista todas as missões                               |
| GET    | `/api/missoes/{id}`            | Busca missão por ID                                  |
| GET    | `/api/missoes/status/{status}` | Filtra missões por status (EM_ANDAMENTO, CONCLUIDA)  |
| GET    | `/api/missoes/tipo/{tipo}`     | Filtra missões por tipo (RESGATE, ENTREGA)           |
| POST   | `/api/missoes`                 | Cria uma nova missão                                 |
| PUT    | `/api/missoes/{id}`            | Atualiza dados de uma missão                         |
| DELETE | `/api/missoes/{id}`            | Remove uma missão                                    |

### 🧑‍✈️ Operadores (/api/operadores)
| Método | Endpoint                | Descrição                     |
| ------ | ----------------------- | ----------------------------- |
| GET    | `/api/operadores`       | Lista todos os operadores     |
| GET    | `/api/operadores/{id}`  | Busca operador por ID         |
| POST   | `/api/operadores`       | Cria um novo operador         |
| POST   | `/api/operadores/login` | Login de operador             |
| PUT    | `/api/operadores/{id}`  | Atualiza dados de um operador |
| DELETE | `/api/operadores/{id}`  | Remove um operador            |

### 🌡️ Sensores (/api/sensores)
| Método | Endpoint                    | Descrição                                     |
| ------ | --------------------------- | --------------------------------------------- |
| GET    | `/api/sensores`             | Lista todos os registros de sensores          |
| GET    | `/api/sensores/{id}`        | Busca registro por ID                         |
| GET    | `/api/sensores/tipo/{tipo}` | Filtra registros por tipo (TEMPERATURA, etc.) |
| POST   | `/api/sensores`             | Cria um novo registro de sensor               |
| PUT    | `/api/sensores/{id}`        | Atualiza dados de um registro                 |
| DELETE | `/api/sensores/{id}`        | Remove um registro de sensor                  |

---

## ⚙️ Execução da Aplicação com Banco de Dados SQL em Nuvem (Azure)

Roteiro completo em texto disponível em  
📄 [https://github.com/pdroandrad/cp5-skyaid-devops/blob/main/Roteiro-execucao.txt](https://github.com/pdroandrad/cp5-skyaid-devops/blob/main/Roteiro-execucao.txt)

1. **Registrar Serviços no Azure**
   ```bash
   az provider register --namespace Microsoft.Web
   az provider register --namespace Microsoft.Insights
   az provider register --namespace Microsoft.OperationalInsights
   az provider register --namespace Microsoft.ServiceLinker
   az extension add --name application-insights
   ```

2. **Clonar Repositório**
   ```bash
   git clone https://github.com/pdroandrad/cp5-skyaid-devops.git
   cd cp5-skyaid-devops
   ```

3. **Criar Azure SQL Server (alterar para PowerShell)**
   ```bash
   cd cp5-skyaid-devops
   .\create-sql-server.ps1
   ```

4. **Criar Tabelas do Banco**
   ```bash
   sqlcmd -S tcp:sqlserver-rm558186.database.windows.net,1433 -U admsql -P 'Fiap@2tdsvms' -d skyaiddb -i script_bd.sql
   ```

5. **Verificar Extensão do Application Insights (alterar para Bash)**
   ```bash
   az extension list -o table
   ```

6. **Conceder Permissões e Rodar Deploy**
   ```bash
   cd cp5-skyaid-devops
   chmod +x deploy-skyaid.sh
   ./deploy-skyaid.sh --login-with-GitHub
   ```

7. **Configurar Secrets no GitHub (Settings > Security > Secrets and Variables > Actions > New Repository Secret**
   ```bash
   SPRING_DATASOURCE_USERNAME="admsql"
   SPRING_DATASOURCE_PASSWORD="Fiap@2tdsvms"
   SPRING_DATASOURCE_URL="jdbc:sqlserver://sqlserver-rm558186.database.windows.net:1433;database=skyaiddb;user=admsql@sqlserver-rm558186;password={your_password_here};encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;"
   ```

8. **Editar Workflow YAML (dentro da pasta Workflow criada na raiz do projeto. Acrescentar após Build with Maven, se atentando com a identação.)**
   ```bash
   env: 
        SPRING_DATASOURCE_URL: ${{ secrets.SPRING_DATASOURCE_URL }}
        SPRING_DATASOURCE_USERNAME: ${{ secrets.SPRING_DATASOURCE_USERNAME }}
        SPRING_DATASOURCE_PASSWORD: ${{ secrets.SPRING_DATASOURCE_PASSWORD }}
   ```

9. **Acessar Banco via Azure Portal**
   No Portal da Azure acessar o banco de dados SQL criado e fazer login no Editor de Consultas com login e senha.

10. **Acessar a Aplicação para execução de testes**
   ```bash
   https://skyaid-rm558186.azurewebsites.net/swagger-ui/index.html
   ```

11. **Testes no Swagger**
   Exemplos de Operadores para inserir (POST):
   ```bash
   {
  "nome": "Pedro Andrade",
  "email": "pedro@exemplo.com",
  "senha": "123456",
  "idBase": 1
  }
  
  {
    "nome": "Victor Alves",
    "email": "victor@exemplo.com",
    "senha": "123456",
    "idBase": 1
  }
  
  {
    "nome": "Ricardo Tavares",
    "email": "ricardo@exemplo.com",
    "senha": "123456",
    "idBase": 1
  }
   ```

   Exemplo de Operadore para atualizar (PUT):
   ```bash
   {
  "nome": "Pedro Andrade",
  "email": "pedroandrade@exemplo.com",
  "senha": "123456",
  "idBase": 1
  }
   ```

12. **Verificar no editor de consultas (Banco de dados SQL, no portal da Azure) as operações CRUD**
   ```bash
   SELECT * FROM OPERADORES;
   ```
