class CreateLeapqSampleInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :leapq_sample_infos do |t|
      t.references :sample, foreign_key: {to_table: :leapq_samples}
      t.string :first_name, :limit => 20
      t.string :last_name, :limit => 20
      t.date :birthday
      t.integer :age, :limit => 4
      t.boolean :gender, :default => 0
      t.string :university, :limit => 20
      t.string :college, :limit => 20
      t.string :major, :limit => 30
      t.string :student_number, :limit => 20
      t.timestamps :null=>true, default: -> {'CURRENT_TIMESTAMP'}
    end
  end
end
