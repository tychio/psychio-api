class CreateLeapqSampleScores < ActiveRecord::Migration[5.0]
  def change
    create_table :leapq_sample_scores do |t|
      t.references :sample, foreign_key: {to_table: :leapq_samples}
      t.integer :level_speak
      t.integer :level_listen
      t.integer :level_read
      t.integer :impact_family
      t.integer :impact_friend
      t.integer :impact_school
      t.integer :impact_broadcast
      t.integer :impact_read
      t.integer :impact_tv
      t.integer :impact_network
      t.integer :impact_social
      t.integer :touch_family
      t.integer :touch_friend
      t.integer :touch_school
      t.integer :touch_broadcast
      t.integer :touch_read
      t.integer :touch_tv
      t.integer :touch_network
      t.integer :touch_social
      t.integer :oral_speak
      t.integer :oral_listen
      t.timestamps :null=>true, default: -> {'CURRENT_TIMESTAMP'}
    end
  end
end
