class AddViewForIqScore < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      CREATE VIEW `leapq_sample_iq_score`
      AS SELECT 
        et.key AS `Participant_ID`,
        MIN(lsg.group) AS `Group`,
        MIN(lsi.code) AS `Code`,
        COUNT( IF(et.question = et.answer, 1, NULL) ) AS `IQ Score`
      FROM experiment_trials AS et
      JOIN leapq_samples AS ls ON ls.phone = et.key
      JOIN leapq_sample_groups AS lsg ON lsg.sample_id = ls.id
      JOIN leapq_sample_infos AS lsi ON lsi.sample_id = ls.id
      WHERE et.kind = 5
      GROUP BY et.key
      ORDER BY MIN(lsg.group), MIN(lsi.code);
    SQL
  end

  def down
    execute <<-SQL
      DROP VIEW `leapq_sample_iq_score`
    SQL
  end
end
