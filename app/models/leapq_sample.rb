class LeapqSample < ApplicationRecord
	enum status: [:questionary, :totest, :tested]
end
