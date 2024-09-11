class ClientesController < ApplicationController
  before_action :set_cliente, only: [:show, :add_saldo]

  def show
    @usuario = @cliente.user
    @carrinho = @usuario.carrinho
  end

  def edit

  end

  def add_saldo
    if request.patch? # Para requisições PATCH, processa a adição de saldo
      if params[:valor].present? && params[:valor].to_f > 0
        novo_saldo = @cliente.saldo + params[:valor].to_f
        if @cliente.update(saldo: novo_saldo)
          redirect_to @cliente, notice: 'Saldo adicionado com sucesso.'
        else
          flash.now[:alert] = 'Erro ao adicionar saldo.'
          render :add_saldo
        end
      else
        flash.now[:alert] = 'Por favor, insira um valor válido para o saldo.'
        render :add_saldo
      end
    else
      # Renderiza a view add_saldo para requisições GET
      render :add_saldo
    end
  end

  private

  def set_cliente
    @cliente = Cliente.find(params[:id])
  end
end
