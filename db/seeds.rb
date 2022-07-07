# Create some user examples
user_a = User.create(name: "Alice Adams", description: "Lorem ipsum dolor sit amet", email: "alice@example.com", password: "ktjfiomoyw")
user_b = User.create(name: "Bob Brown", description: "Vitae suscipit tellus mauris", email: "bob@example.com", password: "zeyttwzopl")
user_c = User.create(name: "Carol Clark", description: "Viverra justo nec ultrices", email: "carol@example.com", password: "laenwlnsjh")
user_d = User.create(name: "Dave Davis", description: "Quis eleifend quam adipiscing", email: "dave@example.com", password: "nyvoilizmd")
user_e = User.create(name: "Eve Evans", description: "Lacus suspendisse faucibus interdum", email: "eve@example.com", password: "trckaxquip")
user_f = User.create(name: "Frank Franklin", description: "Etiam ut feugiat nibh", email: "frank@example.com", password: "dfvieipwyd")

# Create some group examples
group_a = Group.create(name: "Archery", description: "Fusce ullamcorper sem curabitur")
group_b = Group.create(name: "Basketball", description: "Orci varius natoque penatibus")
group_c = Group.create(name: "Cricket", description: "Vivamus id nisi efficitur")
group_d = Group.create(name: "Dodgeball", description: "Cras vulputate laoreet est")
group_e = Group.create(name: "Equestrianism", description: "Pellentesque nibh arcu tempus")
group_f = Group.create(name: "Fencing", description: "Dignissim fringilla diam ultrices")

# Create some user group examples
user_a.groups = [group_a, group_b, group_c]
user_b.groups = [group_b, group_c, group_d]
user_c.groups = [group_c, group_d, group_e]
user_d.groups = [group_d, group_e, group_f]
user_e.groups = [group_e, group_f, group_a]
user_f.groups = [group_f, group_a, group_b]
