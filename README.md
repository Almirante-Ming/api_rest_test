api rest usando sinatra e postgres como banco de dados, com o objetivo de fornecer uma conexao facil para enviar, receber e editar produtos via protocolo https, feito como demonstracao para um projeto futuro



Aqui está uma explicação das rotas e funcionalidades:

Configuração do Banco de Dados:

A conexão com o PostgreSQL é feita no início usando a gem pg.
Certifique-se de ajustar as credenciais do banco (dbname, user, password, host) de acordo com o seu ambiente.

Rota POST /produtos:
Adiciona um novo produto.
Recebe um JSON com nome, descricao e preco no corpo da requisição.
Insere o produto no banco de dados e retorna o registro inserido.

ex:

curl -X POST http://localhost:9292/produtos \                                                                     ─╯
-H "Content-Type: application/json" \
-d '{
  "nome": "Produto X",
  "descricao": "Descrição do Produto X",
  "preco": 99.99
}'

----------------------------------------------------------------------------------------------------------------------------
Rota GET /produtos:
Lista todos os produtos.
Faz uma consulta no banco de dados e retorna todos os registros ordenados pelo id.
ex:

curl -X GET http://localhost:9292/produtos

----------------------------------------------------------------------------------------------------------------------------
Rota GET /produtos/:id:
Retorna um produto específico com base no id.
Se o produto não for encontrado, retorna um erro 404 com a mensagem "Produto não encontrado".
ex:

curl -X GET http://localhost:9292/produtos/1

----------------------------------------------------------------------------------------------------------------------------
Rota PUT /produtos/:id:
Atualiza um produto específico.
Recebe o id do produto e os dados atualizados no corpo da requisição.
Se o produto for encontrado, ele é atualizado e o registro atualizado é retornado. Caso contrário, um erro 404 é retornado.
ex: 

curl -X PUT http://localhost:9292/produtos/1 \
-H "Content-Type: application/json" \
-d '{
  "nome": "Produto X Atualizado",
  "descricao": "Nova descrição do Produto X",
  "preco": 119.99
}'

----------------------------------------------------------------------------------------------------------------------------
Rota DELETE /produtos/:id:
Remove um produto com base no id.
Retorna uma mensagem de sucesso se o produto for removido, ou um erro 404 se o produto não existir.
ex:

curl -X DELETE http://localhost:9292/produtos/1
