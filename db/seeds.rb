# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create Subscription Plans
plan_1 = Plan.where(type: 'solo', monthly_price: 2.00).first_or_create
plan_2 = Plan.where(type: 'startup', monthly_price: 20.00,
                    no_of_users: 5, unlimited_boards: true,
                    annual_price: 18.00, additional_user: 7.00).first_or_create
plan_3 = Plan.where(type: 'enterprise', monthly_price: 60.00,
                    no_of_users: 20, unlimited_boards: true,
                    annual_price: 55.00, additional_user: 6.00).first_or_create