class AnalysisGroup < ApplicationRecord
  def self.collect
    samples = LeapqSample.where(:is_active => 1)
    samples.each do |sample|
      sample_detail = sample.get
      info = sample_detail[:info]
      levels = sample_detail[:levels]
      ages = sample_detail[:ages]
      scores = sample_detail[:scores]

      record = self.find_or_create_by({
        :phone => sample[:phone],
        :qq => sample[:qq],
        :wechat => sample[:wechat]
      })

      reading_use = self.percent(levels[:lang1_reading_use], levels[:lang2_reading_use])
      speaking_use = self.percent(levels[:lang1_speaking_use], levels[:lang2_speaking_use])
      listening_use = self.percent(levels[:lang1_listening_use], levels[:lang2_listening_use])
      writing_use = self.percent(levels[:lang1_writing_use], levels[:lang2_writing_use])

      record.update({
        :name => info[:code],
        :lang1_reading_use => reading_use[0],
        :lang2_reading_use => reading_use[1],
        :lang1_speaking_use => speaking_use[0],
        :lang2_speaking_use => speaking_use[1],
        :lang1_listening_use => listening_use[0],
        :lang2_listening_use => listening_use[1],
        :lang1_writing_use => writing_use[0],
        :lang2_writing_use => writing_use[1],
        :lang1_start_age => ages[:lang1_start_age],
        :lang2_start_age => ages[:lang2_start_age],
        :lang1_learn_age => ages[:lang1_learn_age],
        :lang2_learn_age => ages[:lang2_learn_age],
        :lang1_l_instruction_age => ages[:lang1_l_instruction_age],
        :lang2_l_instruction_age => ages[:lang2_l_instruction_age],
        :lang1_c_instruction_age => ages[:lang1_c_instruction_age],
        :lang2_c_instruction_age => ages[:lang2_c_instruction_age],
        :lang1_reading_self => scores[:lang1_reading_self] - 1,
        :lang2_reading_self => scores[:lang2_reading_self] - 1,
        :lang1_speaking_self => scores[:lang1_speaking_self] - 1,
        :lang2_speaking_self => scores[:lang2_speaking_self] - 1,
        :lang1_listening_self => scores[:lang1_listening_self] - 1,
        :lang2_listening_self => scores[:lang2_listening_self] - 1
      })
    end
  end

  def self.standard
    records = AnalysisGroup.all.to_a
    sums = self.sum records
    means = self.mean(sums, records.size)
    variances = self.variance(records, means)
    deviations = self.deviation(variances, records.size)
    scores = self.score(records, deviations, means)
    skewing = self.skewing scores
    self.result(scores, skewing)
  end

  private
  def self.result(scores, skewing)
    scores.each do |score| 
      score[:score].each do |key, value| 
        if value.is_a? Numeric
          score[:score][key] = value + skewing
        end
      end
      sumSelfScore = 0
      sumUseScore = 0
      [
        :reading_use,
        :speaking_use,
        :listening_use,
        :writing_use
      ].each do |key|
        score[key] = self.rate(score[:score], key)
        sumUseScore += score[key]
      end
      [
        :reading_self,
        :speaking_self,
        :listening_self
      ].each do |key|
        score[key] = self.rate(score[:score], key)
        sumSelfScore += score[key]
      end
      score[:self_score] = (sumSelfScore / 3).to_f
      score[:use_score] = (sumUseScore / 4).to_f
      score[:score] = ((score[:self_score] + score[:use_score]) / 2).to_f
      score[:balance] = (score[:score] - 1).abs
    end
    scores
  end

  def self.skewing scores
    min = 99999
    max = 0
    scores.each do |score|
      score[:score].each do |key, value|
        min = [min, value].min
        max = [max, value].max
      end
    end
    range = max - min
    range * 0.1 - min
  end

  def self.score(records, deviations, means)
    records.map do |record|
      score = {}
      self.each([record]) do |item, key|
        if item[key]
          score[key] = ((item[key] - means[key]) / deviations[key]).to_f
        end
      end
      {
        :name => record[:name],
        :phone => record[:phone],
        :qq => record[:qq],
        :wechat => record[:wechat],
        :lang1_start_age => record[:lang1_start_age],
        :lang2_start_age => record[:lang2_start_age],
        :lang1_learn_age => record[:lang1_learn_age],
        :lang2_learn_age => record[:lang2_learn_age],
        :lang1_l_instruction_age => record[:lang1_l_instruction_age],
        :lang2_l_instruction_age => record[:lang2_l_instruction_age],
        :lang1_c_instruction_age => record[:lang1_c_instruction_age],
        :lang2_c_instruction_age => record[:lang2_c_instruction_age],
        :score => score
      }
    end
  end

  def self.deviation(variances, size)
    deviations = {}
    self.each([variances]) do |item, key|
      deviations[key] = Math.sqrt((item[key] / (size - 1)).to_f)
    end
    deviations
  end

  def self.variance(records, mean)
    variances = {}
    self.each(records) do |record, key|
      variances[key] = variances[key] || 0
      if record[key]
        variances[key] += (record[key] - mean[key]) ** 2
      end
    end
    variances
  end

  def self.mean(sums, size)
    means = {}
    self.each([sums]) do |item, key|
      means[key] = (item[key] / size).to_f
    end
    means
  end

  def self.sum records
    sums = {}
    self.each(records) do |record, key|
      sums[key] = sums[key] || 0
      if record[key]
        sums[key] += record[key]
      end
    end
    sums
  end

  def self.each records
    records.each do |record|
      [
        :lang1_reading_use,       :lang2_reading_use,
        :lang1_speaking_use,      :lang2_speaking_use,
        :lang1_listening_use,     :lang2_listening_use,
        :lang1_writing_use,       :lang2_writing_use,
        :lang1_reading_self,      :lang2_reading_self,
        :lang1_speaking_self,     :lang2_speaking_self,
        :lang1_listening_self,    :lang2_listening_self
      ].each do |key|
        yield(record, key)
      end
    end
  end

  def self.rate(score, key)
    (score["lang1_#{key.to_s}".to_sym] / score["lang2_#{key.to_s}".to_sym]).to_f
  end

  def self.percent(percentA, percentB)
    sum = (percentA + percentB).to_f
    newPercentA = ((percentA.to_f / sum) * 100).round
    newPercentB = 100 - newPercentA
    [newPercentA, newPercentB]
  end
end
