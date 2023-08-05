require_relative '../models/Usuario'
usuarios = []
class UsuarioController
  def self.criarUsuario(req, res)
    nome = req.body[:nome]
    email = req.body[:email]
    senha = req.body[:senha]
    id = usuarios.length + 1
    novoUsuario = Usuario.new(id, nome, email, senha)
    usuarios.push(novoUsuario)
    return res.status(201).json(novoUsuario)
  end

  def self.listarUsuarios(req, res)
    return res.json(usuarios)
  end

  def self.buscarUsuario(req, res)
    id = req.params[:id].to_i
    usuario = usuarios.find { |usuario| usuario.id == id }
    if !usuario
      return res.status(404).json({ error: 'Usuário não encontrado.' })
    end
    return res.json(usuario)
  end

  def self.deletarUsuario(req, res)
    id = req.params[:id].to_i
    index = usuarios.find_index { |usuario| usuario.id == id }
    if index == -1
      return res.status(404).json({ error: 'Usuário não encontrado.' })
    end
    usuarios.delete_at(index)
    return res.sendStatus(204)
  end

  def self.atualizarUsuario(req, res)
    id = req.params[:id].to_i
    nome = req.body[:nome]
    email = req.body[:email]
    usuario = usuarios.find { |usuario| usuario.id == id }
    if !usuario
      return res.status(404).json({ error: 'Usuário não encontrado.' })
    end
    usuario.nome = nome
    usuario.email = email
    return res.json(usuario)
  end

  def self.loginUsuario(req, res)
    email = req.body[:email]
    senha = req.body[:senha]
    usuario = usuarios.