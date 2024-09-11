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

ActiveRecord::Schema[7.1].define(version: 2024_09_08_232653) do
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

  create_table "carrinhos", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_carrinhos_on_user_id"
  end

  create_table "categoria", force: :cascade do |t|
    t.string "nome", null: false
    t.string "produto_mais_vendido"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clientes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "cpf", null: false
    t.decimal "saldo", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_clientes_on_user_id"
  end

  create_table "historicos", force: :cascade do |t|
    t.string "cliente_nome", null: false
    t.string "vendedor_nome", null: false
    t.string "produto_nome", null: false
    t.integer "quantidade", null: false
    t.date "data_compra", null: false
    t.boolean "review_do_produto", null: false
    t.boolean "review_do_vendedor", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pedidos", force: :cascade do |t|
    t.bigint "carrinho_id", null: false
    t.bigint "cliente_id", null: false
    t.bigint "produto_id", null: false
    t.integer "quantidade", null: false
    t.boolean "foi_pago", null: false
    t.boolean "foi_enviado", null: false
    t.date "data_chegada", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carrinho_id"], name: "index_pedidos_on_carrinho_id"
    t.index ["cliente_id"], name: "index_pedidos_on_cliente_id"
    t.index ["produto_id"], name: "index_pedidos_on_produto_id"
  end

  create_table "produtos", force: :cascade do |t|
    t.bigint "vendedor_id", null: false
    t.bigint "categorium_id", null: false
    t.string "nome", null: false
    t.text "descricao", null: false
    t.decimal "preco", precision: 10, scale: 2, null: false
    t.integer "em_estoque", null: false
    t.binary "imagem"
    t.integer "desconto", null: false
    t.date "data_fim"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["categorium_id"], name: "index_produtos_on_categorium_id"
    t.index ["vendedor_id"], name: "index_produtos_on_vendedor_id"
  end

  create_table "review_produtos", force: :cascade do |t|
    t.bigint "cliente_id", null: false
    t.bigint "produto_id", null: false
    t.integer "nota", null: false
    t.text "comentario", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_review_produtos_on_cliente_id"
    t.index ["produto_id"], name: "index_review_produtos_on_produto_id"
  end

  create_table "review_vendedors", force: :cascade do |t|
    t.bigint "cliente_id", null: false
    t.bigint "vendedor_id", null: false
    t.integer "nota", null: false
    t.text "comentario", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_review_vendedors_on_cliente_id"
    t.index ["vendedor_id"], name: "index_review_vendedors_on_vendedor_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "nome", null: false
    t.string "telefone", null: false
    t.string "endereco", null: false
    t.integer "role", default: 0, null: false
    t.binary "imagem"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vendedors", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "cnpj", null: false
    t.string "email_para_contato", null: false
    t.decimal "carteira", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_vendedors_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "carrinhos", "users"
  add_foreign_key "clientes", "users"
  add_foreign_key "pedidos", "carrinhos"
  add_foreign_key "pedidos", "clientes"
  add_foreign_key "pedidos", "produtos"
  add_foreign_key "produtos", "categoria"
  add_foreign_key "produtos", "vendedors"
  add_foreign_key "review_produtos", "clientes"
  add_foreign_key "review_produtos", "produtos"
  add_foreign_key "review_vendedors", "clientes"
  add_foreign_key "review_vendedors", "vendedors"
  add_foreign_key "vendedors", "users"
end
