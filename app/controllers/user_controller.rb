class UserController < AppController
    # @helper: read JSON body
    before do
        begin
          @user = user_data
        rescue
          @user = nil
        end
    end

     # @before_filter: Verify authorization before certain routes

  before do
    pass if ['/user/:id', '/auth/login'].exclude?(request.path_info)
    begin
      verify_auth # Verify authorization header and extract uid
    rescue StandardError => e
      error_response(401, 'Unauthorized') # Return a 401 Unauthorized response
    end
  end

   #@method: create a new user
   post '/auth/signup' do
    begin
      user = User.create(@user)
      unless user.save
        puts " errors: #{user.errors.full_messages}"
      end
      save_user(user.id)
      json_response(code: 201, data: user)
    rescue => e
      error_response(422, e)
    end
   end

     # Define a route for retrieving a user by ID
  get '/user/:id' do
    begin
  # Retrieve the user from your database or data source
  user = User.find(params[:id])
  # If the user is found, return their details as JSON
  if user
    json_response( code:200, data:
    { id: user.id, name: user.name, email: user.email })
  else
    # If the user is not found, return a 404 error
    json_response(code: 404, data:
    { message: "User with ID #{params[:id]} not found" })
  end
rescue => e
  error_response(422,e)
  end 
end
     
    #@method: log in user using email and password
  post '/auth/login' do
    begin
      user_data = User.find_by(email: @user['email'])
      if user_data.password == @user['password']
        save_user(user_data.id)
        token = encode(user_data.id,user_data.email)
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

  delete '/logout' do
    begin
      verify_auth # Verify authorization header and extract uid
      remove_user # Call method to remove user session or perform other logout actions
      # json_response(code: 200, data: { message: 'Logged out successfully' }.to_json)
    rescue StandardError => e
      error_response(500, e)
    end
  end

     
  private

  # @helper: parse user JSON data
  def user_data
    json_data = JSON.parse(request.body.read)
    json_data
    rescue JSON::ParserError => e
      nil
   end

   def user_id
    params['id'].to_i
   end 

   

private




end