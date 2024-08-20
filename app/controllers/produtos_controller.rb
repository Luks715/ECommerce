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
    @produto.destroy
    redirect_to home_user_path, notice: 'Produto foi excluído com sucesso.'
  end

  private

  def produto_params
    params.require(:produto).permit(:nome, :descricao, :preco, :categorium_id, :emEstoque, :desconto, :dataFim)
  end

  def set_produto
    @produto = Produto.find(params[:id])
  end

end
