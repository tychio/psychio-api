class CreateLeapqSampleGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :leapq_sample_groups do |t|
      t.references :sample, foreign_key: {to_table: :leapq_samples}
      t.integer :group, :default => :lang1
      t.timestamps :null=>true, default: -> {'CURRENT_TIMESTAMP'}
    end
  end
end
