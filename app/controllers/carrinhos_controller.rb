class CarrinhosController < ApplicationController
  before_action :set_carrinho
  def show
    @pedidos = @carrinho.pedidos
  end

  def update
    if params[:remove_selected]
      # Lógica para remover pedidos do carrinho (Usada somente por Clientes)
      if params[:carrinho].present? && params[:carrinho][:pedidos_ids].present?
        pedidos_ids = params[:carrinho][:pedidos_ids]

        if Pedido.destroy_pedidos(pedidos_ids)
          redirect_to carrinho_path(@carrinho), notice: 'Pedidos removidos com sucesso.'
        else
          flash[:alert] = "Nenhum pedido foi selecionado."
        end
      end

    elsif params[:finalize_purchase]
      # Lógica para finalizar a compra do carrinho (Usada somente por Clientes)
      if @carrinho.efetuar_pagamento
        redirect_to root_path, notice: 'Compra finalizada com sucesso.'
      else
        redirect_to carrinho_path(@carrinho), notice: 'Saldo insuficiente'
      end

    elsif params[:send_purchases]
      # Lógica para enviar compras para o cliente (Usada somente por Vendedores)
      if params[:carrinho].present? && params[:carrinho][:pedidos_ids].present?
        pedidos_ids = params[:carrinho][:pedidos_ids]

        if Pedido.enviar(pedidos_ids)
           redirect_to root_path, notice: 'Compras enviadas para o cliente'
        else
          flash[:alert] = "Nenhum pedido foi selecionado."
        end
      end
    end
  end

  private

  def set_carrinho
    @carrinho = Carrinho.find(params[:id])
  end
end
