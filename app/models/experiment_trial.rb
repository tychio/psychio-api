class ExperimentTrial < ApplicationRecord
	enum status: [:pic, :lex_cn, :lex_ug, :flanker, :simon, :iq]
end
