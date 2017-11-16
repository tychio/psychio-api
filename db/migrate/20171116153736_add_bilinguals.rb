class AddBilinguals < ActiveRecord::Migration[5.0]
  def change
  	add_column :leapq_sample_bilinguals, :scene, :string, :limit => 20, :default => 'school'
  end
end
