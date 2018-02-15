class ExperimentTrial < ApplicationRecord
  enum kind: [:pic, :lex_cn, :lex_ug, :flanker, :simon, :iq]

  def self.import
    results = ExperimentResult.all
    mergedResults = self.merge results
    trials = self.get_trial mergedResults

    self.delete_all
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
        :raw => trial,
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
    trials.each_with_index do |trial, index|
      record = {
        :raw => trial,
        :name => trial['name'],
        :seq => index + 1,
        :question => {
          :real => !trial['isNon'],
          :lang => trial['language']
        },
        :answer => trial['selection'],
        :speed => trial['response']
      }

      yield record
    end
  end
  def self.trial_by_lex_ug trials
    self.trial_by_lex_cn trials do |trial|
      yield trial
    end
  end
  def self.trial_by_flanker trials
    trials.each_with_index do |trial, index|
      record = {
        :raw => trial,
        :name => "#{trial['type']}_#{trial['direction']}",
        :seq => index + 1,
        :question => {
          :congruent => (trial['type'].eql? 'con'),
          :direction => (trial['direction'].eql? 'right')
        },
        :answer => (trial['selection'].eql? 'right'),
        :speed => trial['response']
      }

      yield record
    end
  end
  def self.trial_by_simon trials
    trials.each_with_index do |trial, index|
      record = {
        :raw => trial,
        :name => "#{trial['type']}_#{trial['direction']}",
        :seq => index + 1,
        :question => {
          :red => (trial['type'].eql? 'red'),
          :direction => trial['direction']
        },
        :answer => (trial['selection'].eql? 'red'),
        :speed => trial['response']
      }

      yield record
    end
  end
  def self.trial_by_iq trials
    trials.each_with_index do |trial, index|
      record = {
        :raw => trial,
        :name => trial['name'],
        :seq => index + 1,
        :question => trial['answer'],
        :answer => trial['choice'],
        :speed => trial['response']
      }

      yield record
    end
  end
end
