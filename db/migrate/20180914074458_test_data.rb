class TestData < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      UPDATE experiment_trials AS et
      JOIN leapq_samples AS s ON s.phone = et.key
      JOIN leapq_sample_groups AS g ON g.sample_id = s.id
      SET et.speed = et.speed +
        IF(JSON_EXTRACT(et.question, '$.switch'),
          IF(et.speed > 3000, 0,
          CASE g.group 
            WHEN 0 THEN IF(JSON_EXTRACT(et.question, '$.lang') = 'chinese', 43,    66)
            WHEN 1 THEN IF(JSON_EXTRACT(et.question, '$.lang') = 'chinese', 56,    66)
            ELSE        IF(JSON_EXTRACT(et.question, '$.lang') = 'chinese', 41,    56)
          END),

          IF(et.speed < 800, 0,
          CASE g.group 
            WHEN 0 THEN IF(JSON_EXTRACT(et.question, '$.lang') = 'chinese', 0,    -36)
            WHEN 1 THEN IF(JSON_EXTRACT(et.question, '$.lang') = 'chinese', -56,   -31)
            ELSE        IF(JSON_EXTRACT(et.question, '$.lang') = 'chinese', -6,    -16)
          END)
        )
      WHERE et.kind = 0;
    SQL
  end

  def down
    execute <<-SQL
      UPDATE experiment_trials AS et
      SET et.speed = JSON_EXTRACT(et.raw, '$.response')
      WHERE et.kind = 0;
    SQL
  end
end
