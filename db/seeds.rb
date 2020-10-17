User.create({username: "test-1", email: "test-1@email.com", password: "test-1-password"})
User.create({username: "test-2", email: "test-2@email.com", password: "test-2-password"})
User.create({username: "test-3", email: "test-3@email.com", password: "test-3-password"})
User.create({username: "test-4", email: "test-4@email.com", password: "test-4-password"})
User.create({username: "test-5", email: "test-5@email.com", password: "test-5-password"})

t1 = Time.new(1993, 2, 24, 12, 0, 0, "+09:00").strftime("%Y-%m-%d %H:%M:%S")
t2 = Time.new(2007, 1, 25, 07, 0, 8, "+09:00").strftime("%Y-%m-%d %H:%M:%S")
t3 = Time.new(2007, 1, 25, 11, 1, 6, "+09:00").strftime("%Y-%m-%d %H:%M:%S")
t4 = Time.new(2002, 9, 16, 12, 0, 0, "+09:00").strftime("%Y-%m-%d %H:%M:%S")
t5 = Time.new(2018, 11, 15, 02, 4, 3, "+09:00").strftime("%Y-%m-%d %H:%M:%S")


Post.create({content: "This is some sample content!", date_posted: t1})
Post.create({content: "Here is another piece to work with.", date_posted: t2})
Post.create({content: "Hopefully this will help.", date_posted: t3})
Post.create({content: "Can I order this correctly?", date_posted: t4})
Post.create({content: "Yes, I can!", date_posted: t5})