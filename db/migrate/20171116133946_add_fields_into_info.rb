class AddFieldsIntoInfo < ActiveRecord::Migration[5.0]
  def change
  	add_column :leapq_sample_infos, :nation, :string, :limit => 20
  	add_column :leapq_sample_infos, :province, :string, :limit => 20
  	add_column :leapq_sample_infos, :city, :string, :limit => 20
  end
end
