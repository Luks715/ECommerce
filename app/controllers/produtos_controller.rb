class ProdutosController < ApplicationController
  before_action :set_produto, only: [:show, :exibir_imagem, :edit, :update, :destroy]
  def index
    @produtos = Produto.all
  end

  def show
    @vendedor = @produto.vendedor
  end

  def exibir_imagem
    send_data produto.imagem, type: produto.imagem.content_type, disposition: 'inline'
  end

  def new
    @vendedor = current_user.vendedor
    @categoria = Categorium.all
    @produto = Produto.new
  end

  def create
    @produto = current_user.vendedor.produtos.build(produto_params)
    if @produto.save
      redirect_to vendedor_path(@produto.vendedor), notice: 'Produto criado com sucesso.'
    else
      @vendedor = current_user.vendedor
      @categoria = Categorium.all
      render :new
    end
  end

  def edit
  end

  def update
    if @produto.update(produto_params)
      redirect_to @produto, notice: 'Produto atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    if current_user == @produto.vendedor.user
      pedido = Pedido.where(produto: @produto, foi_pago: true)
      if pedido.present?
        pedido.each do |pedido_extornado|
          cliente = pedido_extornado.cliente
          cliente.update(saldo: (cliente.saldo + pedido_extornado.subTotal))


          vendedor = @produto.vendedor
          vendedor.update(carteira: (vendedor.carteira - pedido_extornado.subTotal))

          pedido.destroy(pedido.ids)

          if @produto.destroy
            redirect_to home_user_path, notice: 'Produto excluído com sucesso e dinheiro extornado para os clientes'
          else
            redirect_to home_user_path, alert: 'Não foi possível excluir o produto.'
          end
        end
      else
        if @produto.destroy
          redirect_to produtos_path, notice: 'Produto excluído com sucesso.'
        else
          redirect_to produtos_path, alert: 'Não foi possível excluir o produto.'
        end
      end
    else
      redirect_to root_path, alert: 'Você não tem permissão para excluir este produto.'
    end
  end

  private

  def produto_params
    params.require(:produto).permit(:nome, :descricao, :preco, :imagem, :categorium_id, :em_estoque, :desconto, :data_fim)
  end

  def set_produto
    @produto = Produto.find(params[:id])
  end

end
