# app.rb

require 'sinatra'
require 'pg'
require 'json'

# Configurações do banco de dados
DB = PG.connect(
  dbname: 'postgres',     # Substitua pelo nome do seu banco
  user: 'postgres',             # Substitua pelo seu usuário
  password: 'masterkey',           # Substitua pela sua senha
  host: 'localhost',               # Ou outro host, se aplicável
  port: 5432                       # Porta padrão do PostgreSQL
)

# Definindo o content type como JSON para todas as respostas
before do
  content_type :json
end

# Rota para listar todos os registros
# # app.rb (continuação)

post '/produtos' do
  data = JSON.parse(request.body.read)
  nome = data['nome']
  descricao = data['descricao']
  preco = data['preco']

  result = DB.exec_params(
    "INSERT INTO produtos (nome, descricao, preco) VALUES ($1, $2, $3) RETURNING *",
    [nome, descricao, preco]
  )

  status 201
  result.first.to_json
end

get '/produtos' do
  result = DB.exec("SELECT * FROM produtos ORDER BY id")
  produtos = result.map { |row| row }
  produtos.to_json
end

get '/produtos/:id' do
  id = params['id']
  result = DB.exec_params("SELECT * FROM produtos WHERE id = $1", [id])

  if result.ntuples == 0
    status 404
    { message: "Produto não encontrado" }.to_json
  else
    result.first.to_json
  end
end

put '/produtos/:id' do
  id = params['id']
  data = JSON.parse(request.body.read)
  nome = data['nome']
  descricao = data['descricao']
  preco = data['preco']

  result = DB.exec_params(
    "UPDATE produtos SET nome = $1, descricao = $2, preco = $3 WHERE id = $4 RETURNING *",
    [nome, descricao, preco, id]
  )

  if result.ntuples == 0
    status 404
    { message: "Produto não encontrado" }.to_json
  else
    result.first.to_json
  end
end

delete '/produtos/:id' do
  id = params['id']
  result = DB.exec_params("DELETE FROM produtos WHERE id = $1 RETURNING *", [id])

  if result.ntuples == 0
    status 404
    { message: "Produto não encontrado" }.to_json
  else
    { message: "Produto removido com sucesso" }.to_json
  end
end
