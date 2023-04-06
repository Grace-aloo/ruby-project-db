require 'net/http'
require 'rufus-scheduler'

class AppController < Sinatra::Base
    configure do
        enable :cross_origin
        enable :sessions
    end

    before do
        response.headers['Access-Control-Allow-Origin'] = '*'
        response.headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS'
        response.headers['Access-Control-Allow-Headers'] = 'Content-Type, Authorization, X-Requested-With'
    end

    options "*" do
        response.headers["Allow"] = "GET, PUT, POST, DELETE, OPTIONS"
        response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
        response.headers["Access-Control-Allow-Origin"] = "*"
        200
    end

    def json_response(code: 200, data: nil)
        status = [200, 201].include?(code) ? "SUCCESS" : "FAILED"
        headers['Content-Type'] = 'application/json'
        if data
          [ code, { data: data, message: status }.to_json ]
        end
    end
    
     # @api: Format all common JSON error responses
    def error_response(code, e)
        json_response(code: code, data: { error: e.message }.to_json)
    end
  
     # @helper: not found error formatter
     def not_found_response
       json_response(code: 404, data: { error: "You seem lost. That route does not exist." }.to_json)
     end

    # @api: 404 handler
    not_found do
        not_found_response
    end

    #to keep the server alive
      
      scheduler = Rufus::Scheduler.new
      
      scheduler.every '5m' do
        puts "keep_alive called at #{Time.now}"
        uri = URI('https://grace-portfolio-app.onrender.com')
        Net::HTTP.get(uri)
      end

      def encode(uid, email)
        begin
          payload = {
            data: {
              uid: uid,
              email: email
            },
            exp: Time.now.to_i + (24 * 3600)
          }
          JWT.encode(payload, ENV['movies_key'], 'HS256')
        rescue JWT::EncodeError => e
          error_response(500, e)
        end
      end
  
        # Decode JWT token
      def decode(token)
        begin
          JWT.decode(token, ENV['movies_key'], true, { algorithm: 'HS256' })
        rescue JWT::DecodeError => e
          error_response(401, e)
        end
      end


    # get logged in user
    def user
        User.find(@uid) 
    end

    # Verify Authorization header and extract uid
    def verify_auth
      auth_headers = request.headers['Authorization']
      if auth_headers.blank?
        error_response(401, 'Your request is not authorized')
      else
        token = auth_headers.split(' ')[1]
        begin
          @uid = decode(token)[0]['data']['uid'].to_i
        rescue JWT::DecodeError => e
          error_response(401, e)
        end
      end
    end
    
      #get and save user_id
      def save_user(token)
        @uid = decode(token)[0]["data"]["uid"].to_i
    end

    #delete jwt token 
    def remove_user 
        token = nil
        json_response(code: 204)
    end


    
end 