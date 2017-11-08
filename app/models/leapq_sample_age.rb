class LeapqSampleAge < ApplicationRecord
  def self.save (sampleId, ages, sampleLanguageIds)
    languagesAges = {}
    ages.each do |way, languages|
      languages.each do |language, age|
        languagesAges[language] = languagesAges[language] || {}
        languagesAges[language][way.to_sym] = age
      end
    end

    languagesAges.each do |language, age|
      languageId = LeapqLanguage.get_id_by_name(language)
      self.create({
        :sample_id => sampleId,
        :sample_language_id => sampleLanguageIds[languageId],
        :first => age[:first],
        :study => age[:study],
        :speak => age[:speak],
        :normal => age[:normal]
      })
    end
  end
end
