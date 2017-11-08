class CreateLeapqSamplePeriods < ActiveRecord::Migration[5.0]
  def change
    create_table :leapq_sample_periods do |t|
      t.references :sample, foreign_key: {to_table: :leapq_samples}
      t.references :sample_language, foreign_key: {to_table: :leapq_sample_languages}
      t.integer :school
      t.integer :home
      t.integer :community
      t.timestamps :null=>true, default: -> {'CURRENT_TIMESTAMP'}
    end
  end
end
