class JwtHandler
  SECRET_KEY = "KUDOSHINICHI"
  def self.encode_jwt_token(payload,exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload,SECRET_KEY)
  end

  def self.decode_jwt_token(token)
    decoded_token = JWT.decode(token,SECRET_KEY) # payload and header  in array
    pay_load = decoded_token[0] # we need only payload
    return HashWithIndifferentAccess.new(pay_load)
  end

end