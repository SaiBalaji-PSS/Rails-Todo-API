class ApplicationController < ActionController::API
  # this is needed if not rails will automatically wrap the body to outside hash
  attr_accessor :current_user
  wrap_parameters false
  before_action :check_authorisation
  def check_authorisation
    begin
    auth_header = request.headers["Authorization"]
    token_from_header = auth_header.split(" ")[1] if auth_header
    decoded_token = JwtHandler.decode_jwt_token(token_from_header)
    puts decoded_token

    @current_user = User.find_by({user_id: decoded_token[:user_id]})
    #puts @current_user.email
    rescue ActiveRecord::RecordNotFound
      render json: {message: "User not found"}, status: :ok
    rescue JWT::ExpiredSignature
      render json: {message: "The token has been expired"}, status: :ok
    rescue JWT::DecodeError
      render json:{message: "Unable to decode the given token"}, status: :ok
    rescue => e
      render json:{message: e.message}, status: :ok



    end
  end
end
