class LeapqSampleLanguage < ApplicationRecord
  def self.save (sampleId, levelLangs, timeLangs)
    levelLangs.each_with_index.map do |language, sequence|
      languageRecord = LeapqLanguage.find_by({ :name => language[:id] })
      self.create({
        :sample_id => sampleId,
        :language_id => languageRecord[:id],
        :level_seq => sequence,
        :time_seq => timeLangs.index{|timeLanguage| timeLanguage[:id] == language[:id]}
      })
    end
  end
end
