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

    # @method: Display all projects
    get '/skills' do
         skills = Skill.all
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
        if create
            payload["createdAt"] = Time.now
        end
        payload
    end
end