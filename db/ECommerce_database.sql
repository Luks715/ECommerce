-- Criação do banco de dados
CREATE DATABASE ECommerce2_Development;

-- Tabela carrinhos
CREATE TABLE "carrinhos" (
    "id" BIGSERIAL PRIMARY KEY,
    "user_id" BIGINT NOT NULL,
    "created_at" TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP NOT NULL,
    FOREIGN KEY ("user_id") REFERENCES "users" ("id")
);

-- Tabela categoria
CREATE TABLE "categoria" (
    "id" BIGSERIAL PRIMARY KEY,
    "nome" VARCHAR NOT NULL,
    "produto_mais_vendido" VARCHAR,
    "created_at" TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP NOT NULL
);

-- Tabela clientes
CREATE TABLE "clientes" (
    "id" BIGSERIAL PRIMARY KEY,
    "user_id" BIGINT NOT NULL,
    "cpf" VARCHAR NOT NULL,
    "saldo" DECIMAL(10, 2) DEFAULT 0.0 NOT NULL,
    "created_at" TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP NOT NULL,
    FOREIGN KEY ("user_id") REFERENCES "users" ("id")
);

-- Tabela historicos
CREATE TABLE "historicos" (
    "id" BIGSERIAL PRIMARY KEY,
    "cliente_nome" VARCHAR NOT NULL,
    "vendedor_nome" VARCHAR NOT NULL,
    "produto_nome" VARCHAR NOT NULL,
    "quantidade" INTEGER NOT NULL,
    "data_compra" DATE NOT NULL,
    "review_do_produto" BOOLEAN NOT NULL,
    "review_do_vendedor" BOOLEAN NOT NULL,
    "created_at" TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP NOT NULL
);

-- Tabela pedidos
CREATE TABLE "pedidos" (
    "id" BIGSERIAL PRIMARY KEY,
    "carrinho_id" BIGINT NOT NULL,
    "cliente_id" BIGINT NOT NULL,
    "produto_id" BIGINT NOT NULL,
    "quantidade" INTEGER NOT NULL,
    "foi_pago" BOOLEAN NOT NULL,
    "foi_enviado" BOOLEAN NOT NULL,
    "data_chegada" DATE NOT NULL,
    "created_at" TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP NOT NULL,
    FOREIGN KEY ("carrinho_id") REFERENCES "carrinhos" ("id"),
    FOREIGN KEY ("cliente_id") REFERENCES "clientes" ("id"),
    FOREIGN KEY ("produto_id") REFERENCES "produtos" ("id")
);

-- Tabela produtos
CREATE TABLE "produtos" (
    "id" BIGSERIAL PRIMARY KEY,
    "vendedor_id" BIGINT NOT NULL,
    "categorium_id" BIGINT NOT NULL,
    "nome" VARCHAR NOT NULL,
    "descricao" TEXT NOT NULL,
    "nota" FLOAT DEFAULT 0.0,
    "preco" DECIMAL(10, 2) NOT NULL,
    "em_estoque" INTEGER NOT NULL,
    "imagem" BYTEA,
    "desconto" INTEGER NOT NULL,
    "data_fim" DATE,
    "created_at" TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP NOT NULL,
    FOREIGN KEY ("vendedor_id") REFERENCES "vendedors" ("id"),
    FOREIGN KEY ("categorium_id") REFERENCES "categoria" ("id")
);

-- Tabela review_produtos
CREATE TABLE "review_produtos" (
    "id" BIGSERIAL PRIMARY KEY,
    "cliente_id" BIGINT NOT NULL,
    "produto_id" BIGINT NOT NULL,
    "nota" INTEGER NOT NULL,
    "comentario" TEXT NOT NULL,
    "created_at" TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP NOT NULL,
    FOREIGN KEY ("cliente_id") REFERENCES "clientes" ("id"),
    FOREIGN KEY ("produto_id") REFERENCES "produtos" ("id")
);

-- Tabela review_vendedors
CREATE TABLE "review_vendedors" (
    "id" BIGSERIAL PRIMARY KEY,
    "cliente_id" BIGINT NOT NULL,
    "vendedor_id" BIGINT NOT NULL,
    "nota" INTEGER NOT NULL,
    "comentario" TEXT NOT NULL,
    "created_at" TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP NOT NULL,
    FOREIGN KEY ("cliente_id") REFERENCES "clientes" ("id"),
    FOREIGN KEY ("vendedor_id") REFERENCES "vendedors" ("id")
);

-- Tabela users
CREATE TABLE "users" (
    "id" BIGSERIAL PRIMARY KEY,
    "nome" VARCHAR NOT NULL,
    "telefone" VARCHAR NOT NULL,
    "endereco" VARCHAR NOT NULL,
    "role" INTEGER DEFAULT 0 NOT NULL,
    "imagem" BYTEA,
    "created_at" TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP NOT NULL,
    "email" VARCHAR DEFAULT '' NOT NULL UNIQUE,
    "encrypted_password" VARCHAR DEFAULT '' NOT NULL,
    "reset_password_token" VARCHAR UNIQUE,
    "reset_password_sent_at" TIMESTAMP,
    "remember_created_at" TIMESTAMP,
    "sign_in_count" INTEGER DEFAULT 0 NOT NULL,
    "current_sign_in_at" TIMESTAMP,
    "last_sign_in_at" TIMESTAMP,
    "current_sign_in_ip" VARCHAR,
    "last_sign_in_ip" VARCHAR
);

-- Tabela vendedors
CREATE TABLE "vendedors" (
    "id" BIGSERIAL PRIMARY KEY,
    "user_id" BIGINT NOT NULL,
    "cnpj" VARCHAR NOT NULL,
    "email_para_contato" VARCHAR NOT NULL,
    "carteira" DECIMAL(10, 2) DEFAULT 0.0 NOT NULL,
    "created_at" TIMESTAMP NOT NULL,
    "updated_at" TIMESTAMP NOT NULL,
    FOREIGN KEY ("user_id") REFERENCES "users" ("id")
);
