class CarrinhosController < ApplicationController
  before_action :set_carrinho
  def show
    @pedidos = @carrinho.pedidos
  end

  def update
    if params[:remove_selected]
      if params[:carrinho].present? && params[:carrinho][:pedidos_ids].present?
        pedidos_ids = params[:carrinho][:pedidos_ids]
        Pedido.where(id: pedidos_ids).destroy_all
        redirect_to carrinho_path(@carrinho), notice: 'Pedidos removidos com sucesso.'
      else
        flash[:alert] = "Nenhum pedido foi selecionado."
      end
    elsif params[:finalize_purchase]
      # Lógica para finalizar a compra do carrinho
      if @carrinho.efetuar_pagamento
        redirect_to root_path, notice: 'Compra finalizada com sucesso.'
      else
        redirect_to carrinho_path(@carrinho), notice: 'Saldo insuficiente'
      end

    elsif params[:send_purchases]
      if params[:carrinho].present? && params[:carrinho][:pedidos_ids].present?
        pedidos_ids = params[:carrinho][:pedidos_ids]

        array_literal = "{#{pedidos_ids.join(',')}}"

        sanitized_ids = ActiveRecord::Base.sanitize_sql_array(["SELECT update_pedidos_enviados(?)", array_literal])
        ActiveRecord::Base.connection.execute(sanitized_ids)

        # Código Antigo (Comentado)
        # Pedido.where(id: pedidos_ids).update_all(foi_enviado: true)
      else
        flash[:alert] = "Nenhum pedido foi selecionado."
      end
      redirect_to root_path, notice: 'Compras enviadas para o cliente'
    end
  end

  private

  def set_carrinho
    @carrinho = Carrinho.find(params[:id])
  end
end
