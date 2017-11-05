class CreateLeapqSampleLanguages < ActiveRecord::Migration[5.0]
  def change
    create_table :leapq_sample_languages do |t|
      t.references :sample, foreign_key: {to_table: :leapq_samples}
      t.references :language_id, foreign_key: {to_table: :leapq_languages}
      t.integer :level_seq, :limit => 3
      t.integer :time_seq, :limit => 3
      t.timestamps :null=>true, default: -> {'CURRENT_TIMESTAMP'}
    end
  end
end
