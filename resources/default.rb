actions :enable, :disable

default_action :enable

attribute :user, :kind_of => String, :name_attribute => true, :required => true
attribute :backend, :kind_of => String, :default => 'tmux'
