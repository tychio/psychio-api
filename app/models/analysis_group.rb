class AnalysisGroup < ApplicationRecord
  def self.collect
    samples = LeapqSample.where(:is_active => 1)
    samples.each do |sample|
      sample_detail = sample.get
      info = sample_detail[:info]
      comment = [info[:first_name], info[:last_name]].join " "
      
      self.create({
        :phone => sample[:phone],
        :qq => sample[:qq],
        :wechat => sample[:wechat],
        :lang1_reading_use => 0,
        :lang2_reading_use => 0,
        :lang1_speaking_use => 0,
        :lang2_speaking_use => 0,
        :lang1_listening_use => 0,
        :lang2_listening_use => 0,
        :lang1_writing_use => 0,
        :lang2_writing_use => 0,
        :lang1_start_age => 0,
        :lang2_start_age => 0,
        :lang1_learn_age => 0,
        :lang2_learn_age => 0,
        :lang1_l_instruction_age => 0,
        :lang2_l_instruction_age => 0,
        :lang1_c_instruction_age => 0,
        :lang2_c_instruction_age => 0,
        :lang1_reading_self => 0,
        :lang2_reading_self => 0,
        :lang1_speaking_self => 0,
        :lang2_speaking_self => 0,
        :lang1_listening_self => 0,
        :lang2_listening_self => 0,
        :name => comment
      })
    end
  end
end
