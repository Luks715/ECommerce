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
    end
  end
end
