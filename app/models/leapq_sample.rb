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

  def sort_languages (data)
    levelLangs = data[:levelLanguages]
    timeLangs = data[:timeLanguages]
    LeapqSampleLanguage.save(self.id, levelLangs, timeLangs)
  end
end
