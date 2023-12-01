class JsonWebToken
    SECRET_KEY = Rails.application.credentials.secret_key_base.to_s

    def self.encode(playload, exp = 24.hours.from_now)
        playload[:exp] = exp.to_i
        JWT.encode(playload, SECRET_KEY)
    end

    def self.decode(token)
        decoded = JWT.decode(token, SECRET_KEY).first
        HashWithIndifferentAccess.new decoded
    end  
end