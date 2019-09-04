class ChangeViewsForGroupMode < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      DROP VIEW `leapq_results_percskill`;
    SQL
    execute <<-SQL
      DROP VIEW `leapq_results_info`
    SQL
    execute <<-SQL
      DROP VIEW `leapq_results_level`
    SQL
    execute <<-SQL
      DROP VIEW `leapq_results_age`
    SQL
    execute <<-SQL
      DROP VIEW `leapq_results_period`
    SQL
    execute <<-SQL
      DROP VIEW `leapq_results_score`
    SQL
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
        JOIN `leapq_sample_groups` `realparticipant` ON((`lpercent`.`sample_id` = `realparticipant`.`sample_id`) AND (`realparticipant`.`group_mode` = 1)))
      WHERE (`langlabel`.`language_id` IN (1, 2, 3));
    SQL

    execute <<-SQL
      CREATE VIEW `leapq_results_info`
      AS SELECT DISTINCT(info.sample_id),sample.phone,info.code,info.age,info.gender, lsg.group,
        lang1.language_id AS L1,lang2.language_id AS L2,lang3.language_id AS L3,
        level1.language_id AS Level1,level2.language_id AS Level2,level3.language_id AS Level3

        FROM leapq_sample_infos AS info
        JOIN leapq_samples AS sample ON sample.id = info.sample_id
        LEFT JOIN experiment_results AS result ON sample.phone = result.name
        LEFT JOIN leapq_sample_groups AS lsg ON lsg.sample_id = sample.id AND lsg.group_mode = 1
        JOIN leapq_sample_languages AS lang1 ON lang1.sample_id = info.sample_id AND lang1.time_seq = 0
        JOIN leapq_sample_languages AS lang2 ON lang2.sample_id = info.sample_id AND lang2.time_seq = 1
        JOIN leapq_sample_languages AS lang3 ON lang3.sample_id = info.sample_id AND lang3.time_seq = 2

        JOIN leapq_sample_languages AS level1 ON level1.sample_id = info.sample_id AND level1.level_seq = 0
        JOIN leapq_sample_languages AS level2 ON level2.sample_id = info.sample_id AND level2.level_seq = 1
        JOIN leapq_sample_languages AS level3 ON level3.sample_id = info.sample_id AND level3.level_seq = 2


        WHERE sample.is_active = 1 AND result.id IS NOT NULL
        ORDER BY lsg.group, info.code;
    SQL

    execute <<-SQL
      CREATE VIEW `leapq_results_level`
      AS SELECT DISTINCT(info.sample_id),sample.phone,info.code,info.age,info.gender, lsg.group,
        lang1.language_id AS L1,lang2.language_id AS L2,lang3.language_id AS L3,
        lv1.first AS L1Contact,lv1.read AS L1PRead,lv1.speak AS L1PSpeak,lv1.write AS L1PWrite,
        lv2.first AS L2Contact,lv2.read AS L2PRead,lv2.speak AS L2PSpeak,lv2.write AS L2PWrite,
        lv3.first AS L3Contact,lv3.read AS L3PRead,lv3.speak AS L3PSpeak,lv3.write AS L3PWrite

        FROM leapq_sample_infos AS info
        JOIN leapq_samples AS sample ON sample.id = info.sample_id
        LEFT JOIN experiment_results AS result ON sample.phone = result.name
        LEFT JOIN leapq_sample_groups AS lsg ON lsg.sample_id = sample.id AND lsg.group_mode = 1 
        JOIN leapq_sample_languages AS lang1 ON lang1.sample_id = info.sample_id AND lang1.time_seq = 0
        JOIN leapq_sample_languages AS lang2 ON lang2.sample_id = info.sample_id AND lang2.time_seq = 1
        JOIN leapq_sample_languages AS lang3 ON lang3.sample_id = info.sample_id AND lang3.time_seq = 2

        JOIN leapq_sample_levels AS lv1 ON lv1.sample_language_id = lang1.id
        JOIN leapq_sample_levels AS lv2 ON lv2.sample_language_id = lang2.id
        JOIN leapq_sample_levels AS lv3 ON lv3.sample_language_id = lang3.id


        WHERE sample.is_active = 1 AND result.id IS NOT NULL
        ORDER BY lsg.group, info.code;
    SQL

    execute <<-SQL
      CREATE VIEW `leapq_results_age`
      AS SELECT DISTINCT(info.sample_id),sample.phone,info.code,info.age,info.gender, lsg.group,
        lang1.language_id AS L1,lang2.language_id AS L2,lang3.language_id AS L3,
        age1.first AS L1exposed,age1.study AS L1school,age1.speak AS L1Lang,age1.normal AS L1Content,
        age2.first AS L2exposed,age2.study AS L2school,age2.speak AS L2Lang,age2.normal AS L2Content,
        age3.first AS L3exposed,age3.study AS L3school,age3.speak AS L3Lang,age3.normal AS L3Content

        FROM leapq_sample_infos AS info
        JOIN leapq_samples AS sample ON sample.id = info.sample_id
        LEFT JOIN experiment_results AS result ON sample.phone = result.name
        LEFT JOIN leapq_sample_groups AS lsg ON lsg.sample_id = sample.id AND lsg.group_mode = 1 
        JOIN leapq_sample_languages AS lang1 ON lang1.sample_id = info.sample_id AND lang1.time_seq = 0
        JOIN leapq_sample_languages AS lang2 ON lang2.sample_id = info.sample_id AND lang2.time_seq = 1
        JOIN leapq_sample_languages AS lang3 ON lang3.sample_id = info.sample_id AND lang3.time_seq = 2

        JOIN leapq_sample_ages AS age1 ON age1.sample_language_id = lang1.id
        JOIN leapq_sample_ages AS age2 ON age2.sample_language_id = lang2.id
        JOIN leapq_sample_ages AS age3 ON age3.sample_language_id = lang3.id


        WHERE sample.is_active = 1 AND result.id IS NOT NULL
        ORDER BY lsg.group, info.code;
    SQL

    execute <<-SQL
      CREATE VIEW `leapq_results_period`
      AS SELECT DISTINCT(info.sample_id),sample.phone,info.code,info.age,info.gender, lsg.group,
        period1.school AS L1school,period1.home AS L1home,period1.community AS L1community,
        period2.school AS L2school,period2.home AS L2home,period2.community AS L2community,
        period3.school AS L3school,period3.home AS L3home,period3.community AS L3community,
        bi1.period AS biSchool,bi2.period AS biHome,bi3.period AS biCommunity

        FROM leapq_sample_infos AS info
        JOIN leapq_samples AS sample ON sample.id = info.sample_id
        LEFT JOIN experiment_results AS result ON sample.phone = result.name
        LEFT JOIN leapq_sample_groups AS lsg ON lsg.sample_id = sample.id AND lsg.group_mode = 1 
        JOIN leapq_sample_languages AS lang1 ON lang1.sample_id = info.sample_id AND lang1.time_seq = 0
        JOIN leapq_sample_languages AS lang2 ON lang2.sample_id = info.sample_id AND lang2.time_seq = 1
        JOIN leapq_sample_languages AS lang3 ON lang3.sample_id = info.sample_id AND lang3.time_seq = 2

        JOIN leapq_sample_periods AS period1 ON period1.sample_language_id = lang1.id
        JOIN leapq_sample_periods AS period2 ON period2.sample_language_id = lang2.id
        JOIN leapq_sample_periods AS period3 ON period3.sample_language_id = lang3.id

        LEFT JOIN leapq_sample_bilinguals AS bi1 ON bi1.sample_id = info.sample_id AND bi1.scene = "school"
        LEFT JOIN leapq_sample_bilinguals AS bi2 ON bi2.sample_id = info.sample_id AND bi2.scene = "home"
        LEFT JOIN leapq_sample_bilinguals AS bi3 ON bi3.sample_id = info.sample_id AND bi3.scene = "community"


        WHERE sample.is_active = 1 AND result.id IS NOT NULL
        ORDER BY lsg.group, info.code;
    SQL

    execute <<-SQL
      CREATE VIEW `leapq_results_score`
      AS SELECT DISTINCT(info.sample_id),sample.phone,info.code,info.age,info.gender, lsg.group,
        self1.level_speak AS L1speak,self1.level_listen AS L1listen,self1.level_read AS L1read,
        self2.level_speak AS L2speak,self2.level_listen AS L2listen,self2.level_read AS L2read,
        self3.level_speak AS L3speak,self3.level_listen AS L3listen,self3.level_read AS L3read,

        self1.impact_family AS L1famimp,self1.impact_friend AS L1frienimp,self1.impact_school AS L1schimp,
        self1.impact_broadcast AS L1radioimp,self1.impact_read AS L1readimp,self1.impact_tv AS L1tvimp,self1.impact_network AS L1netimp,self1.impact_social AS L1sociedimp,
        self2.impact_family AS L2famimp,self2.impact_friend AS L2frienimp,self2.impact_school AS L2schimp,
        self2.impact_broadcast AS L2radioimp,self2.impact_read AS L2readimp,self2.impact_tv AS L2tvimp,self2.impact_network AS L2netimp,self2.impact_social AS L2sociedimp,
        self3.impact_family AS L3famimp,self3.impact_friend AS L3frienimp,self3.impact_school AS L3schimp,
        self3.impact_broadcast AS L3radioimp,self3.impact_read AS L3readimp,self3.impact_tv AS L3tvimp,self3.impact_network AS L3netimp,self3.impact_social AS L3sociedimp,

        self1.touch_family AS L1famexpo,self1.touch_friend AS L1frienexpo,self1.touch_school AS L1schexpo,
        self1.touch_broadcast AS L1radioexpo,self1.touch_read AS L1readexpo,self1.touch_tv AS L1tvexpo,self1.touch_network AS L1netexpo,self1.touch_social AS L1sociedexpo,
        self2.touch_family AS L2famexpo,self2.touch_friend AS L2frienexpo,self2.touch_school AS L2schexpo,
        self2.touch_broadcast AS L2radioexpo,self2.touch_read AS L2readexpo,self2.touch_tv AS L2tvexpo,self2.touch_network AS L2netexpo,self2.touch_social AS L2sociedexpo,
        self3.touch_family AS L3famexpo,self3.touch_friend AS L3frienexpo,self3.touch_school AS L3schexpo,
        self3.touch_broadcast AS L3radioexpo,self3.touch_read AS L3readexpo,self3.touch_tv AS L3tvexpo,self3.touch_network AS L3netexpo,self3.touch_social AS L3sociedexpo,

        self2.oral_speak AS L2accself,self2.oral_listen AS L2accother,
        self3.oral_speak AS L3accself,self3.oral_listen AS L3accother

        FROM leapq_sample_infos AS info
        JOIN leapq_samples AS sample ON sample.id = info.sample_id
        LEFT JOIN experiment_results AS result ON sample.phone = result.name
        LEFT JOIN leapq_sample_groups AS lsg ON lsg.sample_id = sample.id AND lsg.group_mode = 1 
        JOIN leapq_sample_languages AS lang1 ON lang1.sample_id = info.sample_id AND lang1.time_seq = 0
        JOIN leapq_sample_languages AS lang2 ON lang2.sample_id = info.sample_id AND lang2.time_seq = 1
        JOIN leapq_sample_languages AS lang3 ON lang3.sample_id = info.sample_id AND lang3.time_seq = 2

        JOIN leapq_sample_scores AS self1 ON self1.sample_language_id = lang1.id
        JOIN leapq_sample_scores AS self2 ON self2.sample_language_id = lang2.id
        JOIN leapq_sample_scores AS self3 ON self3.sample_language_id = lang3.id

        WHERE sample.is_active = 1 AND result.id IS NOT NULL
        ORDER BY lsg.group, info.code;
    SQL
  end

  def down
    execute <<-SQL
      DROP VIEW `leapq_results_percskill`;
    SQL
    execute <<-SQL
      DROP VIEW `leapq_results_info`
    SQL
    execute <<-SQL
      DROP VIEW `leapq_results_level`
    SQL
    execute <<-SQL
      DROP VIEW `leapq_results_age`
    SQL
    execute <<-SQL
      DROP VIEW `leapq_results_period`
    SQL
    execute <<-SQL
      DROP VIEW `leapq_results_score`
    SQL

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
      CREATE VIEW `leapq_results_info`
      AS SELECT DISTINCT(info.sample_id),sample.phone,info.code,info.age,info.gender, lsg.group,
        lang1.language_id AS L1,lang2.language_id AS L2,lang3.language_id AS L3,
        level1.language_id AS Level1,level2.language_id AS Level2,level3.language_id AS Level3

        FROM leapq_sample_infos AS info
        JOIN leapq_samples AS sample ON sample.id = info.sample_id
        LEFT JOIN experiment_results AS result ON sample.phone = result.name
        LEFT JOIN leapq_sample_groups AS lsg ON lsg.sample_id = sample.id 
        JOIN leapq_sample_languages AS lang1 ON lang1.sample_id = info.sample_id AND lang1.time_seq = 0
        JOIN leapq_sample_languages AS lang2 ON lang2.sample_id = info.sample_id AND lang2.time_seq = 1
        JOIN leapq_sample_languages AS lang3 ON lang3.sample_id = info.sample_id AND lang3.time_seq = 2

        JOIN leapq_sample_languages AS level1 ON level1.sample_id = info.sample_id AND level1.level_seq = 0
        JOIN leapq_sample_languages AS level2 ON level2.sample_id = info.sample_id AND level2.level_seq = 1
        JOIN leapq_sample_languages AS level3 ON level3.sample_id = info.sample_id AND level3.level_seq = 2


        WHERE sample.is_active = 1 AND result.id IS NOT NULL
        ORDER BY lsg.group, info.code;
    SQL

    execute <<-SQL
      CREATE VIEW `leapq_results_level`
      AS SELECT DISTINCT(info.sample_id),sample.phone,info.code,info.age,info.gender, lsg.group,
        lang1.language_id AS L1,lang2.language_id AS L2,lang3.language_id AS L3,
        lv1.first AS L1Contact,lv1.read AS L1PRead,lv1.speak AS L1PSpeak,lv1.write AS L1PWrite,
        lv2.first AS L2Contact,lv2.read AS L2PRead,lv2.speak AS L2PSpeak,lv2.write AS L2PWrite,
        lv3.first AS L3Contact,lv3.read AS L3PRead,lv3.speak AS L3PSpeak,lv3.write AS L3PWrite

        FROM leapq_sample_infos AS info
        JOIN leapq_samples AS sample ON sample.id = info.sample_id
        LEFT JOIN experiment_results AS result ON sample.phone = result.name
        LEFT JOIN leapq_sample_groups AS lsg ON lsg.sample_id = sample.id 
        JOIN leapq_sample_languages AS lang1 ON lang1.sample_id = info.sample_id AND lang1.time_seq = 0
        JOIN leapq_sample_languages AS lang2 ON lang2.sample_id = info.sample_id AND lang2.time_seq = 1
        JOIN leapq_sample_languages AS lang3 ON lang3.sample_id = info.sample_id AND lang3.time_seq = 2

        JOIN leapq_sample_levels AS lv1 ON lv1.sample_language_id = lang1.id
        JOIN leapq_sample_levels AS lv2 ON lv2.sample_language_id = lang2.id
        JOIN leapq_sample_levels AS lv3 ON lv3.sample_language_id = lang3.id


        WHERE sample.is_active = 1 AND result.id IS NOT NULL
        ORDER BY lsg.group, info.code;
    SQL

    execute <<-SQL
      CREATE VIEW `leapq_results_age`
      AS SELECT DISTINCT(info.sample_id),sample.phone,info.code,info.age,info.gender, lsg.group,
        lang1.language_id AS L1,lang2.language_id AS L2,lang3.language_id AS L3,
        age1.first AS L1exposed,age1.study AS L1school,age1.speak AS L1Lang,age1.normal AS L1Content,
        age2.first AS L2exposed,age2.study AS L2school,age2.speak AS L2Lang,age2.normal AS L2Content,
        age3.first AS L3exposed,age3.study AS L3school,age3.speak AS L3Lang,age3.normal AS L3Content

        FROM leapq_sample_infos AS info
        JOIN leapq_samples AS sample ON sample.id = info.sample_id
        LEFT JOIN experiment_results AS result ON sample.phone = result.name
        LEFT JOIN leapq_sample_groups AS lsg ON lsg.sample_id = sample.id 
        JOIN leapq_sample_languages AS lang1 ON lang1.sample_id = info.sample_id AND lang1.time_seq = 0
        JOIN leapq_sample_languages AS lang2 ON lang2.sample_id = info.sample_id AND lang2.time_seq = 1
        JOIN leapq_sample_languages AS lang3 ON lang3.sample_id = info.sample_id AND lang3.time_seq = 2

        JOIN leapq_sample_ages AS age1 ON age1.sample_language_id = lang1.id
        JOIN leapq_sample_ages AS age2 ON age2.sample_language_id = lang2.id
        JOIN leapq_sample_ages AS age3 ON age3.sample_language_id = lang3.id


        WHERE sample.is_active = 1 AND result.id IS NOT NULL
        ORDER BY lsg.group, info.code;
    SQL

    execute <<-SQL
      CREATE VIEW `leapq_results_period`
      AS SELECT DISTINCT(info.sample_id),sample.phone,info.code,info.age,info.gender, lsg.group,
        period1.school AS L1school,period1.home AS L1home,period1.community AS L1community,
        period2.school AS L2school,period2.home AS L2home,period2.community AS L2community,
        period3.school AS L3school,period3.home AS L3home,period3.community AS L3community,
        bi1.period AS biSchool,bi2.period AS biHome,bi3.period AS biCommunity

        FROM leapq_sample_infos AS info
        JOIN leapq_samples AS sample ON sample.id = info.sample_id
        LEFT JOIN experiment_results AS result ON sample.phone = result.name
        LEFT JOIN leapq_sample_groups AS lsg ON lsg.sample_id = sample.id 
        JOIN leapq_sample_languages AS lang1 ON lang1.sample_id = info.sample_id AND lang1.time_seq = 0
        JOIN leapq_sample_languages AS lang2 ON lang2.sample_id = info.sample_id AND lang2.time_seq = 1
        JOIN leapq_sample_languages AS lang3 ON lang3.sample_id = info.sample_id AND lang3.time_seq = 2

        JOIN leapq_sample_periods AS period1 ON period1.sample_language_id = lang1.id
        JOIN leapq_sample_periods AS period2 ON period2.sample_language_id = lang2.id
        JOIN leapq_sample_periods AS period3 ON period3.sample_language_id = lang3.id

        LEFT JOIN leapq_sample_bilinguals AS bi1 ON bi1.sample_id = info.sample_id AND bi1.scene = "school"
        LEFT JOIN leapq_sample_bilinguals AS bi2 ON bi2.sample_id = info.sample_id AND bi2.scene = "home"
        LEFT JOIN leapq_sample_bilinguals AS bi3 ON bi3.sample_id = info.sample_id AND bi3.scene = "community"


        WHERE sample.is_active = 1 AND result.id IS NOT NULL
        ORDER BY lsg.group, info.code;
    SQL

    execute <<-SQL
      CREATE VIEW `leapq_results_score`
      AS SELECT DISTINCT(info.sample_id),sample.phone,info.code,info.age,info.gender, lsg.group,
        self1.level_speak AS L1speak,self1.level_listen AS L1listen,self1.level_read AS L1read,
        self2.level_speak AS L2speak,self2.level_listen AS L2listen,self2.level_read AS L2read,
        self3.level_speak AS L3speak,self3.level_listen AS L3listen,self3.level_read AS L3read,

        self1.impact_family AS L1famimp,self1.impact_friend AS L1frienimp,self1.impact_school AS L1schimp,
        self1.impact_broadcast AS L1radioimp,self1.impact_read AS L1readimp,self1.impact_tv AS L1tvimp,self1.impact_network AS L1netimp,self1.impact_social AS L1sociedimp,
        self2.impact_family AS L2famimp,self2.impact_friend AS L2frienimp,self2.impact_school AS L2schimp,
        self2.impact_broadcast AS L2radioimp,self2.impact_read AS L2readimp,self2.impact_tv AS L2tvimp,self2.impact_network AS L2netimp,self2.impact_social AS L2sociedimp,
        self3.impact_family AS L3famimp,self3.impact_friend AS L3frienimp,self3.impact_school AS L3schimp,
        self3.impact_broadcast AS L3radioimp,self3.impact_read AS L3readimp,self3.impact_tv AS L3tvimp,self3.impact_network AS L3netimp,self3.impact_social AS L3sociedimp,

        self1.touch_family AS L1famexpo,self1.touch_friend AS L1frienexpo,self1.touch_school AS L1schexpo,
        self1.touch_broadcast AS L1radioexpo,self1.touch_read AS L1readexpo,self1.touch_tv AS L1tvexpo,self1.touch_network AS L1netexpo,self1.touch_social AS L1sociedexpo,
        self2.touch_family AS L2famexpo,self2.touch_friend AS L2frienexpo,self2.touch_school AS L2schexpo,
        self2.touch_broadcast AS L2radioexpo,self2.touch_read AS L2readexpo,self2.touch_tv AS L2tvexpo,self2.touch_network AS L2netexpo,self2.touch_social AS L2sociedexpo,
        self3.touch_family AS L3famexpo,self3.touch_friend AS L3frienexpo,self3.touch_school AS L3schexpo,
        self3.touch_broadcast AS L3radioexpo,self3.touch_read AS L3readexpo,self3.touch_tv AS L3tvexpo,self3.touch_network AS L3netexpo,self3.touch_social AS L3sociedexpo,

        self2.oral_speak AS L2accself,self2.oral_listen AS L2accother,
        self3.oral_speak AS L3accself,self3.oral_listen AS L3accother

        FROM leapq_sample_infos AS info
        JOIN leapq_samples AS sample ON sample.id = info.sample_id
        LEFT JOIN experiment_results AS result ON sample.phone = result.name
        LEFT JOIN leapq_sample_groups AS lsg ON lsg.sample_id = sample.id 
        JOIN leapq_sample_languages AS lang1 ON lang1.sample_id = info.sample_id AND lang1.time_seq = 0
        JOIN leapq_sample_languages AS lang2 ON lang2.sample_id = info.sample_id AND lang2.time_seq = 1
        JOIN leapq_sample_languages AS lang3 ON lang3.sample_id = info.sample_id AND lang3.time_seq = 2

        JOIN leapq_sample_scores AS self1 ON self1.sample_language_id = lang1.id
        JOIN leapq_sample_scores AS self2 ON self2.sample_language_id = lang2.id
        JOIN leapq_sample_scores AS self3 ON self3.sample_language_id = lang3.id

        WHERE sample.is_active = 1 AND result.id IS NOT NULL
        ORDER BY lsg.group, info.code;
    SQL
  end
end
