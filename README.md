# Trabalho prático de Sistemas para internet

### Documentação de Implantação: Livraria Antiqua

#### Sobre o ambiente
Sistema de uma pequena livraria digital utilizando Java 17 e Tomcat 10 para aplicação web.

livraria_app (Tomcat): Container web que roda a aplicação Java compilada.
livraria_db (PostgreSQL): Container de banco de dados onde os dados da livraria são persistidos.


#### Estrutura de arquivos do projeto
```
docker/
├── init-db/
│   └── script.sql          # Script SQL gerado pelo pgAdmin (UTF-8)
├── tomcat-logs/            # Pasta criada automaticamente (Logs do sistema)
├── Dockerfile              # Instruções de build da aplicação
└── docker-compose.yml      # Gerenciador dos containers
```

#### Como subir o sistema
 
1. construir e iniciar os containers
```
docker compose up --build -d
```
2. injetar o banco de dados
```
docker cp .\init-db\script.sql livraria_db:/tmp/script.sql
```
3. executar o script localmente de dentro do container
```
docker exec -it livraria_db psql -U postgres -d livraria_antiqua -f /tmp/script.sql
```
4. acessar a aplicação pelo navegador em: ´http://localhost:8080´
5. logs da aplicação e banco de dados ficam salvos na pasta: ´tomcat-logs´
6. Para desligar o ambiente
```
docker compose down
```


