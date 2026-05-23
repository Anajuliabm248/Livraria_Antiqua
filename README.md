# Trabalho Final POOWI
##### Ana Julia Bock Medina

---
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
#### Ferramentas utilizadas:
- Java
- Spring MVC
- Maven (gerenciamento de dependências)
- banco de dados PostgreSQL
- HTML, CSS, JS e BootsStrap (front-end)
---
## Instalação e uso


---
## Protótipo e Diagrama
Encontrados em:
```
demo/
└── demo/
└── Diagrama_Prototipo/
    ├── Diagrama.png
    └── Prototipo.pdf
```

## Detalhes da arquitetura

##### Cliente
- cadastro login e logout
- edita perfil
- gerencia endereço (criar e editar)
- busca pedidos

##### Vendedor
- cadastra, edita e exclui livros
- atualiza estoque
- gera relatório de lista de vendas

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