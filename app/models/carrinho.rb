class Carrinho < ApplicationRecord
  belongs_to :cliente
  has_many :pedidos
  private

  def calcular_total
    total = 0.0
    pedidos.each do |pedido|
      total += (pedido.quantidade) * (pedido.produto.preco)
    end
    total
  end

  def efetuar_pagamento
    if cliente.saldo < calcular_total
      return false
    else
      novo_saldo = cliente.saldo - calcular_total
      cliente.update(saldo: novo_saldo)

      pedidos.each do |pedido|
        vendedor = pedido.produto.vendedor
        ClienteVendedor.find_or_create_by(cliente: cliente, vendedor: vendedor)
      end

      true
    end
  end
end
