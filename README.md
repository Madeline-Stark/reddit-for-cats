User
username

Post
title 
content
user_id


User
has_many :posts


Post
belongs_to :user


C
new get '/posts/new'
create post '/posts'

R
index get '/posts'
show get '/posts/:id'

U
edit get '/posts/:id/edit'
update patch '/posts/:id'

D
delete delete '/posts/:id'

To dos
- finish create action
- make nested form
- validations
- custom helpers