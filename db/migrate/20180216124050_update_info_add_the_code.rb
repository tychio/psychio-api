class UpdateInfoAddTheCode < ActiveRecord::Migration[5.0]
  def change
  	rename_column :leapq_sample_infos, :first_name, :name
  	rename_column :leapq_sample_infos, :last_name, :code
  end
end
