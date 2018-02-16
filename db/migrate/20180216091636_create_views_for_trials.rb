class CreateViewsForTrials < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      CREATE VIEW `experiment_output_pic`
      AS SELECT
        `et`.`key` AS `Participant_ID`,
        `et`.`seq` AS `No.`,
        CONCAT(
          IF(JSON_EXTRACT(`et`.`question`,'$.begin'),
            'First',
            IF(JSON_EXTRACT(`et`.`question`,'$.change'),
              'Switch',
              'Nonswitch'
            )
          ),
          IF((JSON_EXTRACT(`et`.`question`,'$.lang') = 'chinese'),
            'C',
            'U'
          )
        ) AS `Stimulates`,
        `et`.`answer` AS `Response`,
        `et`.`answer` AS `Accuracy`,
        `et`.`speed` AS `Speed`,
        IF(`et`.`answer`,
          `et`.`speed`,
          NULL
        ) AS `CorrectResponseSpeed`
      FROM `experiment_trials` `et` WHERE (`et`.`kind` = 0);
    SQL

    execute <<-SQL
      CREATE VIEW `experiment_output_lexcn`
      AS SELECT
        `et`.`key` AS `Participant_ID`,
        `et`.`seq` AS `No.`,
        CONCAT(
          IF(JSON_EXTRACT(`et`.`question`,'$.lang') = 'chinese',
            'C',
            'U'
          ),
          IF(JSON_EXTRACT(`et`.`question`,'$.real'),
            'word',
            'non'
          )
        ) AS `Stimulates`,
        `et`.`answer` AS `Response`,
        IF((`et`.`answer` = IF(JSON_EXTRACT(`et`.`question`,'$.real'),1,0)),1,0) AS `Accuracy`,
        `et`.`speed` AS `Speed`,
        IF(`et`.`answer` = IF(JSON_EXTRACT(`et`.`question`,'$.real'),1,0),
          `et`.`speed`,
          NULL
        ) AS `CorrectResponseSpeed`
      FROM `experiment_trials` `et` WHERE (`et`.`kind` = 1);
    SQL

    execute <<-SQL
      CREATE VIEW `experiment_output_lexug`
      AS SELECT
        `et`.`key` AS `Participant_ID`,
        `et`.`seq` AS `No.`,
        CONCAT(
          IF(JSON_EXTRACT(`et`.`question`,'$.lang') = 'chinese',
            'C',
            'U'
          ),
          IF(JSON_EXTRACT(`et`.`question`,'$.real'),
            'word',
            'non'
          )
        ) AS `Stimulates`,
        `et`.`answer` AS `Response`,
        IF((`et`.`answer` = IF(JSON_EXTRACT(`et`.`question`,'$.real'),1,0)),1,0) AS `Accuracy`,
        `et`.`speed` AS `Speed`,
        IF(`et`.`answer` = IF(JSON_EXTRACT(`et`.`question`,'$.real'),1,0),
          `et`.`speed`,
          NULL
        ) AS `CorrectResponseSpeed`
      FROM `experiment_trials` `et` WHERE (`et`.`kind` = 2);
    SQL

    execute <<-SQL
      CREATE VIEW `experiment_output_flanker`
      AS SELECT
        `et`.`key` AS `Participant_ID`,
        `et`.`seq` AS `No.`,
        CONCAT(
          IF(JSON_EXTRACT(`et`.`question`,'$.congruent'),
            'Con',
            'Incon'
          ),
          IF(JSON_EXTRACT(`et`.`question`,'$.direction'),
            'Right',
            'Left'
          )
        ) AS `Stimulates`,
        IF(`et`.`answer`,'Right','Left') AS `Response`,
        IF((`et`.`answer` = IF(JSON_EXTRACT(`et`.`question`,'$.direction'),1,0)),1,0) AS `Accuracy`,
        `et`.`speed` AS `Speed`,
        IF(`et`.`answer` = IF(JSON_EXTRACT(`et`.`question`,'$.direction'),1,0),
          `et`.`speed`,
          NULL
        ) AS `CorrectResponseSpeed`
      FROM `experiment_trials` `et` WHERE (`et`.`kind` = 3);
    SQL

    execute <<-SQL
      CREATE VIEW `experiment_output_simon`
      AS SELECT
        `et`.`key` AS `Participant_ID`,
        `et`.`seq` AS `No.`,
        CONCAT(
          (CASE JSON_EXTRACT(`et`.`question`,'$.direction') 
            WHEN '"left"' THEN IF(JSON_EXTRACT(`et`.`question`,'$.red'),'Con','Incon') 
            WHEN '"right"' THEN IF(JSON_EXTRACT(`et`.`question`,'$.red'),'Incon','Con') 
            WHEN '"center"' THEN 'Neutral' 
          END),
          IF(JSON_EXTRACT(`et`.`question`,'$.red'),'Red','Blue')
        ) AS `Stimulates`,
        IF(`et`.`answer`,'red','blue') AS `Response`,
        IF((`et`.`answer` = IF(JSON_EXTRACT(`et`.`question`,'$.red'),1,0)),1,0) AS `Accuracy`,
        `et`.`speed` AS `Speed`,
        IF(`et`.`answer` = IF(JSON_EXTRACT(`et`.`question`,'$.red'),1,0),
          `et`.`speed`,
          NULL
        ) AS `CorrectResponseSpeed`
      FROM `experiment_trials` `et` WHERE (`et`.`kind` = 4);
    SQL

    execute <<-SQL
      CREATE VIEW `experiment_output_iq`
      AS SELECT
        `et`.`key` AS `Participant_ID`,
        `et`.`seq` AS `No.`,
        `et`.`question` AS `Stimulates`,
        `et`.`answer` AS `Response`,
        IF((`et`.`answer` = `et`.`question`),1,0) AS `Accuracy`,
        `et`.`speed` AS `Speed`,
        IF(`et`.`answer` = `et`.`question`,
          `et`.`speed`,
          NULL
        ) AS `CorrectResponseSpeed`
      FROM `experiment_trials` `et` WHERE (`et`.`kind` = 5);
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
