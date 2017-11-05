class CreateLeapqLanguages < ActiveRecord::Migration[5.0]
  def change
    create_table :leapq_languages do |t|
    	t.string :name, :limit => 20
    	t.string :display, :limit => 10
      t.timestamps :updated_at, default: -> {'CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP'}
      t.datetime :created_at, :null=>false, default: -> {'CURRENT_TIMESTAMP'}
    end
  end
end
