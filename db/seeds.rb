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
  cpf: "123.456.789-00",
  saldo: 1000,
)

# Criando vendedor
user_vendedor = User.create!(
  email: 'vendedor@example.com',
  password: 'password123',
  telefone: "1198234",
  endereco: "Rua das Flores, 123, Xique-Xique - RJ",
  role: 'Vendedor',
  nome: 'Vendedor Exemplo'
)

vendedor = Vendedor.create!(
  emailParaContato: 'vendedor@example.com',
  cnpj: "123.456.489-10",
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
  emEstoque: 5,
  desconto: 0,
  vendedor: vendedor
)

produto_batman = Produto.create!(
  nome: "Fantasia do Batman",
  preco: 120,
  descricao: "Fantasia do Batman para crianças.",
  categorium: Categorium.find_by(nome: "Roupas"),
  emEstoque: 3,
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
