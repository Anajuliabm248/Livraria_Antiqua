# Trabalho Final POOWI
##### Ana Julia Bock Medina

## Descrição
Projeto de 'pseudo' sistema de compras, gestão de vendas e controle de estoque de uma pequena livraria.

#### Funções:
- Cadastro e gerenciamento de livros
- Perfil para cliente e vendedor
- Registro de vendas realizadas pelo vendedor
- Calculo automático do valor total de vendas
- Visualização, edição e exclusão de informação cadastradas no sistema, incluindo perfis e livros
- Simulação de carrinho e compra para o cliente
- Tela de gestão de acervo para o vendedor

### Detalhes da organização das funções
##### Cliente
- cadastro login e logout
- edita perfil
- gerencia endereço (criar e editar)
- busca pedidos
##### Vendedor
- cadastra, edita e exclui livros
- atualiza estoque
- tem relatório de lista de vendas
##### Carrinho
- cliente adiciona e remove item
- calcula e atualiza valor total
- após finalização da compra fica limpo
##### Venda
- cria venda a partir de carrinho
- decrementa estoque dos livros
- ao cancelar venda, devolve o livro pro estoque
- lista todas as vendas para relatório do vendedor
##### Pagamento
- cria registro de pagamento vinculado à venda
- processa pagamento (atualiza status)
- cancela pagamento

#### Ferramentas utilizadas:
- Java
- Jakarta servelet/JSP
- Arquitetura MVC (controller, dao, model, service, view(webapp))
- Maven (gerenciamento de dependências)
- banco de dados PostgreSQL
- HTML, CSS, JS e BootsStrap (front-end)

## Instalação e uso
1. fazer o download e extração do projeto
2. no PgAdmin criar um novo banco de dados chamado livraria_antiqua
3. abrir o bando de dados (run query toll) e ir em abrir arquivo, lá abrir o banco_de_dados.sql (como encontrar abaixo) e executar o scrpit
4. abrir o projeto no Intellij
5. adicionar o jboss no current files
6. fazer o run do projeto
7. no navegador fazer o cadastro, login e utilizar o sistema

## Protótipo e Diagrama e Banco de dados
Encontrados em:
```
trabalho_final/
└── utils/
    ├── BD/
    |    └── banco_de_dados.sql
    ├── diagrama/
    |    └── diagrama_er.png
    └── prototipo/
         └── <arquivos png do prótipo>
```
