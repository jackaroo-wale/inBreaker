# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_12_224754) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "chatrooms", force: :cascade do |t|
    t.string "name"
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_chatrooms_on_team_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "receiver_id"
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_conversations_on_team_id"
  end

  create_table "initial_answers", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "initial_question_id", null: false
    t.string "wrong_answers", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["initial_question_id"], name: "index_initial_answers_on_initial_question_id"
    t.index ["user_id"], name: "index_initial_answers_on_user_id"
  end

  create_table "initial_questions", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "member_answers", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.string "answerable_type", null: false
    t.bigint "answerable_id", null: false
    t.boolean "correct", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "weekly_answer_id"
    t.index ["answerable_type", "answerable_id"], name: "index_member_answers_on_answerable_type_and_answerable_id"
    t.index ["member_id"], name: "index_member_answers_on_member_id"
    t.index ["weekly_answer_id"], name: "index_member_answers_on_weekly_answer_id"
  end

  create_table "members", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "weekly_points"
    t.integer "total_points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "team_id"
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "chatroom_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "private_messages", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "conversation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_private_messages_on_conversation_id"
    t.index ["user_id"], name: "index_private_messages_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "week_number", default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "description"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weekly_answers", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "weekly_question_id", null: false
    t.string "wrong_answers", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_weekly_answers_on_user_id"
    t.index ["weekly_question_id"], name: "index_weekly_answers_on_weekly_question_id"
  end

  create_table "weekly_questions", force: :cascade do |t|
    t.text "content"
    t.string "correct_answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "team_id", null: false
    t.index ["team_id"], name: "index_weekly_questions_on_team_id"
  end

  create_table "wrong_answers", force: :cascade do |t|
    t.text "content"
    t.bigint "weekly_question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["weekly_question_id"], name: "index_wrong_answers_on_weekly_question_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "chatrooms", "teams"
  add_foreign_key "conversations", "teams"
  add_foreign_key "initial_answers", "initial_questions"
  add_foreign_key "initial_answers", "users"
  add_foreign_key "member_answers", "members"
  add_foreign_key "member_answers", "weekly_answers"
  add_foreign_key "members", "users"
  add_foreign_key "messages", "chatrooms"
  add_foreign_key "messages", "users"
  add_foreign_key "private_messages", "conversations"
  add_foreign_key "private_messages", "users"
  add_foreign_key "weekly_answers", "users"
  add_foreign_key "weekly_answers", "weekly_questions"
  add_foreign_key "weekly_questions", "teams"
  add_foreign_key "wrong_answers", "weekly_questions"
end
