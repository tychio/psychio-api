class CreateLeapqSampleLevels < ActiveRecord::Migration[5.0]
  def change
    create_table :leapq_sample_levels do |t|
      t.references :sample, foreign_key: {to_table: :leapq_samples}
      t.references :sample_language, foreign_key: {to_table: :leapq_sample_languages}
      t.integer :touch, :limit => 4
      t.integer :read, :limit => 4
      t.integer :speak, :limit => 4
      t.integer :write, :limit => 4
      t.timestamps :null=>true, default: -> {'CURRENT_TIMESTAMP'}
    end
  end
end
