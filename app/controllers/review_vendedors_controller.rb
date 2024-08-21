class ReviewVendedorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:destroy]
  before_action :set_vendedor, only: [:new, :create]

  # GET /reviews/new
  def new
    @reviewVendedor = ReviewVendedor.new
  end

  # POST /reviews
  def create
    @reviewVendedor = ReviewVendedor.new(review_params)
    @reviewVendedor.cliente = current_user.cliente

    if  @reviewVendedor.save
      ClienteVendedor.find_by(vendedor:  @reviewVendedor.vendedor, cliente:  @reviewVendedor.cliente).destroy
      redirect_to vendedor_path( @reviewVendedor.vendedor), notice: 'Review de vendedor criada com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /reviews/:id
  def destroy
    @reviewVendedor.destroy
    redirect_to  @reviewVendedor.vendedor, notice: 'Review de vendedor removida com sucesso.'
  end

  private

  def set_review
    @reviewVendedor = ReviewVendedor.find(params[:id])
  end

  def set_vendedor
    @vendedor = Vendedor.find_by(id: params[:vendedor_id])
  end

  def review_params
    params.require(:review_vendedor).permit(:nota, :comentario, :vendedor_id)
  end
end
