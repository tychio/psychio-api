class CreateLeapqSamples < ActiveRecord::Migration[5.0]
  def change
    create_table :leapq_samples do |t|
      t.string :phone, :limit => 20
      t.string :wechat, :limit => 50
      t.string :qq, :limit => 20
      t.integer :status, :default => :questionary
      t.boolean :is_active, :default => 1
      t.timestamps :updated_at, default: -> {'CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP'}
      t.datetime :created_at, :null=>false, default: -> {'CURRENT_TIMESTAMP'}
    end
  end
end
