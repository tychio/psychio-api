class AnalysisGroup < ApplicationRecord
  def self.collect
    samples = LeapqSample.where(:is_active => 1)
    samples.each do |sample|
      sample_detail = sample.get
      info = sample_detail[:info]
      levels = sample_detail[:levels]
      ages = sample_detail[:ages]
      scores = sample_detail[:scores]
      comment = [info[:first_name], info[:last_name]].join " "

      self.find_or_create_by({
        :phone => sample[:phone],
        :qq => sample[:qq],
        :wechat => sample[:wechat]
      }) do |group|
        group.phone = sample[:phone]
        group.qq = sample[:qq]
        group.wechat = sample[:wechat]
        group.lang1_reading_use = levels[:lang1_reading_use]
        group.lang2_reading_use = levels[:lang2_reading_use]
        group.lang1_speaking_use = levels[:lang1_speaking_use]
        group.lang2_speaking_use = levels[:lang2_speaking_use]
        group.lang1_listening_use = levels[:lang1_listening_use]
        group.lang2_listening_use = levels[:lang2_listening_use]
        group.lang1_writing_use = levels[:lang1_writing_use]
        group.lang2_writing_use = levels[:lang2_writing_use]
        group.lang1_start_age = ages[:lang1_start_age]
        group.lang2_start_age = ages[:lang2_start_age]
        group.lang1_learn_age = ages[:lang1_learn_age]
        group.lang2_learn_age = ages[:lang2_learn_age]
        group.lang1_l_instruction_age = ages[:lang1_l_instruction_age]
        group.lang2_l_instruction_age = ages[:lang2_l_instruction_age]
        group.lang1_c_instruction_age = ages[:lang1_c_instruction_age]
        group.lang2_c_instruction_age = ages[:lang2_c_instruction_age]
        group.lang1_reading_self = scores[:lang1_reading_self]
        group.lang2_reading_self = scores[:lang2_reading_self]
        group.lang1_speaking_self = scores[:lang1_speaking_self]
        group.lang2_speaking_self = scores[:lang2_speaking_self]
        group.lang1_listening_self = scores[:lang1_listening_self]
        group.lang2_listening_self = scores[:lang2_listening_self]
        group.name = comment
      end
    end
  end
end
