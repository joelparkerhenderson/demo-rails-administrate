# Demo Rails Administrate

Demonstration of:

* [Ruby on Rails](https://rubyonrails.org) web framework

* [Administrate](https://github.com/thoughtbot/administrate) gem by ThoughtBot


## Prepare

Ruby 3 or greater:

```sh
ruby --version
```

Rails 7 or greater:

```sh
gem list rails
```

SQLite 3 or greater:

```sh
sqlite3 --version
```


## Create

Create demo:

```sh
rails new demo
cd demo
asdf local ruby latest
bin/rails db:prepare
bin/rails server
```


## Scaffold

Edit file `config/routes`:

```ruby
root "users#index"
```

Generate scaffolds:

```sh
bin/rails generate scaffold User name:string description:string
bin/rails generate scaffold Group name:string description:string
bin/rails generate migration CreateJoinTableGroupUser group user 
bin/rails db:migrate
```

Edit file `app/models/user.rb`

```ruby
class User < ApplicationRecord
  has_and_belongs_to_many :groups
end
```

Edit file `app/models/group.rb`

```ruby
class Group < ApplicationRecord
  has_and_belongs_to_many :users
end
```


## Devise

Add to `Gemfile`:

```ruby
# Devise authentication
gem "devise"
```

Setup:

```sh
bundle install
rails generate devise:install
rails generate devise User
rails db:migrate
```


### Root

Ensure you have defined root_url to something in your file `config/routes.rb`.

Example:

```ruby
root to: "home#index"
```


## Flash

Ensure you have flash messages in file `app/views/layouts/application.html.erb`.

Example:

```ruby
<p class="notice"><%= notice %></p>
<p class="alert"><%= alert %></p>
```


### Mailer

Ensure you have defined `default_url_options` in your file `config/environments/development.rb`.

Example:

```ruby
config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
```


## Seeds

Edit file `db/seeds.rb`

```rb
# Create some user xamples
user_a = User.create(name: "Alice Adams", description: "Lorem ipsum dolor sit amet", email: "alice@example.com")
user_b = User.create(name: "Bob Brown", description: "Vitae suscipit tellus mauris", email: "bob@example.com")
user_c = User.create(name: "Carol Clark", description: "Viverra justo nec ultrices", email: "carol@example.com")
user_d = User.create(name: "Dave Davis", description: "Quis eleifend quam adipiscing", email: "dave@example.com")
user_e = User.create(name: "Eve Evans", description: "Lacus suspendisse faucibus interdum", email: "eve@example.com")
user_f = User.create(name: "Frank Franklin", description: "Etiam ut feugiat nibh", email: "frank@example.com")

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
```

Run:

```sh
bin/rails db:seed
```


## Administrate gem

Add to `Gemfile`:

```ruby
gem 'administrate'
```

Run:

```sh
bundle install
bin/rails generate administrate:install
```

The installer adds some new routes to your `config/routes.rb`.

The installer creates a controller at `app/controllers/admin/application_controller.rb`.

The generator creates routes in the file `config/routes.rb`:

```ruby
Rails.application.routes.draw do
  namespace :admin do
    resources :groups
    resources :users
    root to: "groups#index"
  end
  …
end
```

The generator creates a `Dashboard` and a `Controller` for each of your `ActiveRecord` resources:

```sh
app/controllers/admin/groups_controller.rb
app/controllers/admin/users_controller.rb
app/dashboards/group_dashboard.rb
app/dashboards/user_dashboard.rb
```

The file `app/dashboards/user_dashboard.rb`:

```ruby
require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    groups: Field::HasMany,
    id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    name: Field::String,
    description: Field::String,
    email: Field::String,
    encrypted_password: Field::String,
    reset_password_token: Field::String,
    reset_password_sent_at: Field::DateTime,
    remember_created_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    groups
    id
    created_at
    updated_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    groups
    id
    created_at
    updated_at
    name
    description
    email
    encrypted_password
    reset_password_token
    reset_password_sent_at
    remember_created_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    groups
    name
    description
    email
    encrypted_password
    reset_password_token
    reset_password_sent_at
    remember_created_at
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how users are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(user)
  #   "User ##{user.id}"
  # end
end
```

Visit `http://localhost:3000/admin` to see your new dashboard in action.


## Adminsitrate customization

The `Admin::ApplicationController` can be customized to add authentication logic, authorization, pagination, or other controller-level concerns.

The routes can be customized to show or hide different models on the dashboard.

Each dashboard specifies which attributes should be displayed. For example see file `app/dashboards/user_dashboard.rb` which defines class `UserDashboard`.

Each admin controller can be overwritten to specify custom behavior. For example see file `app/controllers/admin/users_controller.rb` and class `Admin::UsersController`.

The file `app/dashboards/user_dashboard.rb` defines the index page collection attributes here:

```
COLLECTION_ATTRIBUTES = %i[
  groups
  id
  created_at
  updated_at
].freeze
```

We change these to be:

```ruby
COLLECTION_ATTRIBUTES = %i[
  id
  name
  groups
].freeze
```

We edit `SHOW_PAGE_ATTRIBUTES` and `FORM_ATTRIBUTES` to move `groups` to the bottom of the array, because we prefer to see the user's information before the user's groups.

The file `app/dashboards/gropu_dashboard.rb` defines the index page collection attributes here:

```
COLLECTION_ATTRIBUTES = %i[
  users
  id
  created_at
  updated_at
].freeze
```

We change these to be:

```ruby
COLLECTION_ATTRIBUTES = %i[
  id
  name
  users
].freeze
```

We edit `SHOW_PAGE_ATTRIBUTES` and `FORM_ATTRIBUTES` to move `users` to the bottom of the array, because we prefer to see the groups's information before the groups's users.
