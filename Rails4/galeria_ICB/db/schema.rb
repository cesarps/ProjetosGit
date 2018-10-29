# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20181009123555) do

  create_table "albuns", force: :cascade do |t|
    t.date     "data_evento"
    t.text     "nome_evento_assunto", limit: 65535
    t.integer  "departamento_id",     limit: 4
    t.string   "nome_fotografo",      limit: 255
    t.text     "endereco",            limit: 65535
    t.integer  "categoria_id",        limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "capa",                limit: 4
  end

  create_table "categorias", force: :cascade do |t|
    t.string   "nome",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "departamentos", force: :cascade do |t|
    t.string   "nome",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "fotos", force: :cascade do |t|
    t.integer  "album_id",   limit: 4
    t.string   "arquivo",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "subtitle",   limit: 255
  end

  create_table "logs", force: :cascade do |t|
    t.string   "acao",       limit: 255
    t.string   "ip",         limit: 255
    t.integer  "usuario_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "logs", ["usuario_id"], name: "index_logs_on_usuario_id", using: :btree

  create_table "perfils", force: :cascade do |t|
    t.string   "tipo",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "permitidos", force: :cascade do |t|
    t.integer  "usuario_id", limit: 4
    t.integer  "perfil_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "permitidos", ["perfil_id"], name: "index_permitidos_on_perfil_id", using: :btree
  add_index "permitidos", ["usuario_id"], name: "index_permitidos_on_usuario_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.integer  "album_id",   limit: 4
    t.string   "nome",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "tipo_vinculos", force: :cascade do |t|
    t.string   "tipoVinculo",         limit: 255
    t.string   "codigoSetor",         limit: 255
    t.string   "nomeAbreviadSetor",   limit: 255
    t.string   "nomeSetor",           limit: 255
    t.string   "codigoUnidade",       limit: 255
    t.string   "siglaUnidade",        limit: 255
    t.string   "nomeUnidade",         limit: 255
    t.string   "nomeVinculo",         limit: 255
    t.string   "nomeAbreviadoFuncao", limit: 255
    t.integer  "usuario_id",          limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "tipo_vinculos", ["usuario_id"], name: "index_tipo_vinculos_on_usuario_id", using: :btree

  create_table "usuarios", force: :cascade do |t|
    t.string   "nomeUsuario",             limit: 255
    t.string   "loginUsuario",            limit: 255
    t.string   "tipoUsuario",             limit: 255
    t.string   "emailPrincipalUsuario",   limit: 255
    t.string   "emailAlternativoUsuario", limit: 255
    t.string   "emailUspUsuario",         limit: 255
    t.string   "numeroTelefoneFormatado", limit: 255
    t.string   "ramalUsp",                limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_foreign_key "logs", "usuarios"
  add_foreign_key "permitidos", "perfils"
  add_foreign_key "permitidos", "usuarios"
  add_foreign_key "tipo_vinculos", "usuarios"
end
