class LeapqSampleGroup < ApplicationRecord
  enum group: [:lang1, :lang2, :balance]

  def self.createByPhone(phone, group)
    sample = LeapqSample.find_by :phone => phone
    if sample.present?
      sample_group = self.find_or_create_by({
        :sample_id => sample.id
      })
      sample_group.update({
        :group => group
      })
    end
  end
end
