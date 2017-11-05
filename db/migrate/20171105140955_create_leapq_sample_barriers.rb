class CreateLeapqSampleBarriers < ActiveRecord::Migration[5.0]
  def change
    create_table :leapq_sample_barriers do |t|
      t.references :sample, foreign_key: {to_table: :leapq_samples}
      t.boolean :vision, :default => 0, :null => false
      t.boolean :hearing, :default => 0, :null => false
      t.boolean :language, :default => 0, :null => false
      t.boolean :study, :default => 0, :null => false
      t.text :explanation
      t.timestamps :null=>true, default: -> {'CURRENT_TIMESTAMP'}
    end
  end
end
