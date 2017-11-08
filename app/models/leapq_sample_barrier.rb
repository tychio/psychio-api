class LeapqSampleBarrier < ApplicationRecord
  def self.save(sampleId, barriers)
    results = barriers[:results] || {}
    self.create({
      :sample_id => sampleId,
      :vision => results[:vision] || 0,
      :hearing => results[:hearing] || 0,
      :language => results[:language] || 0,
      :study => results[:study] || 0,
      :explanation => barriers[:explanation] || ''
    })
  end
end
