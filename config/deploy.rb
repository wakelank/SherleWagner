lock '3.4.0'

set :application, 'SherleWagner'
set :repo_url, 'git@github.com:wakelank/SherleWagner.git'
set :deploy_to, -> { "/home/#{fetch(:user)}/rails_apps/#{fetch(:application)}" }
