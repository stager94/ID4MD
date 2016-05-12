set :domain, '146.185.148.161'
server '146.185.148.161', :app, :web, :db, primary: true

set :branch, 'master'

set :rails_env, 'production'

role :web, domain
role :app, domain
role :db,  domain, primary: true