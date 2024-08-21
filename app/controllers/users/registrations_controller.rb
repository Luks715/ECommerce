class Users::RegistrationsController < ApplicationController
  ##
  # Configuração dos parâmetros permitidos para registro de usuário.
  #
  # Comportamento:
  # - Define quais parâmetros são permitidos durante o processo de registro de usuário.
  #
  # Exemplo de Uso:
  #   # Permite os parâmetros 'nome' e 'role' durante o registro de usuário.
  #   Users::RegistrationsController.configure_permitted_parameters
  #
  def new
    super
  end

  def create
    super do |resource|
      if resource.persisted? # Usuário foi criado com sucesso
        case resource.role
        when 'Cliente'
          Cliente.create(user: resource, cpf: params[:user][:cpf])
        when 'Vendedor'
          Vendedor.create(user: resource, emailParaContato: params[:user][:emailParaContato], cnpj: params[:user][:cnpj])
        end
      end
    end
  end

  def update
    super
  end
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nome, :telefone, :endereco, :role, :cpf, :saldo, :emailParaContato, :cnpj, :carteira])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nome, :telefone, :endereco, :cpf, :saldo, :emailParaContato, :cnpj, :carteira])
  end
end
