class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def edit

  end

  def update

    # Atualiza os atributos do usuário
    if resource.update(account_update_params)
      set_flash_message :notice, :updated
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?
      respond_with resource, location: after_update_path_for(resource)
    else
      # Exibe erros de validação no console
      puts resource.errors.full_messages
      clean_up_passwords resource
      respond_with resource
    end
  end

  # Sobrescrevendo o método create para adicionar debug de erros de validação
  def create
    build_resource(sign_up_params)
    build_associations_for_role(resource)

    if params[:user][:imagem].present?
      @user.imagem = params[:user][:imagem].read
    end

    if resource.save
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      # Exibe erros de validação no console
      puts resource.errors.full_messages
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  private
  # Helper para construir associações dependendo do role
  def build_associations_for_role(user)
    if user.Cliente?
      user.build_cliente(cliente_params)
    elsif user.Vendedor?
      user.build_vendedor(vendedor_params)
    end
  end

  def cliente_params
    params[:user][:cliente_attributes].permit(:cpf)
  end

  def vendedor_params
    params[:user][:vendedor_attributes].permit(:cnpj, :email_para_contato)
  end

  # Permite os parâmetros adicionais durante a criação da conta
  def sign_up_params
    params.require(:user).permit(
      :nome, :email, :telefone, :endereco, :password, :imagem, :password_confirmation, :role,
      cliente_attributes: [:cpf],
      vendedor_attributes: [:cnpj, :email_para_contato]
    )
  end

  # Permite os parâmetros adicionais durante a atualização da conta
  def account_update_params
    params.require(:user).permit(
     :email, :telefone, :endereco, :password, :password_confirmation
    )
  end

  # Configura parâmetros para o sign up
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nome, :telefone, :endereco, :role, cliente_attributes: [:cpf], vendedor_attributes: [:cnpj, :email_para_contato]])
  end

  # Configura parâmetros para a atualização de conta
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :telefone, :endereco])
  end

  # Define o caminho após o sign up
  def after_sign_up_path_for(resource)
    # Defina o caminho desejado após o sign up
    root_path
  end

  # Define o caminho após a atualização de conta
  def after_update_path_for(resource)
    # Defina o caminho desejado após a atualização de conta
    edit_user_registration_path
  end
end
