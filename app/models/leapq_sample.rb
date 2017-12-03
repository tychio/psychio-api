class LeapqSample < ApplicationRecord
  enum status: [:questionary, :totest, :tested]

  has_one :leapq_sample_info, :foreign_key => 'sample_id'
  has_many :leapq_sample_languages, :foreign_key => 'sample_id'
  has_many :leapq_sample_levels, :foreign_key => 'sample_id'

  def self.signup info
    self.create({
      :phone => info[:phone],
      :wechat => info[:wechat],
      :qq => info[:qq],
      :status => :questionary
    })
  end

  def get
    languageIds = prepare_language_ids
    levels = prepare_levels languageIds

    {
      :info => self.leapq_sample_info,
      :languages => languageIds,
      :levels => levels
    }
  end

  def fill_info info
    LeapqSampleInfo.fill(self.id, info)
  end

  def sort_languages data
    levelLangs = data[:levelLanguages]
    timeLangs = data[:timeLanguages]
    LeapqSampleLanguage.save(self.id, levelLangs, timeLangs)
  end

  def save_rates (rates, sampleLanguages)
    sampleLanguageIds = LeapqSampleLanguage.mapper(sampleLanguages)
    LeapqSampleLevel.save(self.id, rates, sampleLanguageIds)
  end

  def save_barriers barriers
    LeapqSampleBarrier.save(self.id, barriers)
  end

  def save_ages (ages, sampleLanguages)
    sampleLanguageIds = LeapqSampleLanguage.mapper(sampleLanguages)
    LeapqSampleAge.save(self.id, ages, sampleLanguageIds)
  end

  def save_periods (periods, sampleLanguages)
    sampleLanguageIds = LeapqSampleLanguage.mapper(sampleLanguages)
    LeapqSamplePeriod.save(self.id, periods, sampleLanguageIds)
  end

  def save_bilinguals bilinguals
    LeapqSampleBilingual.save(self.id, bilinguals)
  end

  def mark (scores, sampleLanguages)
    sampleLanguageIds = LeapqSampleLanguage.mapper(sampleLanguages)
    LeapqSampleScore.save(self.id, scores, sampleLanguageIds)
  end

  private
  def prepare_language_ids
    languageIds = {
      :level => {},
      :time => {}
    }
    languages = self.leapq_sample_languages
    languages.each do |language|
      ["level", "time"].each do |type|
        seq = language["#{type}_seq".to_sym]
        if language["#{type}_seq".to_sym] < 2
          languageIds[type.to_sym]["lang#{seq + 1}".to_sym] = language[:id]
        end
      end
    end

    languageIds
  end

  def prepare_levels languageIds
    values = {}
    levels = self.leapq_sample_levels
    levels.each do |level|
      if level[:sample_language_id] == languageIds[:level][:lang1]
        values[:lang1_reading_use] = level[:read]
        values[:lang1_speaking_use] = level[:speak]
        values[:lang1_listening_use] = level[:speak]
        values[:lang1_writing_use] = level[:write]
      elsif level[:sample_language_id] == languageIds[:level][:lang2]
        values[:lang2_reading_use] = level[:read]
        values[:lang2_speaking_use] = level[:speak]
        values[:lang2_listening_use] = level[:speak]
        values[:lang2_writing_use] = level[:write]
      end
    end

    values
  end
end
