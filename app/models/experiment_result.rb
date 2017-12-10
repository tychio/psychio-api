class ExperimentResult < ApplicationRecord
  def self.save (name, result)
    self.create({
      :name => name,
      :pic => result[:'picture-naming'],
      :lex_cn => result[:'lexical-decision-chinese'],
      :lex_ug => result[:'lexical-decision-uyghur'],
      :flanker => result[:flanker],
      :simon => result[:simon],
      :iq => result[:'iq-tester']
    })
  end
end
