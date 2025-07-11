mongodb-tool-install:
    sudo apt-get install gnupg curl
    curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
    sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg \
    --dearmor
    echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
    sudo apt-get update
    sudo apt install mongodb-database-tools

redis-tool-install:
    sudo apt-get install lsb-release curl gpg
    curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
    sudo chmod 644 /usr/share/keyrings/redis-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list
    sudo apt-get update
    sudo apt install redis-tools # for redis-cli

import-data:
    mongoimport --db mcim_backend --collection modrinth_projects --file ./data/modrinth_projects.json --jsonArray --drop
    mongoimport --db mcim_backend --collection modrinth_versions --file ./data/modrinth_versions.json --jsonArray --drop
    mongoimport --db mcim_backend --collection modrinth_files --file ./data/modrinth_files.json --jsonArray --drop
    mongoimport --db mcim_backend --collection modrinth_loaders --file ./data/modrinth_loaders.json --jsonArray --drop
    mongoimport --db mcim_backend --collection modrinth_game_versions --file ./data/modrinth_game_versions.json --jsonArray --drop
    mongoimport --db mcim_backend --collection modrinth_categories --file ./data/modrinth_categories.json --jsonArray --drop
    mongoimport --db mcim_backend --collection curseforge_mods --file ./data/curseforge_mods.json --jsonArray --drop
    mongoimport --db mcim_backend --collection curseforge_files --file ./data/curseforge_files.json --jsonArray --drop
    mongoimport --db mcim_backend --collection curseforge_fingerprints --file ./data/curseforge_fingerprints.json --jsonArray --drop
    mongoimport --db mcim_backend --collection curseforge_categories --file ./data/curseforge_categories.json --jsonArray --drop
    mongoimport --db mcim_backend --collection file_cdn_files --file ./data/file_cdn_files.json --jsonArray --drop
    mongoimport --db mcim_backend --collection modrinth_translated --file ./data/modrinth_translated.json --jsonArray --drop
    mongoimport --db mcim_backend --collection curseforge_translated --file ./data/curseforge_translated.json --jsonArray --drop


build:
    cargo build --release

ci-test:
    cargo test --verbose