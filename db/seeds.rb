(1..100).each do |i| 
  User.create(name: "User#{i}", birthday: "21/4/2014", email: "user#{i}@example.com", 
  password: "foobar", password_confirmation: "foobar", role: 0)
end

(1..3).each do |i| 
  User.create(name: "Admin#{i}", birthday: "21/4/2014", email: "admin#{i}@example.com", 
  password: "foobar", password_confirmation: "foobar", role: 1)
end

(1..35).each do |i| 
  Team.create(name: "team#{i}", description: "this is rails app", id_leader: "#{i + 5}")
end
