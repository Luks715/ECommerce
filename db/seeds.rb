# db/seeds.rb

# Criação de um usuário Cliente
user_cliente = User.create!(
  nome: 'Cliente Teste',
  email: 'cliente@example.com',
  telefone: '123456789',
  endereco: 'Rua Cliente, 123',
  password: 'senha123',
  password_confirmation: 'senha123',
  role: 'Cliente',
  cliente_attributes: {
    cpf: '123.456.789-00'
  }
)

puts "Criado usuário Cliente: #{user_cliente.nome} com CPF #{user_cliente.cliente.cpf}"

# Criação de um usuário Vendedor
user_vendedor = User.create!(
  nome: 'Vendedor Teste',
  email: 'vendedor@example.com',
  telefone: '987654321',
  endereco: 'Rua Vendedor, 321',
  password: 'senha123',
  password_confirmation: 'senha123',
  role: 'Vendedor',
  vendedor_attributes: {
    cnpj: '12.345.678/0001-00',
    email_para_contato: 'contato@vendedor.com'
  }
)

puts "Criado usuário Vendedor: #{user_vendedor.nome} com CNPJ #{user_vendedor.vendedor.cnpj}"

# Adicione mais usuários conforme necessário...


# Criando cliente
cliente_user = User.create!(
  nome: "João Silva",
  email: "joao.silva@example.com",
  telefone: "11987654321",
  endereco: "Rua das Flores, 123, São Paulo - SP",
  password: "senha123",
  role: :Cliente
)

cliente1 = Cliente.create!(
  user: cliente_user,
  cpf: "123.456.789-01",
  saldo: 1000,
)

# Criando vendedor
user_vendedor = User.create!(
  email: 'plutarco_comercios@example.com',
  password: 'password123',
  telefone: "1198234",
  endereco: "Rua das Flores, 123, Xique-Xique - RJ",
  role: 'Vendedor',
  nome: 'Vendedor Exemplo'
)

vendedor = Vendedor.create!(
  email_para_contato: 'vendedor@example.com',
  cnpj: "123.456.489-1120",
  user: user_vendedor
)

# Criando categorias
categorias = ["Eletrônicos", "Roupas", "Alimentos"]

categorias.each do |nome_categoria|
  Categorium.create!(nome: nome_categoria)
end

# Criando produtos
produto_superman = Produto.create!(
  nome: "Fantasia do Superman",
  preco: 25,
  descricao: "Fantasia do Superman para crianças.",
  categorium: Categorium.find_by(nome: "Roupas"),
  em_estoque: 5,
  desconto: 0,
  vendedor: vendedor
)

produto_batman = Produto.create!(
  nome: "Fantasia do Batman",
  preco: 120,
  descricao: "Fantasia do Batman para crianças.",
  categorium: Categorium.find_by(nome: "Roupas"),
  em_estoque: 3,
  desconto: 0,
  vendedor: vendedor
)

# Criando reviews
ReviewProduto.create!(
  nota: 4,
  comentario: "Ótima fantasia, meu filho adorou!",
  cliente: cliente1,
  produto: produto_superman,
)

ReviewProduto.create!(
  nota: 5,
  comentario: "Produto excelente, recomendo!",
  cliente: cliente1,
  produto: produto_batman,
)

puts "Seeds carregados com sucesso!"
