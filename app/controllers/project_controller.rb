class ProjectController < AppController

     # @method: Add a new Project to the DB
    post '/project/create' do
        begin
            project = Project.create( self.data(create: true) )
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
    get '/projects/:user_id' do
        user_id = params[:user_id]
        projects = Project.where(user_id: user_id)
        json_response(data: projects)
    end

     # @method: Update existing Project according to :id
    put '/projects/update/:id' do
        begin
            project = Project.find(self.project_id)
            project.update(self.data)
            json_response(data: { message: "todo updated successfully" })
        rescue => e
            json_response(code: 422 ,data: { error: e.message })
        end
    end

    # @method: Delete project based on :id
    delete '/project/destroy/:id' do
        begin
            project = Project.find(self.project_id)
            project.destroy
            json_response(data: { message: "todo deleted successfully" })
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
        puts "the payload is : #{payload}"
        payload
    rescue JSON::ParserError => e 
        puts "Failed to parse JSON data: #{e}"
        nil
    end
end