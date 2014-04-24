(1..100).each do |i| 
  User.create(name: "User#{i}", birthday: "21/4/2014", email: "user#{i}@example.com", 
  password: "foobar", password_confirmation: "foobar", role: '0', team_id: '6', position_id: '6')
end

(1..3).each do |i| 
  User.create(name: "Admin#{i}", birthday: "21/4/2014", email: "admin#{i}@example.com", 
  password: "foobar", password_confirmation: "foobar", role: '1', team_id: '6', position_id: '6')
end

(1..10).each do |i| 
  Skill.create(name: "Skill#{i}")
end

(1..30).each do |i| 
  Position.create(name: "Position#{i}", short_name: "Po#{i}" )
end

(1..35).each do |i| 
  Team.create(name: "team#{i}", description: "this is rails app", id_leader: i)
end

(1..10).each do |i| 
  Project.create(name: "Project#{i}", short_name: "Pj#{i}", 
    start_date: DateTime.now, end_date: DateTime.now + 3600, id_leader: i, team_id: i)
end