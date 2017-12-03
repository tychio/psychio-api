# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171203143327) do

  create_table "analysis_group", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",                    limit: 50
    t.string  "phone",                   limit: 20
    t.string  "qq",                      limit: 20
    t.string  "wechat",                  limit: 50
    t.integer "lang1_speaking_self"
    t.integer "lang2_speaking_self"
    t.integer "lang1_listening_self"
    t.integer "lang2_listening_self"
    t.integer "lang1_reading_self"
    t.integer "lang2_reading_self"
    t.integer "lang1_reading_use"
    t.integer "lang2_reading_use"
    t.integer "lang1_speaking_use"
    t.integer "lang2_speaking_use"
    t.integer "lang1_listening_use"
    t.integer "lang2_listening_use"
    t.integer "lang1_writing_use"
    t.integer "lang2_writing_use"
    t.integer "lang1_start_age"
    t.integer "lang2_start_age"
    t.integer "lang1_learn_age"
    t.integer "lang2_learn_age"
    t.integer "lang1_l_instrcution_age"
    t.integer "lang2_l_instrcution_age"
    t.integer "lang1_c_instrcution_age"
    t.integer "lang2_c_instrcution_age"
  end

  create_table "analysis_groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                    limit: 50
    t.string   "phone",                   limit: 20
    t.string   "qq",                      limit: 20
    t.string   "wechat",                  limit: 50
    t.integer  "lang1_speaking_self"
    t.integer  "lang2_speaking_self"
    t.integer  "lang1_listening_self"
    t.integer  "lang2_listening_self"
    t.integer  "lang1_reading_self"
    t.integer  "lang2_reading_self"
    t.integer  "lang1_reading_use"
    t.integer  "lang2_reading_use"
    t.integer  "lang1_speaking_use"
    t.integer  "lang2_speaking_use"
    t.integer  "lang1_listening_use"
    t.integer  "lang2_listening_use"
    t.integer  "lang1_writing_use"
    t.integer  "lang2_writing_use"
    t.integer  "lang1_start_age"
    t.integer  "lang2_start_age"
    t.integer  "lang1_learn_age"
    t.integer  "lang2_learn_age"
    t.integer  "lang1_l_instrcution_age"
    t.integer  "lang2_l_instrcution_age"
    t.integer  "lang1_c_instrcution_age"
    t.integer  "lang2_c_instrcution_age"
    t.datetime "created_at",                         default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at",                         default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "leapq_languages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       limit: 20
    t.string   "display",    limit: 10
    t.datetime "created_at",            default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at",            default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "leapq_sample_ages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "sample_id"
    t.integer  "sample_language_id"
    t.integer  "first"
    t.integer  "study"
    t.integer  "speak"
    t.integer  "normal"
    t.datetime "created_at",         default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "updated_at",         default: -> { "CURRENT_TIMESTAMP" }
    t.index ["sample_id"], name: "index_leapq_sample_ages_on_sample_id", using: :btree
    t.index ["sample_language_id"], name: "index_leapq_sample_ages_on_sample_language_id", using: :btree
  end

  create_table "leapq_sample_barriers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "sample_id"
    t.boolean  "vision",                    default: false,                      null: false
    t.boolean  "hearing",                   default: false,                      null: false
    t.boolean  "language",                  default: false,                      null: false
    t.boolean  "study",                     default: false,                      null: false
    t.text     "explanation", limit: 65535
    t.datetime "created_at",                default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "updated_at",                default: -> { "CURRENT_TIMESTAMP" }
    t.index ["sample_id"], name: "index_leapq_sample_barriers_on_sample_id", using: :btree
  end

  create_table "leapq_sample_bilinguals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "sample_id"
    t.integer  "first_language_id"
    t.integer  "second_language_id"
    t.integer  "period"
    t.datetime "created_at",                    default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "updated_at",                    default: -> { "CURRENT_TIMESTAMP" }
    t.string   "scene",              limit: 20, default: "school"
    t.index ["first_language_id"], name: "index_leapq_sample_bilinguals_on_first_language_id", using: :btree
    t.index ["sample_id"], name: "index_leapq_sample_bilinguals_on_sample_id", using: :btree
    t.index ["second_language_id"], name: "index_leapq_sample_bilinguals_on_second_language_id", using: :btree
  end

  create_table "leapq_sample_infos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "sample_id"
    t.string   "first_name",     limit: 20
    t.string   "last_name",      limit: 20
    t.date     "birthday"
    t.integer  "age"
    t.boolean  "gender",                    default: false
    t.string   "university",     limit: 20
    t.string   "college",        limit: 20
    t.string   "major",          limit: 30
    t.string   "student_number", limit: 20
    t.datetime "created_at",                default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "updated_at",                default: -> { "CURRENT_TIMESTAMP" }
    t.string   "nation",         limit: 20
    t.string   "province",       limit: 20
    t.string   "city",           limit: 20
    t.index ["sample_id"], name: "index_leapq_sample_infos_on_sample_id", using: :btree
  end

  create_table "leapq_sample_languages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "sample_id"
    t.integer  "language_id"
    t.integer  "level_seq",   limit: 3
    t.integer  "time_seq",    limit: 3
    t.datetime "created_at",            default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "updated_at",            default: -> { "CURRENT_TIMESTAMP" }
    t.index ["language_id"], name: "index_leapq_sample_languages_on_language_id", using: :btree
    t.index ["sample_id"], name: "index_leapq_sample_languages_on_sample_id", using: :btree
  end

  create_table "leapq_sample_levels", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "sample_id"
    t.integer  "sample_language_id"
    t.integer  "first"
    t.integer  "read"
    t.integer  "speak"
    t.integer  "write"
    t.datetime "created_at",         default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "updated_at",         default: -> { "CURRENT_TIMESTAMP" }
    t.index ["sample_id"], name: "index_leapq_sample_levels_on_sample_id", using: :btree
    t.index ["sample_language_id"], name: "index_leapq_sample_levels_on_sample_language_id", using: :btree
  end

  create_table "leapq_sample_periods", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "sample_id"
    t.integer  "sample_language_id"
    t.integer  "school"
    t.integer  "home"
    t.integer  "community"
    t.datetime "created_at",         default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "updated_at",         default: -> { "CURRENT_TIMESTAMP" }
    t.index ["sample_id"], name: "index_leapq_sample_periods_on_sample_id", using: :btree
    t.index ["sample_language_id"], name: "index_leapq_sample_periods_on_sample_language_id", using: :btree
  end

  create_table "leapq_sample_scores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "sample_id"
    t.integer  "sample_language_id"
    t.integer  "level_speak"
    t.integer  "level_listen"
    t.integer  "level_read"
    t.integer  "impact_family"
    t.integer  "impact_friend"
    t.integer  "impact_school"
    t.integer  "impact_broadcast"
    t.integer  "impact_read"
    t.integer  "impact_tv"
    t.integer  "impact_network"
    t.integer  "impact_social"
    t.integer  "touch_family"
    t.integer  "touch_friend"
    t.integer  "touch_school"
    t.integer  "touch_broadcast"
    t.integer  "touch_read"
    t.integer  "touch_tv"
    t.integer  "touch_network"
    t.integer  "touch_social"
    t.integer  "oral_speak"
    t.integer  "oral_listen"
    t.datetime "created_at",         default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "updated_at",         default: -> { "CURRENT_TIMESTAMP" }
    t.index ["sample_id"], name: "index_leapq_sample_scores_on_sample_id", using: :btree
    t.index ["sample_language_id"], name: "index_leapq_sample_scores_on_sample_language_id", using: :btree
  end

  create_table "leapq_samples", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "phone",      limit: 20
    t.string   "wechat",     limit: 50
    t.string   "qq",         limit: 20
    t.integer  "status"
    t.boolean  "is_active",             default: true
    t.datetime "created_at",            default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at",            default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  add_foreign_key "leapq_sample_ages", "leapq_sample_languages", column: "sample_language_id"
  add_foreign_key "leapq_sample_ages", "leapq_samples", column: "sample_id"
  add_foreign_key "leapq_sample_barriers", "leapq_samples", column: "sample_id"
  add_foreign_key "leapq_sample_bilinguals", "leapq_sample_languages", column: "first_language_id"
  add_foreign_key "leapq_sample_bilinguals", "leapq_sample_languages", column: "second_language_id"
  add_foreign_key "leapq_sample_bilinguals", "leapq_samples", column: "sample_id"
  add_foreign_key "leapq_sample_infos", "leapq_samples", column: "sample_id"
  add_foreign_key "leapq_sample_languages", "leapq_languages", column: "language_id"
  add_foreign_key "leapq_sample_languages", "leapq_samples", column: "sample_id"
  add_foreign_key "leapq_sample_levels", "leapq_sample_languages", column: "sample_language_id"
  add_foreign_key "leapq_sample_levels", "leapq_samples", column: "sample_id"
  add_foreign_key "leapq_sample_periods", "leapq_sample_languages", column: "sample_language_id"
  add_foreign_key "leapq_sample_periods", "leapq_samples", column: "sample_id"
  add_foreign_key "leapq_sample_scores", "leapq_sample_languages", column: "sample_language_id"
  add_foreign_key "leapq_sample_scores", "leapq_samples", column: "sample_id"
end
