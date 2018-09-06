-- info --
Select distinct(info.sample_id),sample.phone,info.code,info.age,info.gender, lsg.group,
lang1.language_id AS L1,lang2.language_id AS L2,lang3.language_id AS L3,
level1.language_id AS Level1,level2.language_id AS Level2,level3.language_id AS Level3

From leapq_sample_infos AS info
Join leapq_samples AS sample on sample.id=info.sample_id
left Join experiment_results AS result on sample.phone=result.name
left join leapq_sample_groups as lsg on lsg.sample_id = sample.id 
Join leapq_sample_languages AS lang1 on lang1.sample_id=info.sample_id and lang1.time_seq=0
Join leapq_sample_languages AS lang2 on lang2.sample_id=info.sample_id and lang2.time_seq=1
Join leapq_sample_languages AS lang3 on lang3.sample_id=info.sample_id and lang3.time_seq=2

Join leapq_sample_languages AS level1 on level1.sample_id=info.sample_id and level1.level_seq=0
Join leapq_sample_languages AS level2 on level2.sample_id=info.sample_id and level2.level_seq=1
Join leapq_sample_languages AS level3 on level3.sample_id=info.sample_id and level3.level_seq=2


where sample.is_active=1 and result.id is not NULL
order by lsg.group, info.code;

-- level --
Select distinct(info.sample_id),sample.phone,info.code,info.age,info.gender, lsg.group,

lang1.language_id AS L1,lang2.language_id AS L2,lang3.language_id AS L3,
lv1.first AS L1Contact,lv1.read AS L1PRead,lv1.speak AS L1PSpeak,lv1.write AS L1PWrite,
lv2.first AS L2Contact,lv2.read AS L2PRead,lv2.speak AS L2PSpeak,lv2.write AS L2PWrite,
lv3.first AS L3Contact,lv3.read AS L3PRead,lv3.speak AS L3PSpeak,lv3.write AS L3PWrite

From leapq_sample_infos AS info
Join leapq_samples AS sample on sample.id=info.sample_id
left Join experiment_results AS result on sample.phone=result.name
left join leapq_sample_groups as lsg on lsg.sample_id = sample.id 
Join leapq_sample_languages AS lang1 on lang1.sample_id=info.sample_id and lang1.time_seq=0
Join leapq_sample_languages AS lang2 on lang2.sample_id=info.sample_id and lang2.time_seq=1
Join leapq_sample_languages AS lang3 on lang3.sample_id=info.sample_id and lang3.time_seq=2

Join leapq_sample_levels AS lv1 on lv1.sample_language_id=lang1.id
Join leapq_sample_levels AS lv2 on lv2.sample_language_id=lang2.id
Join leapq_sample_levels AS lv3 on lv3.sample_language_id=lang3.id


where sample.is_active=1 and result.id is not NULL
order by lsg.group, info.code;

-- age --
Select distinct(info.sample_id),sample.phone,info.code,info.age,info.gender, lsg.group,

lang1.language_id AS L1,lang2.language_id AS L2,lang3.language_id AS L3,
age1.first AS L1exposed,age1.study AS L1school,age1.speak AS L1Lang,age1.normal AS L1Content,
age2.first AS L2exposed,age2.study AS L2school,age2.speak AS L2Lang,age2.normal AS L2Content,
age3.first AS L3exposed,age3.study AS L3school,age3.speak AS L3Lang,age3.normal AS L3Content

From leapq_sample_infos AS info
Join leapq_samples AS sample on sample.id=info.sample_id
left Join experiment_results AS result on sample.phone=result.name
left join leapq_sample_groups as lsg on lsg.sample_id = sample.id 
Join leapq_sample_languages AS lang1 on lang1.sample_id=info.sample_id and lang1.time_seq=0
Join leapq_sample_languages AS lang2 on lang2.sample_id=info.sample_id and lang2.time_seq=1
Join leapq_sample_languages AS lang3 on lang3.sample_id=info.sample_id and lang3.time_seq=2

Join leapq_sample_ages AS age1 on age1.sample_language_id=lang1.id
Join leapq_sample_ages AS age2 on age2.sample_language_id=lang2.id
Join leapq_sample_ages AS age3 on age3.sample_language_id=lang3.id


where sample.is_active=1 and result.id is not NULL
order by lsg.group, info.code;

-- period --
Select distinct(info.sample_id),sample.phone,info.code,info.age,info.gender, lsg.group,


period1.school AS L1school,period1.home AS L1home,period1.community AS L1community,
period2.school AS L2school,period2.home AS L2home,period2.community AS L2community,
period3.school AS L3school,period3.home AS L3home,period3.community AS L3community,
bi1.period AS biSchool,bi2.period AS biHome,bi3.period AS biCommunity

From leapq_sample_infos AS info
Join leapq_samples AS sample on sample.id=info.sample_id
left Join experiment_results AS result on sample.phone=result.name
left join leapq_sample_groups as lsg on lsg.sample_id = sample.id 
Join leapq_sample_languages AS lang1 on lang1.sample_id=info.sample_id and lang1.time_seq=0
Join leapq_sample_languages AS lang2 on lang2.sample_id=info.sample_id and lang2.time_seq=1
Join leapq_sample_languages AS lang3 on lang3.sample_id=info.sample_id and lang3.time_seq=2

Join leapq_sample_periods AS period1 on period1.sample_language_id=lang1.id
Join leapq_sample_periods AS period2 on period2.sample_language_id=lang2.id
Join leapq_sample_periods AS period3 on period3.sample_language_id=lang3.id

left Join leapq_sample_bilinguals AS bi1 on bi1.sample_id=info.sample_id and bi1.scene="school"
left Join leapq_sample_bilinguals AS bi2 on bi2.sample_id=info.sample_id and bi2.scene="home"
left Join leapq_sample_bilinguals AS bi3 on bi3.sample_id=info.sample_id and bi3.scene="community"


where sample.is_active=1 and result.id is not NULL
order by lsg.group, info.code;

-- score --
Select distinct(info.sample_id),sample.phone,info.code,info.age,info.gender, lsg.group,

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

From leapq_sample_infos AS info
Join leapq_samples AS sample on sample.id=info.sample_id
left Join experiment_results AS result on sample.phone=result.name
left join leapq_sample_groups as lsg on lsg.sample_id = sample.id 
Join leapq_sample_languages AS lang1 on lang1.sample_id=info.sample_id and lang1.time_seq=0
Join leapq_sample_languages AS lang2 on lang2.sample_id=info.sample_id and lang2.time_seq=1
Join leapq_sample_languages AS lang3 on lang3.sample_id=info.sample_id and lang3.time_seq=2

Join leapq_sample_scores AS self1 on self1.sample_language_id=lang1.id
Join leapq_sample_scores AS self2 on self2.sample_language_id=lang2.id
Join leapq_sample_scores AS self3 on self3.sample_language_id=lang3.id

where sample.is_active=1 and result.id is not NULL
order by lsg.group, info.code;