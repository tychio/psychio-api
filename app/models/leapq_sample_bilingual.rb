class LeapqSampleBilingual < ApplicationRecord
  def self.save (sampleId, billinguals)
    billinguals.each do |scene, billingual|
      if billingual[:isBilingual]
        languages = billingual[:languages]
        if languages
          self.create({
            :scene => scene,
            :sample_id => sampleId,
            :first_language_id => LeapqLanguage.get_id_by_name(languages[0]),
            :second_language_id => LeapqLanguage.get_id_by_name(languages[1]),
            :period => billingual[:value]
          })
        end
      end
    end
  end  
end
