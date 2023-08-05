require 'sinatra'
require 'sinatra/cors'
require 'bcrypt'
require 'json'

set :allow_origin, :any
set :allow_methods, [:get, :post, :options]
set :allow_credentials, true

usuarios = []

post '/usuarios' do
  request.body.rewind
  data = JSON.parse request.body.read

  nome = data['nome']
  email = data['email']
  senha = data['senha']

  usuarioExistente = usuarios.find { |usuario| usuario['email'] == email }
  if usuarioExistente
    status 400
    return { error: 'E-mail já cadastrado.' }.to_json
  end

  hash = BCrypt::Password.create(senha)

  id = usuarios.length + 1
  novoUsuario = {
    id: id,
    nome: nome,
    email: email,
    senha: hash
  }

  usuarios.push(novoUsuario)

  status 201
  novoUsuario.to_json
end

get '/usuarios' do
  usuarios.to_json
end

get '/usuarios/:id' do
  id = params['id'].to_i
  usuario = usuarios.find { |usuario| usuario['id'] == id }
  if !usuario
    status 404
    return { error: 'Usuário não encontrado.' }.to_json
  end

  usuario.to_json
end