class UserController < AppController
    # @helper: read JSON body
    before do
        begin
          @user = user_data
        rescue
          @user = nil
        end
    end


   #@method: create a new user
   post '/auth/signup' do
    begin
      user = User.create(@user)
      unless user.save
        puts " errors: #{user.errors.full_messages}"
      end
      json_response(code: 201, data: user)
    rescue => e
      error_response(422, e)
    end
   end
     
    #@method: log in user using email and password
  post '/auth/login' do
    begin
      user_data = User.find_by(email: @user['email'])
      if user_data.password == @user['password']
        json_response(code: 200, data: {
          id: user_data.id,
          email: user_data.email
        })
      else
        json_response(code: 422, data: { message: "Your email/password combination is not correct" })
      end
    rescue => e
      error_response(422, e)
    end
  end
     
  private

  # @helper: parse user JSON data
  def user_data
    json_data = JSON.parse(request.body.read)
    puts "JSON data received: #{json_data}"
    json_data
    rescue JSON::ParserError => e
     puts "Failed to parse JSON data: #{e}"
      nil
   end


end