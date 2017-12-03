class CreateAnalysisGroup < ActiveRecord::Migration[5.0]
  def change
    create_table :analysis_group do |t|
    t.string  :name, :limit => 50
    t.string  :phone, :limit => 20
    t.string  :qq, :limit => 20
    t.string  :wechat, :limit => 50
    t.integer :lang1_speaking_self
    t.integer :lang2_speaking_self
    t.integer :lang1_listening_self
    t.integer :lang2_listening_self
    t.integer :lang1_reading_self
    t.integer :lang2_reading_self
    t.integer :lang1_reading_use
    t.integer :lang2_reading_use
    t.integer :lang1_speaking_use
    t.integer :lang2_speaking_use
    t.integer :lang1_listening_use
    t.integer :lang2_listening_use
    t.integer :lang1_writing_use
    t.integer :lang2_writing_use
    t.integer :lang1_start_age
    t.integer :lang2_start_age
    t.integer :lang1_learn_age
    t.integer :lang2_learn_age
    t.integer :lang1_l_instrcution_age
    t.integer :lang2_l_instrcution_age
    t.integer :lang1_c_instrcution_age
    t.integer :lang2_c_instrcution_age
  end
  end
end
