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
end
