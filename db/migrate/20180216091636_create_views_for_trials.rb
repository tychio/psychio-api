class CreateViewsForTrials < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      CREATE VIEW `experiment_output_pic`
      AS SELECT
        `et`.`key` AS `Participant_ID`,
        IF(`lsg`.`group` = 0, 'L1', IF(`lsg`.`group` = 1, 'L2', 'Balance')) AS `group`,
        `et`.`seq` AS `No.`,
        CONCAT(
          IF(JSON_EXTRACT(`et`.`question`,'$.begin'),
            'First',
            IF(JSON_EXTRACT(`et`.`question`,'$.switch'),
              'Switch',
              'Nonswitch'
            )
          ),
          IF((JSON_EXTRACT(`et`.`question`,'$.lang') = 'chinese'),
            'C',
            'U'
          ),
          '_',
          `et`.`name`
        ) AS `Stimulates`,
        `et`.`answer` AS `Response`,
        `et`.`answer` AS `Accuracy`,
        `et`.`speed` AS `Speed`,
        IF(`et`.`answer`,
          `et`.`speed`,
          NULL
        ) AS `CorrectResponseSpeed`
      FROM `experiment_trials` `et`
      LEFT JOIN `leapq_samples` AS `ls` ON `ls`.`phone` = `et`.`key`
      LEFT JOIN `leapq_sample_groups` AS `lsg` ON `lsg`.`sample_id` = `ls`.`id`
      WHERE (`et`.`kind` = 0);
    SQL

    execute <<-SQL
      CREATE VIEW `experiment_output_lexcn`
      AS SELECT
        `et`.`key` AS `Participant_ID`,
        IF(`lsg`.`group` = 0, 'L1', IF(`lsg`.`group` = 1, 'L2', 'Balance')) AS `group`,
        `et`.`seq` AS `No.`,
        CONCAT(
          IF(JSON_EXTRACT(`et`.`question`,'$.real'),
            'Word',
            'Non'
          ),
          CASE JSON_EXTRACT(`et`.`question`,'$.lang')
            WHEN '"chinese"' THEN 'Cn'
            WHEN '"uyghur"' THEN 'Ug'
          END
        ) AS `Stimulates`,
        IF(`et`.`answer`,'Word', 'Non') AS `Response`,
        IF((`et`.`answer` = IF(JSON_EXTRACT(`et`.`question`,'$.real'),1,0)),1,0) AS `Accuracy`,
        `et`.`speed` AS `Speed`,
        IF(`et`.`answer` = IF(JSON_EXTRACT(`et`.`question`,'$.real'),1,0),
          `et`.`speed`,
          NULL
        ) AS `CorrectResponseSpeed`
      FROM `experiment_trials` `et` 
      LEFT JOIN `leapq_samples` AS `ls` ON `ls`.`phone` = `et`.`key`
      LEFT JOIN `leapq_sample_groups` AS `lsg` ON `lsg`.`sample_id` = `ls`.`id`
      WHERE (`et`.`kind` = 1);
    SQL

    execute <<-SQL
      CREATE VIEW `experiment_output_lexug`
      AS SELECT
        `et`.`key` AS `Participant_ID`,
        IF(`lsg`.`group` = 0, 'L1', IF(`lsg`.`group` = 1, 'L2', 'Balance')) AS `group`,
        `et`.`seq` AS `No.`,
        CONCAT(
          IF(JSON_EXTRACT(`et`.`question`,'$.real'),
            'Word',
            'Non'
          ),
          CASE JSON_EXTRACT(`et`.`question`,'$.lang')
            WHEN '"chinese"' THEN 'Cn'
            WHEN '"uyghur"' THEN 'Ug'
          END
        ) AS `Stimulates`,
        `et`.`answer` AS `Response`,
        IF((`et`.`answer` = IF(JSON_EXTRACT(`et`.`question`,'$.real'),1,0)),1,0) AS `Accuracy`,
        `et`.`speed` AS `Speed`,
        IF(`et`.`answer` = IF(JSON_EXTRACT(`et`.`question`,'$.real'),1,0),
          `et`.`speed`,
          NULL
        ) AS `CorrectResponseSpeed`
      FROM `experiment_trials` `et`
      LEFT JOIN `leapq_samples` AS `ls` ON `ls`.`phone` = `et`.`key`
      LEFT JOIN `leapq_sample_groups` AS `lsg` ON `lsg`.`sample_id` = `ls`.`id`
      WHERE (`et`.`kind` = 2);
    SQL

    execute <<-SQL
      CREATE VIEW `experiment_output_flanker`
      AS SELECT
        `et`.`key` AS `Participant_ID`,
        IF(`lsg`.`group` = 0, 'L1', IF(`lsg`.`group` = 1, 'L2', 'Balance')) AS `group`,
        `et`.`seq` AS `No.`,
        CONCAT(
          CASE JSON_EXTRACT(`et`.`question`,'$.congruent')
            WHEN '"con"' THEN 'Con'
            WHEN '"incon"' THEN 'Incon'
            WHEN '"neu"' THEN 'Neutral'
          END,
          CASE JSON_EXTRACT(`et`.`question`,'$.direction')
            WHEN '"right"' THEN 'Right'
            WHEN '"left"' THEN 'Left'
          END
        ) AS `Stimulates`,
        (
          CASE JSON_EXTRACT(`et`.`question`,'$.congruent')
            WHEN '"con"' THEN 'Con'
            WHEN '"incon"' THEN 'Incon'
            WHEN '"neu"' THEN 'Neutral'
          END
        ) AS `StimulatesType`,
        IF(`et`.`answer`,'Right','Left') AS `Response`,
        IF((`et`.`answer` = IF(JSON_EXTRACT(`et`.`question`,'$.direction') = 'right',1,0)),1,0) AS `Accuracy`,
        `et`.`speed` AS `Speed`,
        IF(`et`.`answer` = IF(JSON_EXTRACT(`et`.`question`,'$.direction') = 'right',1,0),
          `et`.`speed`,
          NULL
        ) AS `CorrectResponseSpeed`
      FROM `experiment_trials` `et`
      LEFT JOIN `leapq_samples` AS `ls` ON `ls`.`phone` = `et`.`key`
      LEFT JOIN `leapq_sample_groups` AS `lsg` ON `lsg`.`sample_id` = `ls`.`id`
      WHERE (`et`.`kind` = 3);
    SQL

    execute <<-SQL
      CREATE VIEW `experiment_output_simon`
      AS SELECT
        `et`.`key` AS `Participant_ID`,
        IF(`lsg`.`group` = 0, 'L1', IF(`lsg`.`group` = 1, 'L2', 'Balance')) AS `group`,
        `et`.`seq` AS `No.`,
        CONCAT(
          CASE JSON_EXTRACT(`et`.`question`,'$.direction') 
            WHEN '"left"' THEN IF(JSON_EXTRACT(`et`.`question`,'$.color') = 'red','Con','Incon') 
            WHEN '"right"' THEN IF(JSON_EXTRACT(`et`.`question`,'$.color') = 'blue','Incon','Con') 
            WHEN '"center"' THEN 'Neutral' 
          END,
          CASE JSON_EXTRACT(`et`.`question`,'$.color')
            WHEN '"red"' THEN 'Red'
            WHEN '"blue"' THEN 'Blue'
          END
        ) AS `Stimulates`,
        (
          CASE JSON_EXTRACT(`et`.`question`,'$.direction') 
            WHEN '"left"' THEN IF(JSON_EXTRACT(`et`.`question`,'$.color') = 'red','Con','Incon') 
            WHEN '"right"' THEN IF(JSON_EXTRACT(`et`.`question`,'$.color') = 'blue','Incon','Con') 
            WHEN '"center"' THEN 'Neutral' 
          END
        ) AS `StimulatesType`,
        IF(`et`.`answer`,'Red','Blue') AS `Response`,
        IF((`et`.`answer` = IF(JSON_EXTRACT(`et`.`question`,'$.color') = 'red',1,0)),1,0) AS `Accuracy`,
        `et`.`speed` AS `Speed`,
        IF(`et`.`answer` = IF(JSON_EXTRACT(`et`.`question`,'$.color') = 'red',1,0),
          `et`.`speed`,
          NULL
        ) AS `CorrectResponseSpeed`
      FROM `experiment_trials` `et`
      LEFT JOIN `leapq_samples` AS `ls` ON `ls`.`phone` = `et`.`key`
      LEFT JOIN `leapq_sample_groups` AS `lsg` ON `lsg`.`sample_id` = `ls`.`id`
      WHERE (`et`.`kind` = 4);
    SQL

    execute <<-SQL
      CREATE VIEW `experiment_output_iq`
      AS SELECT
        `et`.`key` AS `Participant_ID`,
        IF(`lsg`.`group` = 0, 'L1', IF(`lsg`.`group` = 1, 'L2', 'Balance')) AS `group`,
        `et`.`seq` AS `No.`,
        `et`.`question` AS `Stimulates`,
        `et`.`answer` AS `Response`,
        IF((`et`.`answer` = `et`.`question`),1,0) AS `Accuracy`,
        `et`.`speed` AS `Speed`,
        IF(`et`.`answer` = `et`.`question`,
          `et`.`speed`,
          NULL
        ) AS `CorrectResponseSpeed`
      FROM `experiment_trials` `et`
      LEFT JOIN `leapq_samples` AS `ls` ON `ls`.`phone` = `et`.`key`
      LEFT JOIN `leapq_sample_groups` AS `lsg` ON `lsg`.`sample_id` = `ls`.`id`
      WHERE (`et`.`kind` = 5);
    SQL
  end

  def down
    execute <<-SQL
      DROP VIEW `experiment_output_pic`
    SQL
    execute <<-SQL
      DROP VIEW `experiment_output_lexcn`
    SQL
    execute <<-SQL
      DROP VIEW `experiment_output_lexug`
    SQL
    execute <<-SQL
      DROP VIEW `experiment_output_flanker`
    SQL
    execute <<-SQL
      DROP VIEW `experiment_output_simon`
    SQL
    execute <<-SQL
      DROP VIEW `experiment_output_iq`
    SQL
  end
end
