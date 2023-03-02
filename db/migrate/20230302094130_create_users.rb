class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :firstname, null:false
      t.string :lastname, null:false
      t.string :email, null:false, index: {unique: true, name: 'uk_email'}
      t.string :password_hash, null:false
      t.string :user_name 
      t.string :job
      t.timestamps
    end
  end
end
