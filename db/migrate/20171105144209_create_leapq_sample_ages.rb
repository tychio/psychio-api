class CreateLeapqSampleAges < ActiveRecord::Migration[5.0]
  def change
    create_table :leapq_sample_ages do |t|
      t.references :sample, foreign_key: {to_table: :leapq_samples}
      t.references :leapq_sample_language, foreign_key: true
      t.integer :first
      t.integer :study
      t.integer :speak
      t.integer :normal
      t.timestamps :null=>true, default: -> {'CURRENT_TIMESTAMP'}
    end
  end
end
