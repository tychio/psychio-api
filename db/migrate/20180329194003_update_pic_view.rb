class UpdatePicView < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      DROP VIEW `experiment_output_pic`
    SQL

    execute <<-SQL
      CREATE VIEW `experiment_output_pic`
      AS SELECT
        `et`.`key` AS `Participant_ID`,
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
          '_', `et`.`name`,
          '_', `pi`.`chinese`
        ) AS `Stimulates`,
        `et`.`answer` AS `Response`,
        `et`.`answer` AS `Accuracy`,
        `et`.`speed` AS `Speed`,
        IF(`et`.`answer`,
          `et`.`speed`,
          NULL
        ) AS `CorrectResponseSpeed`
      FROM `experiment_trials` `et` 
      LEFT JOIN `pnt_images` `pi` ON `pi`.`name` = `et`.`name`
      WHERE (`et`.`kind` = 0);
    SQL
  end

  def down
    execute <<-SQL
      DROP VIEW `experiment_output_pic`
    SQL

    execute <<-SQL
      CREATE VIEW `experiment_output_pic`
      AS SELECT
        `et`.`key` AS `Participant_ID`,
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
      FROM `experiment_trials` `et` WHERE (`et`.`kind` = 0);
    SQL
  end
end
