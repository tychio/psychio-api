class AddViewForProficiency < ActiveRecord::Migration[5.0]
   def up
    execute <<-SQL
      CREATE VIEW `leapq_results_percskill` AS
      SELECT
        `lpercent`.`id` AS `id`,
        `lpercent`.`sample_id` AS `sample_id`,
        `lpercent`.`sample_language_id` AS `sample_language_id`,
        `lpercent`.`read` AS `read`,
        `lpercent`.`speak` AS `speak`,
        `lpercent`.`write` AS `write`,
        (`lskill`.`level_speak` - 1) AS `speakskill`,
        (`lskill`.`level_listen` - 1) AS `listenskill`,
        (`lskill`.`level_read` - 1) AS `readskill`,
        `langlabel`.`language_id` AS `language_id`
      FROM (((`leapq_sample_levels` `lpercent`
        LEFT JOIN `leapq_sample_scores` `lskill` ON((`lpercent`.`sample_language_id` = `lskill`.`sample_language_id`)))
        LEFT JOIN `leapq_sample_languages` `langlabel` ON((`lskill`.`sample_language_id` = `langlabel`.`id`)))
        JOIN `leapq_sample_groups` `realparticipant` ON((`lpercent`.`sample_id` = `realparticipant`.`sample_id`)))
      WHERE (`langlabel`.`language_id` IN (1, 2, 3));
    SQL
    
    execute <<-SQL
      CREATE VIEW `leapq_results_generalpercskill` AS
      SELECT `leapq_results_percskill`.`id` AS `id`,
        `leapq_results_percskill`.`sample_id` AS `sample_id`,
        `leapq_results_percskill`.`sample_language_id` AS `sample_language_id`,
        `leapq_results_percskill`.`language_id` AS `language_id`,
        `leapq_results_percskill`.`speakskill` AS `speakskill`,
        `leapq_results_percskill`.`listenskill` AS `listenskill`,
        `leapq_results_percskill`.`readskill` AS `readskill`,
        `sumskills`.`3Lspeak` AS `3Lspeak`,
        `sumskills`.`3Llisten` AS `3Llisten`,
        `sumskills`.`3Lread` AS `3Lread`,
        round(((`leapq_results_percskill`.`read` / 100) * `sumskills`.`3Lread`),0) AS `book`,
        round((((`leapq_results_percskill`.`speak` / 100) * (`sumskills`.`3Lspeak` + `sumskills`.`3Llisten`)) / 2),0) AS `conversation`,
        round((((`leapq_results_percskill`.`write` / 100) * ((`sumskills`.`3Lspeak` + `sumskills`.`3Llisten`) + `sumskills`.`3Lread`)) / 3),0) AS `letter`
      FROM (
        `psychio`.`leapq_results_percskill`
          LEFT JOIN (
            SELECT `leapq_results_percskill`.`sample_id` AS `sample_id`,
              SUM(`leapq_results_percskill`.`speakskill`) AS `3Lspeak`,
              SUM(`leapq_results_percskill`.`listenskill`) AS `3Llisten`,
              SUM(`leapq_results_percskill`.`readskill`) AS `3Lread`
            FROM `psychio`.`leapq_results_percskill`
            GROUP BY `leapq_results_percskill`.`sample_id`
        ) AS `sumskills` ON `leapq_results_percskill`.`sample_id` = `sumskills`.`sample_id`
      );
    SQL
    
    execute <<-SQL
      CREATE VIEW `leapq_results_finalpercskill` AS
      SELECT
        `intepercskill`.`id` AS `id`,
        `intepercskill`.`sample_id` AS `sample_id`,
        `leapq_results_score`.`phone` AS `phone`,
        `leapq_results_score`.`code` AS `code`,
        `intepercskill`.`language_id` AS `language_id`,
        if((`intepercskill`.`language_id` = 1),'Chinese','Uyghur') AS `language_type`,
        `intepercskill`.`label` AS `label`,
        `intepercskill`.`score` AS `score`
      FROM ((
        (SELECT `leapq_results_generalpercskill`.`id` AS `id`,
          `leapq_results_generalpercskill`.`sample_id` AS `sample_id`,
          `leapq_results_generalpercskill`.`language_id` AS `language_id`,
          'speakskill' AS `label`,
          `leapq_results_generalpercskill`.`speakskill` AS `score`
        FROM `psychio`.`leapq_results_generalpercskill`)
        UNION ALL
        SELECT `leapq_results_generalpercskill`.`id` AS `id`,
          `leapq_results_generalpercskill`.`sample_id` AS `sample_id`,
          `leapq_results_generalpercskill`.`language_id` AS `language_id`,
          'listenskill' AS `label`,
          `leapq_results_generalpercskill`.`listenskill` AS `score`
        FROM `psychio`.`leapq_results_generalpercskill`
        UNION ALL
        SELECT `leapq_results_generalpercskill`.`id` AS `id`,
          `leapq_results_generalpercskill`.`sample_id` AS `sample_id`,
          `leapq_results_generalpercskill`.`language_id` AS `language_id`,
          'readskill' AS `label`,
          `leapq_results_generalpercskill`.`readskill` AS `score`
        FROM `psychio`.`leapq_results_generalpercskill`
        UNION ALL
        SELECT `leapq_results_generalpercskill`.`id` AS `id`,
          `leapq_results_generalpercskill`.`sample_id` AS `sample_id`,
          `leapq_results_generalpercskill`.`language_id` AS `language_id`,
          'book' AS `label`,
          `leapq_results_generalpercskill`.`book` AS `score`
        FROM `psychio`.`leapq_results_generalpercskill`
        UNION ALL
        SELECT `leapq_results_generalpercskill`.`id` AS `id`,
          `leapq_results_generalpercskill`.`sample_id` AS `sample_id`,
          `leapq_results_generalpercskill`.`language_id` AS `language_id`,
          'conversation' AS `label`,
          `leapq_results_generalpercskill`.`conversation` AS `score`
        FROM `psychio`.`leapq_results_generalpercskill`
        UNION ALL
        SELECT `leapq_results_generalpercskill`.`id` AS `id`,
          `leapq_results_generalpercskill`.`sample_id` AS `sample_id`,
          `leapq_results_generalpercskill`.`language_id` AS `language_id`,
          'letter' AS `label`,
          `leapq_results_generalpercskill`.`letter` AS `score`
        FROM `psychio`.`leapq_results_generalpercskill`) `intepercskill`
        LEFT JOIN `psychio`.`leapq_results_score` on((`leapq_results_score`.`sample_id` = `intepercskill`.`sample_id`)))
      WHERE (`intepercskill`.`language_id` IN (1, 2))
      ORDER BY `intepercskill`.`sample_id`, `intepercskill`.`language_id`;
    SQL
  end

  def down
    execute <<-SQL
      DROP VIEW `leapq_results_percskill`;
    SQL
    execute <<-SQL
      DROP VIEW `leapq_results_generalpercskill`;
    SQL
    execute <<-SQL
      DROP VIEW `leapq_results_finalpercskill`;
    SQL
  end
end
