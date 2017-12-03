class CreateAnalysisGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :analysis_groups do |t|

      t.timestamps
    end
  end
end
