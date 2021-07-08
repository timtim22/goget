class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create
  # POST /signup
  # return authenticated token upon signup
  def create
    if !User.exists?(email: params[:email])
      if !params[:is_gogetter].blank?
        user = User.create!(user_params)
        auth_token = AuthenticateUser.new(user.email, user.password).call
        response = { message: Message.account_created, auth_token: auth_token }
        render json: {
          code: 200,
          success: true,
          message: response,
          data: user
          }
      else
        render json: {
          code: 400,
          success: false,
          message: "is_gogetter cant be blank"
          }
      end
    else
      render json: {
          code: 200,
          success: true,
          message: "User available with #{params[:email]}"
        }
    end
  end

  private

  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :is_gogetter
    )
  end
end