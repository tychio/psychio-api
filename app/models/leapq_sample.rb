class LeapqSample < ApplicationRecord
  enum status: [:questionary, :totest, :tested]

  def self.signup info
    self.create({
      :phone => info[:phone],
      :wechat => info[:wechat],
      :qq => info[:qq],
      :status => :questionary
    })
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
    LeapqSampleLevel.save(self.id, rates, sampleLanguages)
  end

  def save_barriers (barriers)
    LeapqSampleBarrier.save(self.id, barriers)
  end
end
