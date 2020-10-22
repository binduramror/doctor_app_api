require 'json_web_token'
class V1::UsersController < ApplicationController
 before_action :authenticate_request!, only: [:logout]
 def create
  user = User.new(user_params)

  if user.save
    render json: {status: 'User created successfully'}, status: :created
  else
    render json: { errors: user.errors.full_messages }, status: :bad_request
  end
 end

 def login
   user = User.find_by(email: params[:email].to_s.downcase)

   if user && user.authenticate(params[:password])
     auth_token = JsonWebToken.encode({user_id: user.id})
     render json: {auth_token: auth_token}, status: :ok
   else
     render json: {error: 'Invalid username / password'}, status: :unauthorized
   end
 end

 def logout
   binding.pry
   user = User.find_by(id: @current_user.id)
   user.update(authentication_token: ' ')
   render json: { status: 'User logged out successfully' }, status: :ok
 end

 private

 def user_params
   params.permit(:email, :password, :password_confirmation)
 end
end