class CarrinhosController < ApplicationController
  before_action :set_carrinho
  def show
    @pedidos = @carrinho.pedidos
  end

  def update
    if params[:remove_selected]
      pedidos_ids = params[:carrinho][:pedidos_ids]
      Pedido.where(id: pedidos_ids).destroy_all
      redirect_to carrinho_path(@carrinho), notice: 'Pedidos removidos com sucesso.'
    elsif params[:finalize_purchase]
      # Lógica para finalizar a compra do carrinho
      if @carrinho.efetuar_pagamento
        redirect_to root_path, notice: 'Compra finalizada com sucesso.'
      else
        redirect_to carrinho_path(@carrinho), notice: 'Saldo insuficiente'
      end
    elsif params[:send_purchases]
      pedidos_ids = params[:carrinho][:pedidos_ids]
      Pedido.where(id: pedidos_ids).each do |pedido|
        pedido.update(foiEnviado: true)
      end
      redirect_to root_path, notice: 'Compras enviadas para o cliente'
    end
  end

  private

  def set_carrinho
    @carrinho = Carrinho.find(params[:id])
  end
end
