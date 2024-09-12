# Criação das Categorias
categorias = ["Eletrônicos", "Roupas", "Discos", "Livros", "Ferramentas", "Itens de Decoração", "Brinquedos", "Outros"]

categorias.each do |nome_categoria|
  Categorium.create!(nome: nome_categoria)
end

puts "Categorias criadas com sucesso"



# Criação dos 10 Users (5 Clientes e 5 Usuários)
# Todos os telefones, endereços, CPFs e CNPJs foram criados pelo ChatGPT
#
users_data = [
  {nome: 'Carlos Almeida', email: 'carlos.almeida@gmail.com', telefone: '(61) 91234-5678',
   endereco: 'Rua das Flores, 123, Belo Horizonte, MG', password: 'senha123', password_confirmation: 'senha123',
   role: 'Cliente', cliente_attributes: { cpf: '123.456.789-73'}},

  {nome: 'Ana Santos', email: 'ana.santos@gmail.com', telefone: '(22) 91234-5687',
   endereco: 'Avenida Central, 456, Curitiba, PR', password: 'senha123', password_confirmation: 'senha123',
   role: 'Cliente', cliente_attributes: { cpf: '132.546.978-26'}},

  {nome: 'Mariana Oliveira', email: 'mariana.oliveira@gmail.com', telefone: '(11) 91234-5768',
   endereco: 'Rua dos Pinheiros, 789, Salvador, BA', password: 'senha123', password_confirmation: 'senha123',
   role: 'Cliente', cliente_attributes: { cpf: '312.456.987-56'}},

  {nome: 'Bruno Costa', email: 'bruno.costa@gmail.com', telefone: '(27) 91234-5786',
   endereco: 'Avenida Paulista, 1000, São Paulo, SP', password: 'senha123', password_confirmation: 'senha123',
   role: 'Cliente', cliente_attributes: { cpf: '213.654.789-78'}},

  {nome: 'Sofia Lima', email: 'sofia.lima@gmail.com', telefone: '(24) 91234-5867',
   endereco: 'Praça da Sé, 200, Porto Alegre, RS', password: 'senha123', password_confirmation: 'senha123',
   role: 'Cliente', cliente_attributes: { cpf: '121.566.897-12'}},



  {nome: 'Rodrigo Carvalho', email: 'rodrigo.carvalho@gmail.com', telefone: '(76) 91234-6857',
   endereco: 'Rua Canadá, 321, Toronto, ON, Canadá', password: 'senha123', password_confirmation: 'senha123',
   role: 'Vendedor', vendedor_attributes: { cnpj: '12.345.678/0001-91', email_para_contato: 'Livraria_Carvalho@gmail.com'}},

  {nome: 'Fernando Silva', email: 'fernando.silva@gmail.com', telefone: '(94) 91234-6785',
   endereco: 'Rua dos Bobos, 0, Campinas, SP', password: 'senha123', password_confirmation: 'senha123',
   role: 'Vendedor', vendedor_attributes: { cnpj: '23.456.789/0001-36', email_para_contato: 'Discos2000@gmail.com'}},

  {nome: 'Lucas Martins', email: 'lucas.martins@gmail.com', telefone: '(61) 91234-6758',
   endereco: 'Avenida Atlântica, 500, Rio de Janeiro, RJ', password: 'senha123', password_confirmation: 'senha123',
   role: 'Vendedor', vendedor_attributes: { cnpj: '87.654.321/0001-50', email_para_contato: 'eletronicos_martin@gmail.com'}},

  {nome: 'Isabela Mendes', email: 'isabela.mendes@gmail.com', telefone: '(09) 91234-6587',
   endereco: 'Rua da Consolação, 1500, São Paulo, SP', password: 'senha123', password_confirmation: 'senha123',
   role: 'Vendedor', vendedor_attributes: { cnpj: '34.567.890/0001-78', email_para_contato: 'roupas_mendes@gmail.com'}},

  {nome: 'Rafael Sousa', email: 'rafael.sousa@example.com', telefone: '(61) 96343-6578',
   endereco: 'Rua Liberdade, 400, Lisboa, Portugal', password: 'senha123', password_confirmation: 'senha123',
   role: 'Vendedor', vendedor_attributes: { cnpj: '76.543.210/0001-62', email_para_contato: 'produtos_gerais@gmail.com'}},

]

users_data.each do |user_data|
  User.create!(user_data)
end

puts "Vendedores e Clientes criados com sucesso"

# Criação de Produtos

produtos = {
    produtos_roupas: [
      {nome: "Jaqueta de Couro", preco: 25, descricao: "Couro artificial preto, tamanho M, feito na China",
      categorium: Categorium.find_by(nome: "Roupas"), em_estoque: 5, desconto: 0, vendedor: Vendedor.find_by(cnpj: '34.567.890/0001-78')},

      {nome: "Calça Jeans", preco: 50, descricao: "Calça jeans azul, tamanho 38, tecido flexível",
      categorium: Categorium.find_by(nome: "Roupas"), em_estoque: 8, desconto: 0, vendedor: Vendedor.find_by(cnpj: '34.567.890/0001-78')}],

    produtos_eletronicos: [
      {nome: "Smartphone X12", preco: 2300, descricao: "Smartphone com tela de 6.5 polegadas, 128GB, 4GB RAM",
      categorium: Categorium.find_by(nome: "Eletrônicos"), em_estoque: 15, desconto: 0, vendedor: Vendedor.find_by(cnpj: '87.654.321/0001-50')},

    {nome: "Fone de Ouvido Bluetooth", preco: 160, descricao: "Fone de ouvido sem fio com cancelamento de ruído",
      categorium: Categorium.find_by(nome: "Eletrônicos"), em_estoque: 20, desconto: 0, vendedor: Vendedor.find_by(cnpj: '87.654.321/0001-50')}],

    produtos_musica: [
      {nome: "The Beatles - Abbey Road", preco: 400, descricao: "Vinil edição especial dos Beatles",
      categorium: Categorium.find_by(nome: "Discos"), em_estoque: 3, desconto: 0, vendedor: Vendedor.find_by(cnpj: '23.456.789/0001-36')},

      {nome: "Metallica - Black Album", preco: 240, descricao: "CD do álbum Black Album do Metallica",
      categorium: Categorium.find_by(nome: "Discos"), em_estoque: 5, desconto: 0, vendedor: Vendedor.find_by(cnpj: '23.456.789/0001-36')}],

    produtos_livros: [
      {nome: "O Senhor dos Anéis", preco: 45, descricao: "Edição completa com os três volumes de O Senhor dos Anéis",
      categorium: Categorium.find_by(nome: "Livros"), em_estoque: 10, desconto: 0, vendedor: Vendedor.find_by(cnpj: '12.345.678/0001-91')},

      {nome: "A Revolução dos Bichos", preco: 20, descricao: "Clássico de George Orwell sobre uma sociedade animal",
      categorium: Categorium.find_by(nome: "Livros"), em_estoque: 12, desconto: 0, vendedor: Vendedor.find_by(cnpj: '12.345.678/0001-91')}],

    produtos_outros: [
      {nome: "Jogo de Panelas", preco: 200, descricao: "Jogo de panelas de aço inox com 5 peças",
      categorium: Categorium.find_by(nome: "Outros"), em_estoque: 7, desconto: 0, vendedor: Vendedor.find_by(cnpj: '76.543.210/0001-62')},

      {nome: "Cafeteira Elétrica", preco: 100, descricao: "Cafeteira elétrica com capacidade para 1 litro",
      categorium: Categorium.find_by(nome: "Outros"), em_estoque: 9, desconto: 0, vendedor: Vendedor.find_by(cnpj: '76.543.210/0001-62')}]
}

produtos.each do |categoria, itens|
  itens.each do |produto|
    Produto.create!(produto)
  end
end

puts "Produtos criados com sucesso"


# Criando reviews

review_produtos = [
    {nota: 1, comentario: "o teflon saiu muito rápido!",
    cliente: Cliente.find_by(cpf: '123.456.789-73'), produto: Produto.find_by(nome: 'Jogo de Panelas')},

    {nota: 1, comentario: "Não passa café por nada!!",
    cliente: Cliente.find_by(cpf: '123.456.789-73'), produto: Produto.find_by(nome: 'Cafeteira Elétrica')},

    {nota: 2, comentario: "Péssimo livro, não gostei do final",
    cliente: Cliente.find_by(cpf: '132.546.978-26'), produto: Produto.find_by(nome: 'A Revolução dos Bichos')},

    {nota: 3, comentario: "O som é meio baixo",
    cliente: Cliente.find_by(cpf: '121.566.897-12'), produto: Produto.find_by(nome: 'Fone de Ouvido Bluetooth')},

    {nota: 4, comentario: "Calça excelente, mas a entrega demorou um pouco",
    cliente: Cliente.find_by(cpf: '312.456.987-56'), produto: Produto.find_by(nome: 'Calça Jeans')},

    {nota: 5, comentario: "Um dos meus álbuns favoritos",
    cliente: Cliente.find_by(cpf: '213.654.789-78'), produto: Produto.find_by(nome: 'The Beatles - Abbey Road')},
]

review_produtos.each do |review|
  ReviewProduto.create!(review)
end

review_vendedores = [
    {nota: 1, comentario: "O vendedor anunciou dois produtos defeituoso e não respondeu meus emails",
    cliente: Cliente.find_by(cpf: '123.456.789-73'), vendedor: Vendedor.find_by(cnpj: '76.543.210/0001-62')},

    {nota: 2, comentario: "O livro chegou amassado, pelo menos ofereceu trocar e enviou outro",
    cliente: Cliente.find_by(cpf: '132.546.978-26'), vendedor: Vendedor.find_by(cnpj: '12.345.678/0001-91')},

    {nota: 3, comentario: "A entrega demorou um pouco, mas o produto funciona",
    cliente: Cliente.find_by(cpf: '121.566.897-12'), vendedor: Vendedor.find_by(cnpj: '87.654.321/0001-50')},

    {nota: 4, comentario: "Roupas muito boas e chegou no tempo",
    cliente: Cliente.find_by(cpf: '312.456.987-56'), vendedor: Vendedor.find_by(cnpj: '34.567.890/0001-78')},

    {nota: 5, comentario: "Ótima seleção de álbuns e chegou antes do prazo",
    cliente: Cliente.find_by(cpf: '213.654.789-78'), vendedor: Vendedor.find_by(cnpj: '23.456.789/0001-36')},
]

review_vendedores.each do |review|
  ReviewVendedor.create!(review)
end

puts "Reviews Criadas com Sucesso"

pedidos_data = [
  { carrinho_id: 1, cliente_id: 6, produto: Produto.find_by(nome: 'O Senhor dos Anéis'), quantidade: 2, foi_pago: true, foi_enviado: false, data_chegada: Date.today + 14.days },
  { carrinho_id: 1, cliente_id: 7, produto: Produto.find_by(nome: 'O Senhor dos Anéis'), quantidade: 1, foi_pago: true, foi_enviado: false, data_chegada: Date.today + 14.days },
  { carrinho_id: 8, cliente_id: 8, produto: Produto.find_by(nome: 'Smartphone X12'), quantidade: 2, foi_pago: false, foi_enviado: false, data_chegada: Date.today + 14.days },
  { carrinho_id: 9, cliente_id: 9, produto: Produto.find_by(nome: 'Jaqueta de Couro'), quantidade: 3, foi_pago: false, foi_enviado: false, data_chegada: Date.today + 14.days },
  { carrinho_id: 5, cliente_id: 8, produto: Produto.find_by(nome: 'Cafeteira Elétrica'), quantidade: 1, foi_pago: true, foi_enviado: false, data_chegada: Date.today + 14.days },
  { carrinho_id: 2, cliente_id: 7, produto: Produto.find_by(nome: 'Metallica - Black Album'), quantidade: 1, foi_pago: true, foi_enviado: true, data_chegada: Date.today + 14.days }
]

pedidos_data.each do |pedido_data|
  Pedido.create!(pedido_data)
end

puts "Pedidos criados com sucesso"

historico = [
   {cliente_nome: 'Carlos Almeida', vendedor_nome: 'Rafael Sousa', produto_nome: 'Jogo de Panelas', quantidade: 2,
   data_compra: Date.today, review_do_produto: true, review_do_vendedor: true},

   {cliente_nome: 'Ana Santos', vendedor_nome: 'Rodrigo Carvalho', produto_nome: 'A Revolução dos Bichos', quantidade: 1,
   data_compra: Date.today, review_do_produto: true, review_do_vendedor: true},

   {cliente_nome: 'Sofia Lima', vendedor_nome: 'Lucas Martins', produto_nome: 'Fone de Ouvido Bluetooth', quantidade: 1,
   data_compra: Date.today, review_do_produto: true, review_do_vendedor: true},

   {cliente_nome: 'Mariana Oliveira', vendedor_nome: 'Isabela Mendes', produto_nome: 'Calça Jeans', quantidade: 3,
   data_compra: Date.today, review_do_produto: true, review_do_vendedor: true},

   {cliente_nome: 'Bruno Costa', vendedor_nome: 'Fernando Silva', produto_nome: 'The Beatles - Abbey Road', quantidade: 1,
   data_compra: Date.today, review_do_produto: true, review_do_vendedor: true},



   {cliente_nome: 'Carlos Almeida', vendedor_nome: 'Rodrigo Carvalho', produto_nome: 'O Senhor dos Anéis', quantidade: 2,
   data_compra: Date.today, review_do_produto: false, review_do_vendedor: false},

   {cliente_nome: 'Ana Santos', vendedor_nome: 'Rafael Sousa', produto_nome: 'O Senhor dos Anéis', quantidade: 1,
   data_compra: Date.today, review_do_produto: false, review_do_vendedor: false},

   {cliente_nome: 'Mariana Oliveira', vendedor_nome: 'Rafael Sousa', produto_nome: 'Cafeteira Elétrica', quantidade: 1,
   data_compra: Date.today, review_do_produto: false, review_do_vendedor: false},

   {cliente_nome: 'Ana Santos', vendedor_nome: 'Fernando Silva', produto_nome: 'Metallica - Black Album', quantidade: 1,
   data_compra: Date.today, review_do_produto: false, review_do_vendedor: false}
]

historico.each do |historico|
  Historico.create!(historico)
end

puts "Historico criado com sucesso"
