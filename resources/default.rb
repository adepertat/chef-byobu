actions :enable, :disable

default_action :enable

attribute :user, :kind_of => String, :required => true
attribute :backend, :kind_of => String, :default => 'tmux'
