# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'factory_bot_rails'
unless Hct.exists?(role: :admin)
  FactoryBot.create(:hct, :with_admin,firm_name: "admin")
end

unless Hct.exists?(role: :normal)
   FactoryBot.create(:hct,firm_name: "normal_firm")
end
