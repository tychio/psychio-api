class LeapqSampleInfo < ApplicationRecord
  def self.fill id, info
    self.create({
      :sample_id => id,
      :first_name => info[:firstname],
      :last_name => info[:lastname],
      :birthday => info[:birthday],
      :age => info[:age],
      :gender => info[:gender],
      :university => info[:university],
      :college => info[:college],
      :major => info[:major],
      :student_number => info[:studentnumber]
    })
  end
end
