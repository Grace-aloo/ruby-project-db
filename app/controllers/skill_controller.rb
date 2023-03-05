class SkillController < AppController

     # @method: Add a new Project to the DB
     post '/skill/create' do
        begin
            skill = Skill.create( self.data(create: true) )
            json_response(code: 201, data: skill)
        rescue => e
            json_response(code: 422, data: { error: e.message })
        end
    end
    get '/users/:user_id/skills' do
        user_id = params[:user_id]
        if user_id.nil?
          status 400
          json_response(error: 'User ID parameter is missing')
        else
          user = User.find(user_id)
          skills = user.skills
          json_response(data: skills)
        end
    end  
    #Display all skills
    get '/skills'  do
        skills=Skill.all
        json_response(data: skills)
    end  

    # @method: Display projects user specific skills
    get '/skills/:user_id' do
        user_id = params[:user_id]
        skills = Skill.where(user_id: user_id)
        json_response(data: skills)
    end

     # @method: Update existing Project according to :id
    put '/skills/update/:id' do
        begin
            skill = Skill.find(self.skill_id)
            skill.update(self.data)
            json_response(data: { message: "todo updated successfully" })
        rescue => e
            json_response(code: 422 ,data: { error: e.message })
        end
    end

    # @method: Delete project based on :id
    delete '/skill/destroy/:id' do
        begin
            skill = Skill.find(self.skill_id)
            skill.destroy
            json_response(data: { message: "todo deleted successfully" })
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
        puts "the payload is : #{payload}"
        payload
        rescue JSON::ParserError => e 
            puts "Failed to parse JSON data: #{e}"
            nil
    end
end