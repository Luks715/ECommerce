class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:destroy]
  before_action :set_vendedor_and_produto, only: [:new, :create]

  # GET /reviews/new
  def new
    @review = Review.new
    @review.produto = @produto
    @review.vendedor = @vendedor
  end

  # POST /reviews
  def create
    @review = Review.new(review_params)
    @review.cliente = current_user.cliente

    if @review.save
      if @review.produto.present?
        ClienteProduto.find_by(produto: @review.produto, cliente: @review.cliente).destroy
        redirect_to @review.produto, notice: 'Review de produto criada com sucesso.'
      else
        ClienteVendedor.find_by(vendedor: @review.vendedor, cliente: @review.cliente).destroy
        redirect_to @review.vendedor, notice: 'Review de vendedor criada com sucesso.'
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /reviews/:id
  def destroy
    @review.destroy
    if @review.produto.present?
      redirect_to @review.produto, notice: 'Review de produto removida com sucesso.'
    else
      redirect_to @review.vendedor, notice: 'Review de vendedor removida com sucesso.'
    end
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def set_vendedor_and_produto
    @vendedor = Vendedor.find_by(id: params[:vendedor_id])
    @produto = Produto.find_by(id: params[:produto_id])
  end

  def review_params
    params.require(:review).permit(:nota, :comentario, :produto_id, :vendedor_id)
  end
end
