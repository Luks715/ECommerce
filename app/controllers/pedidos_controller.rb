class PedidosController < ApplicationController
  def new
    @pedido = Pedido.new
  end

  def create
    produto = Produto.find(params[:pedido][:produto_id])
    carrinho = Carrinho.find_by(user_id: current_user.id)
    quantidade = params[:pedido][:quantidade].to_i
    cliente = Cliente.find(params[:pedido][:cliente_id])

    if quantidade > produto.em_estoque
      redirect_to produto_path(produto), alert: 'Quantidade excede o estoque'
    else
      pedidoExistente = Pedido.find_by(carrinho_id: current_user.carrinho.id, produto_id: produto.id)

      if pedidoExistente.present?
        pedidoExistente.destroy
      end

      @pedido = Pedido.new(
        carrinho_id: carrinho.id,
        produto: produto,
        cliente_id: cliente.id,

        quantidade: quantidade,
        foi_pago: false,
        foi_enviado: false,
        data_chegada: Date.today + 14)

      if @pedido.save
        redirect_to root_path, notice: 'Pedido criado com sucesso.'
      else
        redirect_to produto_path(produto), alert: 'Erro ao criar pedido.'
      end
    end
  end

  def destroy
    if params[:pedidos_ids].present?
      Pedido.where(id: params[:pedidos_ids], cliente: current_user.cliente).destroy_all
      flash[:notice] = "Pedidos marcados como recebidos e removidos com sucesso."
    else
      flash[:alert] = "Nenhum pedido foi selecionado."
    end

    redirect_to home_user_path
  end

  private

  def pedido_params
    params.require(:pedido).permit(:produto_id, :quantidade)
  end
end
