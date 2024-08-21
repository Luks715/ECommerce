class Carrinho < ApplicationRecord
  belongs_to :user
  has_many :pedidos, dependent: :destroy

  def calcular_total
    total = 0.0
    self.pedidos.each do |pedido|
      total += pedido.quantidade * pedido.produto.preco_promocional
    end
    total
  end

  def efetuar_pagamento
    novo_saldo = self.user.cliente.saldo - self.calcular_total
    if novo_saldo < 0
      return false
    else
      self.pedidos.each do |pedido|
        produto = pedido.produto
        produto.update(emEstoque: (produto.emEstoque - pedido.quantidade))
        vendedor = pedido.produto.vendedor
        cliente = self.user.cliente

        pedido.update(foiPago: true, dataChegada: Date.today + 14)
        vendedor.update(carteira: (vendedor.carteira + pedido.subTotal))

        # Após a compra ser feita, o pedido do cliente passa para o carrinho do vendedor
        vendedor.user.carrinho.pedidos << pedido

        # Essas relações existem para saber quais produtos/vendedores o usuário pode avaliar,
        # após o cliente fazer a avaliação, a instância é destruída.
        ClienteVendedor.find_or_create_by(cliente: cliente, vendedor: vendedor)
        ClienteProduto.find_or_create_by(cliente: cliente, produto: produto)

        #Cria o Historico da compra
        Historico.create(clienteNome: self.user.nome,
                         vendedorNome: vendedor.user.nome,
                         produtoNome: produto.nome,
                         quantidade: pedido.quantidade,
                         dataCompra: Date.today)
      end

      self.user.cliente.update(saldo: novo_saldo)
      true
    end
  end
end
