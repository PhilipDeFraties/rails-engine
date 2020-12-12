require 'csv'

cmd = "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $(whoami) -d rails_engine_development db/data/rails-engine-development.pgdump"
puts "Loading PostgreSQL Data dump into local database with command:"
puts cmd
system(cmd)

def import_items
  items = []
  CSV.foreach('db/data/items.csv', headers: true) do |row|
    row["unit_price"] = (row["unit_price"].to_i * 0.01).round(2)
    items << row.to_h
  end
  Item.import(items)
end


import_items

ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end
