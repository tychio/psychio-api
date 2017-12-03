class LeapqSampleLanguage < ApplicationRecord
  belongs_to :leapq_language, :foreign_key => 'language_id'

  def self.save (sampleId, levelLangs, timeLangs)
    levelLangs.each_with_index.map do |language, sequence|
      languageId = LeapqLanguage.get_id_by_name(language[:id])
      self.create({
        :sample_id => sampleId,
        :language_id => languageId,
        :level_seq => sequence,
        :time_seq => timeLangs.index{|timeLanguage| timeLanguage[:id] == language[:id]}
      })
    end
  end

  def self.mapper sampleLanguages
    sampleLanguageIds = {}
    sampleLanguages.each do |sampleLanguage|
      sampleLanguageIds[sampleLanguage[:language_id]] = sampleLanguage[:id]
    end
    sampleLanguageIds
  end
end
