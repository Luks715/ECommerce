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
      # Chamando a procedure SQL para processar o pagamento e atualizar o banco de dados
      ActiveRecord::Base.connection.execute("SELECT efetuar_compra(#{self.id}, #{novo_saldo})")
      true

      # self.pedidos.each do |pedido|
      #   produto = pedido.produto
      #   produto.update(em_estoque: (produto.em_estoque - pedido.quantidade))
      #   vendedor = pedido.produto.vendedor
      #   cliente = self.user.cliente

      #   pedido.update(foi_pago: true, data_chegada: Date.today + 14)
      #   vendedor.update(carteira: (vendedor.carteira + pedido.subTotal))

      #   # Após a compra ser feita, o pedido do cliente passa para o carrinho do vendedor
      #   vendedor.user.carrinho.pedidos << pedido

         # Essas relações existem para saber quais produtos/vendedores o usuário pode avaliar,
         # após o cliente fazer a avaliação, a instância é destruída.
      #   ClienteVendedor.find_or_create_by(cliente: cliente, vendedor: vendedor)
      #   ClienteProduto.find_or_create_by(cliente: cliente, produto: produto)

         #Cria o Historico da compra
      #   Historico.create(cliente_nome: self.user.nome,
      #                    vendedor_nome: vendedor.user.nome,
      #                    produto_nome: produto.nome,
      #                    quantidade: pedido.quantidade,
      #                    data_compra: Date.today)
      # end

      # self.user.cliente.update(saldo: novo_saldo)
    end
  end
end
