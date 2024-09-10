class ProdutosController < ApplicationController
  before_action :set_produto, only: [:show, :exibir_imagem, :edit, :update, :destroy]
  def index
    @produtos = Produto.all
  end

  def show
    @vendedor = @produto.vendedor
  end

  def exibir_imagem
    # send_data produto.imagem, type: produto.imagem.content_type, disposition: 'inline'
    
    # Mudança para exibir a imagem depois de criado
    if @produto.imagem.present?
      send_data @produto.imagem, type: 'image/png', disposition: 'inline'
    else
      # Exibir uma imagem padrão, caso a imagem não exista
      redirect_to asset_path('windows_!_icon.png')
    end
  end

  def new
    @vendedor = current_user.vendedor
    @categoria = Categorium.all
    @produto = Produto.new
  end

  def create
    @produto = current_user.vendedor.produtos.build(produto_params)
    
    # Verificação do valor da imagem
    Rails.logger.debug "Imagem recebida: #{params[:produto][:imagem].inspect}"

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
      ActiveRecord::Base.connection.execute("SELECT apagar_produto(#{@produto.id})")
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
