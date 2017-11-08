class LeapqSamplePeriod < ApplicationRecord
  def self.save (sampleId, periods, sampleLanguageIds)
    languagesPeriods = {}
    periods.each do |way, languages|
      languages.each do |language, period|
        languagesPeriods[language] = languagesPeriods[language] || {}
        languagesPeriods[language][way.to_sym] = period
      end
    end

    languagesPeriods.each do |language, period|
      languageId = LeapqLanguage.get_id_by_name(language)
      self.create({
        :sample_id => sampleId,
        :sample_language_id => sampleLanguageIds[languageId],
        :school => period[:school],
        :home => period[:home],
        :community => period[:community]
      })
    end
  end
end
