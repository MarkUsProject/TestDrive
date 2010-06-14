#!/bin/bash

my_dir=`pwd`

cat > "$my_dir/test_drive/config/database.yml" <<ENDFILE
test:
    adapter: sqlite3
    database: db/test.db
production:
    adapter: sqlite3
    database: db/production.db
development:
    adapter: sqlite3
    database: db/development.db
ENDFILE

repo_storage_sed="s%REPOSITORY_STORAGE = .*%REPOSITORY_STORAGE = \"$my_dir/repos/\"%"
test_framework_storage_sed="s%TEST_FRAMEWORK_REPOSITORY = .*%TEST_FRAMEWORK_REPOSITORY = \"$my_dir/test_framework_repos/\"%"
cp $my_dir/test_drive/config/environments/production.rb $my_dir/test_drive/config/environments/production.rb.old
cp $my_dir/test_drive/config/environments/development.rb $my_dir/test_drive/config/environments/development.rb.old

# set repo storage for test drive
sed -i "$repo_storage_sed" $my_dir/test_drive/config/environments/production.rb
sed -i "$repo_storage_sed" $my_dir/test_drive/config/environments/development.rb

# set test framework repo storage for test drive
sed -i "$test_framework_storage_sed" $my_dir/test_drive/config/environments/production.rb
sed -i "$test_framework_storage_sed" $my_dir/test_drive/config/environments/development.rb
