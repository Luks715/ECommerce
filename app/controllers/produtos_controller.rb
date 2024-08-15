class ProdutosController < ApplicationController
  before_action :set_produto, only: [:show, :exibir_imagem, :edit, :update, :destroy]
  def index
    @produtos = Produto.all
  end

  def show
  end

  def exibir_imagem
    send_data produto.imagem, type: produto.imagem.content_type, disposition: 'inline'
  end

  def new
    @produto = Produto.new
  end

  def create
    @produto = Produto.new(produto_params)
    if @produto.save
      redirect_to @produto, notice: 'Produto criado com sucesso.'
    else
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
    redirect_to home_user_path, notice: 'Dicente foi excluído com sucesso.'
  end

  private

  def produto_params
    params.require(:produto).permit(:nome, :descricao, :preco, :categoria_id, :imagem, :emEstoque, :emPromocao)
  end

  def set_produto
    @produto = Produto.find(params[:id])
  end

end
