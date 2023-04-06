class ProjectController < AppController
    
    before do
        pass if ['/project/create', '/projects', '/projects/user', '/project/update/:id', '/project/destroy/:id'].exclude?(request.path_info)
        begin
          verify_auth # Verify authorization header and extract uid
        rescue StandardError => e
          error_response(401, 'Unauthorized') # Return a 401 Unauthorized response
        end
      end

     # @method: Add a new Project to the DB
    post '/project/create' do
        begin
            project = user.projects.create( self.data(create: true) )
            json_response(code: 201, data: project)
        rescue => e
            json_response(code: 422, data: { error: e.message })
        end
    end

    # @method: Display all projects
    get '/projects' do
        projects = Project.all
        json_response(data: projects)
    end

    #get user specific projects
    get '/projects/user' do
        begin
            if user
                projects = user.projects
                json_response(data: projects)
            else
                json_response(code: 404, data: { message: "User with ID #{params[:user_id]} not found" })
            end
        rescue => e
            json_response(code: 422, data: { error: e.message })
        end
    end
    

     # @method: Update existing Project according to :id
    put '/project/update/:id' do
        begin
            project = user.projects.find(self.project_id)
            project.update(self.data)
            json_response(data: { message: "project updated successfully" })
        rescue => e
            json_response(code: 422 ,data: { error: e.message })
        end
    end

    # @method: Delete project based on :id
    delete '/project/destroy/:id' do
        begin
            project = user.projects.find(self.project_id)
            project.destroy
            json_response(data: { message: "project deleted successfully" })
        rescue => e
          json_response(code: 422, data: { error: e.message })
        end
    end

    private

    def project_id
        params['id'].to_i
    end

    # @helper: format body data
    def data(create: false)
        payload = JSON.parse(request.body.read)
        # puts "the payload is : #{payload}"
        payload
    rescue JSON::ParserError => e 
        # puts "Failed to parse JSON data: #{e}"
        nil
    end
end