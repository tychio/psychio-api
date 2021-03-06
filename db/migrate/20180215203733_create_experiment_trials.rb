class CreateExperimentTrials < ActiveRecord::Migration[5.0]
  def change
    create_table :experiment_trials do |t|
      t.string  :key, :limit => 50
      t.string :name
      t.integer :seq
      t.integer :kind, :default => :pic
      t.json :question
      t.integer :answer
      t.integer :speed
      t.json :raw
      
      t.timestamps :updated_at, default: -> {'CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP'}
      t.datetime :created_at, :null=>false, default: -> {'CURRENT_TIMESTAMP'}
    end

    add_index :experiment_trials, [:key, :seq, :kind], :unique => true
  end
end
