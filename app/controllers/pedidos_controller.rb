class PedidosController < ApplicationController
  def new
    @pedido = Pedido.new
  end

  def create
    produto = Produto.find(params[:pedido][:produto_id]).id
    quantidade = params[:pedido][:quantidade].to_i
    cliente = Cliente.find(params[:pedido][:cliente_id])

    @pedido = Pedido.new(cliente_id: cliente.id, produto_id: produto, quantidade: quantidade)
    cliente.pedidos << @pedido

    if @pedido.save
      redirect_to root_path, notice: 'Pedido criado com sucesso.'
    else
      redirect_to produto_path(produto), alert: 'Erro ao criar pedido.'
    end
  end

  private

  def pedido_params
    params.require(:pedido).permit(:produto_id, :quantidade, :cliente_id)
  end
end
