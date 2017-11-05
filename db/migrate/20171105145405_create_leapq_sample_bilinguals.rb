class CreateLeapqSampleBilinguals < ActiveRecord::Migration[5.0]
  def change
    create_table :leapq_sample_bilinguals do |t|
      t.references :sample, foreign_key: {to_table: :leapq_samples}
      t.references :first_language, foreign_key: {to_table: :leapq_sample_languages}
      t.references :second_language, foreign_key: {to_table: :leapq_sample_languages}
      t.integer :period, :limit => 4
      t.timestamps :null=>true, default: -> {'CURRENT_TIMESTAMP'}
    end
  end
end
