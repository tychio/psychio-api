class AddColumnOfGroupForDifferentMode < ActiveRecord::Migration[5.0]
  def change
  	add_column :leapq_sample_groups, :group_mode, :integer, after: :group, default: 1
  end
end
