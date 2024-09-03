class Users::RegistrationsController < Devise::RegistrationsController
  private

  # Permite os parâmetros adicionais durante a criação da conta
  def sign_up_params
    params.require(:user).permit(:nome, :email, :telefone, :endereco, :password, :password_confirmation, :role, cliente_attributes: [:campo_cliente_1, :campo_cliente_2], vendedor_attributes: [:campo_vendedor_1, :campo_vendedor_2])
  end

  # Permite os parâmetros adicionais durante a atualização da conta
  def account_update_params
    params.require(:user).permit(:nome, :email, :telefone, :endereco, :password, :password_confirmation, :current_password, :role, cliente_attributes: [:campo_cliente_1, :campo_cliente_2], vendedor_attributes: [:campo_vendedor_1, :campo_vendedor_2])
  end
end
