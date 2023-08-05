require 'bcrypt'

class Usuario
  def initialize(id, nome, email, senha)
    @id = id
    @nome = nome
    @email = email
    @senha = criptografar_senha(senha) # Armazena a senha criptografada
  end

  # Método para criar o hash da senha
  def criptografar_senha(senha)
    salt_rounds = 10
    BCrypt::Password.create(senha, cost: salt_rounds)
  end

  # Método para verificar se a senha fornecida corresponde ao hash da senha armazenada
  def verificar_senha(senha)
    BCrypt::Password.new(@senha) == senha
  end
end

Usuario