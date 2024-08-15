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
  user: user_vendedor
)

# Criar categorias
categorias = ["Eletrônicos", "Roupas", "Alimentos"]

categorias.each do |nome_categoria|
  Categorium.create!(nome: nome_categoria)
end

produto_superman = Produto.create!(
  nome: "fantasia do superman",
  preco: 104,
  descricao: "aaaaaaaaaaa",
  categorium: Categorium.find_by(nome: "Roupas"),
  emEstoque: 5,
  emPromocao: false,
  vendedor: vendedor
)

pedido = Pedido.create!(
  produto_id: produto_superman.id,
  cliente_id: cliente1.id,
  quantidade: 2
)
cliente1.pedidos << pedido

puts "Seeds carregados com sucesso!"
