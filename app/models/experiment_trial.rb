class ExperimentTrial < ApplicationRecord
  enum status: [:pic, :lex_cn, :lex_ug, :flanker, :simon, :iq]

  def self.import
    results = ExperimentResult.all
    mergedResults = self.merge results
    trials = self.get_trial mergedResults

    self.create(trials)
  end

  private
  def self.merge results
    mergedResults = Hash.new
    results.each_with_index do |result, index|
      resultName = result[:name]
      mergedResults[resultName] = mergedResults[resultName] || Hash.new
      [:pic, :lex_cn, :lex_ug, :flanker, :simon, :iq].each do |key|
        if mergedResults[resultName][key].nil?
          value = result[key].nil? ? nil : JSON.parse(result[key])
          mergedResults[resultName][key] = (value.nil? || value.empty?) ? nil : value
        end
      end
    end
    return mergedResults
  end

  def self.get_trial results
    trials = Array.new
    results.each_pair do |name, result|
      [:pic, :lex_cn, :lex_ug, :flanker, :simon, :iq].each do |kind|
        if result[kind].present?
          self.send "trial_by_#{kind}".to_sym, result[kind] do |trial|
            trial[:key] = name
            trial[:kind] = kind.to_s
            trial[:raw] = result[kind]
            trials.push trial
          end
        end
      end
    end

    return trials
  end

  def self.trial_by_pic trials
    trials.each_with_index do |trial, index|
      record = {
        :name => trial['name'],
        :seq => index + 1,
        :question => {
          :end => trial['isEnd'],
          :change => (trial['switch'].eql? 'Changed'),
          :lang => trial['language']
        },
        :speed => trial['response']
      }

      yield record
    end
  end

  def self.trial_by_lex_cn trials
  end
  def self.trial_by_lex_ug trials
  end
  def self.trial_by_flanker trials
  end
  def self.trial_by_simon trials
  end
  def self.trial_by_iq trials
  end
end
