class AppController < Sinatra::Base
    configure do
        enable :cross_origin
    end

    before do
        response.headers['Access-Control-Allow-Origin'] = '*'
        # response.headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS'
        # response.headers['Access-Control-Allow-Headers'] = 'Content-Type, Authorization, X-Requested-With'
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

    
end 