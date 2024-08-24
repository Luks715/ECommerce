class ReviewProdutosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:destroy]
  before_action :set_produto, only: [:new, :create]

  # GET /reviews/new
  def new
    @reviewProduto = ReviewProduto.new
  end

  # POST /reviews
  def create
    @reviewProduto = ReviewProduto.new(review_params)
    @reviewProduto.cliente = current_user.cliente

    if @reviewProduto.save
      ClienteProduto.find_by(produto: @reviewProduto.produto, cliente: @reviewProduto.cliente).destroy
      redirect_to @reviewProduto.produto, notice: 'Review de produto criada com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /reviews/:id
  def destroy
    @reviewProduto.destroy
    redirect_to @reviewProduto.cliente, notice: 'Review de produto removida com sucesso.'
  end

  private

  def set_review
    @reviewProduto = ReviewProduto.find(params[:id])
  end

  def set_produto
    @produto = Produto.find_by(id: params[:produto_id])
  end

  def review_params
    params.require(:review_produto).permit(:nota, :comentario, :produto_id)
  end
end
