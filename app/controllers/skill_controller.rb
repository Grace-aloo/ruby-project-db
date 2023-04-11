class SkillController < AppController

    before do
        pass if ['/skill/create', '/skills', '/skills/user', '/skill/update/:id', '/skill/destroy/:id'].exclude?(request.path_info)
        begin
          verify_auth # Verify authorization header and extract uid
        rescue StandardError => e
          json_response(code:401,data:{error:'Unauthorized'}) # Return a 401 Unauthorized response
        end
      end

     # @method: Add a new Project to the DB
     post '/skill/create' do
        begin
            skill = user.skills.create( self.data(create: true) )
            json_response(code: 201, data: skill)
        rescue => e
            json_response(code: 422, data: { error: e.message })
        end
    end

    #Display all skills
    get '/skills'  do
        skills=Skill.all
        json_response(data: skills)
    end  

    get '/hello' do 
        "hi guys"
    end

    # @method: Display user specific skills
    get '/skills/user' do
        begin
            if user
                skills = user.skills
                json_response(data: skills)
            else
                json_response(code: 404, data: { error: "User with ID #{params[:user_id]} not found" })
            end
        rescue => e
            json_response(code: 422, data: { error: e.message })
        end
    end

     # @method: Update existing Project according to :id
    put '/skill/update/:id' do
        begin
            skill = user.skills.find(self.skill_id)
            skill.update(self.data)
            json_response(data: { message: "skill updated successfully" })
        rescue => e
            json_response(code: 422 ,data: { error: e.message })
        end
    end

    # @method: Delete project based on :id
    delete '/skill/destroy/:id' do
        begin
            skill = user.skills.find(self.skill_id)
            skill.destroy
            json_response(data: { message: "skill deleted successfully" })
        rescue => e
          json_response(code: 422, data: { error: e.message })
        end
    end

    private

    def skill_id
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