class Users::RegistrationsController < Devise::RegistrationsController
  def resource_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation, profile_attributes: [:plate_number] )
  end
  private :resource_params
end