class LeapqSampleScore < ApplicationRecord
  def self.save (sampleId, scores, sampleLanguageIds)
    languageScores = {}
    scores.each do |item, ways|
      ways.each do |way, languages|
        languages.each do |language, score|
          languageScores[language] = languageScores[language] || {}
          languageScores[language][[item, way].join('_')] = score
        end
      end
    end

    languageScores.map do |language, scores|
      languageId = LeapqLanguage.get_id_by_name(language)
      scores[:sample_id] = sampleId
      scores[:sample_language_id] = sampleLanguageIds[languageId]
      self.create(scores)
    end
  end
end
