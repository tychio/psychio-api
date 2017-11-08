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
end
