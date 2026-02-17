class Api::V1::AuthController < ApplicationController
  # skip token check for login and sign up
  skip_before_action :check_authorisation, only: [:create_user,:login]
  def create_user
    user = User.new(credential_params)
    if user.save
      # render json:{message: "User created successfully"}, status: :created
      self.login
    else
      render json:{message: user.errors.full_messages.to_sentence}, status: :ok
    end

  end
  def login
    matched_user = User.find_by({email: credential_params[:email]})
    if matched_user.nil?
      render json: {message: "Invalid email"}, status: :ok
    else
      if matched_user.authenticate(credential_params[:password])
        jwt_token = JwtHandler.encode_jwt_token({user_id:matched_user.user_id})
        render json:{message: "Login Success",token: jwt_token}, status: :ok
      else
        render json:{message: "Invalid password"}, status: :ok
      end
    end
  end

  def delete_user

    if current_user.destroy
      render json: {message: "Your account has been deleted successfully"}, status: :ok
    else
      render json: {message: "Unable to delete the account"}, status: :ok
    end

  end


  def get_user
    if current_user.nil?
      render json:{message: "User not found"}, status: :ok
    else
      render json: {user: current_user}, status: :ok
    end
  end

  def credential_params
    params.permit(:email,:password,:user_name)
  end
end
