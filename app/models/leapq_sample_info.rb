class LeapqSampleInfo < ApplicationRecord
  def self.fill sampleId, info
    self.create({
      :sample_id => sampleId,
      :first_name => info[:firstname],
      :last_name => info[:lastname],
      :birthday => info[:birthday],
      :age => info[:age],
      :nation => info[:nation],
      :province => info[:province],
      :city => info[:city],
      :gender => info[:gender],
      :university => info[:university],
      :college => info[:college],
      :major => info[:major],
      :student_number => info[:studentnumber]
    })
  end
end
