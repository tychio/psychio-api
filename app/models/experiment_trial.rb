class ExperimentTrial < ApplicationRecord
  enum status: [:pic, :lex_cn, :lex_ug, :flanker, :simon, :iq]

  def self.import
    results = ExperimentResult.all
    mergedResults = self.merge results
    puts mergedResults
  end

  private
  def self.merge results
    mergedResults = Hash.new
    results.each_with_index do |result, index|
      resultName = result[:name]
      mergedResults[resultName] = mergedResults[resultName] || Hash.new
      [:pic, :lex_cn, :lex_ug, :flanker, :simon, :iq].each do |key|
        value = result[key].nil? ? nil : JSON.parse(result[key])
        mergedResults[resultName][key] = (value.nil? || value.empty?) ? nil : value
      end
    end
    return mergedResults
  end
end
