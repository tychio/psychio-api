class CreateExperimentResults < ActiveRecord::Migration[5.0]
  def change
    create_table :experiment_results do |t|
      t.string  :name, :limit => 50
      t.json :pic
      t.json :lex_cn
      t.json :lex_ug
      t.json :flanker
      t.json :simon
      t.json :iq
      
      t.timestamps :updated_at, default: -> {'CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP'}
      t.datetime :created_at, :null=>false, default: -> {'CURRENT_TIMESTAMP'}
    end
  end
end
