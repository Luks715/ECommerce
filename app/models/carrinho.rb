class Carrinho < ApplicationRecord
  belongs_to :cliente, class_name: "Cliente", foreign_key: "cliente_id"
  has_many :pedidos, dependent: :destroy

  private

  def calcular_total
    total = 0.0
    @pedidos.each do |pedido|
      total += (pedido.quantidade)*(pedido.produto.preco)
    end
    return total
  end

  def efetuar_pagamento
    if @cliente.saldo < self.calcular_total
      return false
    else
      novo_saldo = @cliente.saldo - self.calcular_total
      @cliente.update(saldo: novo_saldo)

      @pedidos.each do |pedido|
        vendedor = pedido.produto.vendedor
        ClienteVendedor.find_or_create_by(cliente: cliente, vendedor: vendedor)
      end

      return true
    end
  end
end
