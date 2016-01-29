set(:user, 'rails')
ask(:password, nil, echo: false)

options, password = {}, fetch(:password)
options[:password] = password unless password.nil?
server 's18892809.onlinehome-server.com', options.merge(user: fetch(:user), roles: %w{app db web})
