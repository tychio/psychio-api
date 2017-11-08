class LeapqSampleBarrier < ApplicationRecord
  def self.save(sampleId, barriers)
    results = barriers[:results]
    self.create({
      :sample_id => sampleId,
      :vision => results[:vision],
      :hearing => results[:hearing],
      :language => results[:language],
      :study => results[:study],
      :explanation => barriers[:explanation]
    })
  end
end
