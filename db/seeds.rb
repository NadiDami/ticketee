# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
User.delete_all
User.create(email: "admin@example.com", name: "admin", password: "password", password_confirmation: "password", admin: true)


Project.delete_all
Project.create(name: "Ticketee Beta")

State.delete_all
State.create( name: 'New',
              background: "#85FF00",
              color: "white")

State.create( name: 'Open',
              background: "#00CFFD",
              color: "white")

State.create( name: 'Closed',
              background: "black",
              color: "white")
