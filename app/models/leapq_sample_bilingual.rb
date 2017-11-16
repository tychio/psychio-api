class LeapqSampleBilingual < ApplicationRecord
  def self.save (sampleId, billingual)
    lanuages = billingual[:languages]
    if lanuages
      self.create({
        :sample_id => sampleId,
        :first_language_id => LeapqLanguage.get_id_by_name(lanuages[0]),
        :second_language_id => LeapqLanguage.get_id_by_name(lanuages[1]),
        :period => billingual[:value]
      })
    end
  end  
end
