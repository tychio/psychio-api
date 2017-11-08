class LeapqLanguage < ApplicationRecord
  def self.get_id_by_name languageName
    record = self.find_by({ :name => languageName })
    record[:id]
  end
end
