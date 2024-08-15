# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

cliente_user = User.create!(
  nome: "João Silva",
  email: "joao.silva@example.com",
  cpf: "123.456.789-00",
  telefone: "11987654321",
  endereco: "Rua das Flores, 123, São Paulo - SP",
  password: "senha123",
  role: :Cliente
)

# Criando o registro correspondente na tabela Cliente
cliente1 = Cliente.create!(
  user: cliente_user,
  saldo: 100.00 # Saldo inicial
)

Carrinho.create!(
  cliente_id: cliente1.id
)

user_vendedor = User.create!(
  email: 'vendedor@example.com',
  password: 'password123',
  cpf: "123.456.489-10",
  telefone: "1198234",
  endereco: "Rua das Flores, 123, xique-xique - RJ",
  role: 'Vendedor',
  nome: 'Vendedor Exemplo'
)

# Criar um vendedor associado ao usuário
vendedor = Vendedor.create!(
  emailParaContato: 'vendedor@example.com',
  user: user_vendedor # Associe o vendedor ao usuário
)

# Criar categorias
categorias = ["Eletrônicos", "Roupas", "Alimentos"]

categorias.each do |nome_categoria|
  Categorium.create!(nome: nome_categoria)
end
image_path = Rails.root.join('app', 'assets', 'images', 'windows_!_icon.png')

Produto.create!(
  nome: "carro de controle remoto",
  preco: 100,
  imagem: File.binread(Rails.root.join('app', 'assets', 'images', 'windows_!_icon.png')),
  descricao: "aaaaaaaaaaa",
  categorium: Categorium.find_by(nome: "Eletrônicos"),
  emEstoque: 5,
  emPromocao: false,
  vendedor: vendedor
)

Produto.create!(
  nome: "carro de madeira",
  preco: 101,
  imagem: File.binread(Rails.root.join('app', 'assets', 'images', 'windows_!_icon.png')),
  descricao: "aaaaaaaaaaa",
  categorium: Categorium.find_by(nome: "Eletrônicos"),
  emEstoque: 5,
  emPromocao: false,
  vendedor: vendedor
)

Produto.create!(
  nome: "carro",
  preco: 102,
  imagem: File.binread(Rails.root.join('app', 'assets', 'images', 'windows_!_icon.png')),
  descricao: "aaaaaaaaaaa",
  categorium: Categorium.find_by(nome: "Eletrônicos"),
  emEstoque: 5,
  emPromocao: false,
  vendedor: vendedor
)

Produto.create!(
  nome: "fantasia do batman",
  preco: 102,
  imagem: File.binread(Rails.root.join('app', 'assets', 'images', 'windows_!_icon.png')),
  descricao: "aaaaaaaaaaa",
  categorium: Categorium.find_by(nome: "Roupas"),
  emEstoque: 5,
  emPromocao: false,
  vendedor: vendedor
)

Produto.create!(
  nome: "fantasia do superman",
  preco: 104,
  imagem: File.binread(Rails.root.join('app', 'assets', 'images', 'windows_!_icon.png')),
  descricao: "aaaaaaaaaaa",
  categorium: Categorium.find_by(nome: "Roupas"),
  emEstoque: 5,
  emPromocao: false,
  vendedor: vendedor
)

puts "Seeds carregados com sucesso!"
