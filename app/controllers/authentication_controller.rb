class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate
  # return auth token once user is authenticated
  def authenticate
    if User.exists?(email: auth_params[:email])
      auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
        render json: {
          code: 200,
          success: true,
          message: "Logged in Successfully",
          auth_token: auth_token
        }
    else
      render json: {
        code: 400,
        success: false,
        message: "Invalid credentials"
      }
    end
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end