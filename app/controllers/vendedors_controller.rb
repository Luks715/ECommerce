class VendedorsController < ApplicationController
  before_action :set_vendedor, only: [:show, :edit, :update]

  def index
    @vendedores = Vendedor.all
  end

  def show
    @usuario = @vendedor.user
    @produtos = @vendedor.produtos
  end

  def edit

  end

  def update
    if @vendedor.update(vendedor_params)
      flash[:success] = "Email de contato atualizado com sucesso."
      redirect_to @vendedor
    else
      flash[:error] = "Erro ao atualizar o email de contato."
      render :edit
    end
  end

  private

  def set_vendedor
    @vendedor = Vendedor.find(params[:id])
  end

  def vendedor_params
    params.require(:vendedor).permit(:email_para_contato)
  end
end
