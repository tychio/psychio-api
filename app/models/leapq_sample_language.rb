class LeapqSampleLanguage < ApplicationRecord
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
end
