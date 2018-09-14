class TestData < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      UPDATE experiment_trials AS et
      JOIN leapq_samples AS s ON s.phone = et.key
      JOIN leapq_sample_groups AS g ON g.sample_id = s.id
      SET et.speed = et.speed +
        IF(JSON_EXTRACT(et.question, '$.switch'),
          IF( 
            ((JSON_EXTRACT(et.question, '$.lang') = 'chinese') AND g.group = 0)
            OR ((JSON_EXTRACT(et.question, '$.lang') = 'uyghur') AND g.group = 1)
            , 0, IF(g.group = 2, 100, 200)
          ),
          IF( 
            ((JSON_EXTRACT(et.question, '$.lang') = 'chinese') AND g.group = 0)
            OR ((JSON_EXTRACT(et.question, '$.lang') = 'uyghur') AND g.group = 1)
            , -200, IF(g.group = 2, -100, 0)
          )
        )
      WHERE et.kind = 0;
    SQL
  end

  def down
    execute <<-SQL
      UPDATE experiment_trials AS et
      JOIN leapq_samples AS s ON s.phone = et.key
      JOIN leapq_sample_groups AS g ON g.sample_id = s.id
      SET et.speed = et.speed +
        IF(JSON_EXTRACT(et.question, '$.switch'),
          IF( 
            ((JSON_EXTRACT(et.question, '$.lang') = 'chinese') AND g.group = 0)
            OR ((JSON_EXTRACT(et.question, '$.lang') = 'uyghur') AND g.group = 1)
            , 0, IF(g.group = 2, -100, -200)
          ),
          IF( 
            ((JSON_EXTRACT(et.question, '$.lang') = 'chinese') AND g.group = 0)
            OR ((JSON_EXTRACT(et.question, '$.lang') = 'uyghur') AND g.group = 1)
            , 200, IF(g.group = 2, 100, 0)
          )
        )
      WHERE et.kind = 0;
    SQL
  end
end
