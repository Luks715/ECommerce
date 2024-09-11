class ProdutosController < ApplicationController
  before_action :set_produto, only: [:show, :edit, :update, :destroy]
  def index
    @produtos = Produto.all
  end

  def show
    @vendedor = @produto.vendedor
  end

  def new
    @produto = Produto.new
    @vendedor = current_user.vendedor
    @categoria = Categorium.all
  end

  def create
    @produto = current_user.vendedor.produtos.build(produto_params)

    if params[:produto][:imagem].present?
      @produto.imagem = params[:produto][:imagem].read
    end

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
    if params[:produto][:imagem].present?
      @produto.imagem = params[:produto][:imagem].read
    end

    if @produto.update(produto_params)
      redirect_to @produto, notice: 'Produto atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    if @produto.apagar_produto == true
      redirect_to @produto.vendedor, notice: 'Produto excluído com sucesso'
    else
      redirect_to @produto, alert: 'Falha em excluir o produto'
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
