# frozen_string_literal: true

# See https://docs.getchef.com/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)

ssl_verify_mode          :verify_none
log_level                :info
log_location             STDOUT
node_name                'skutsuza'
client_key               ENV['CHEF_CLIENT_KEY']
chef_server_url          ENV['CHEF_SERVER_URL']
cookbook_path            [current_dir]

knife[:vault_mode] = 'client' 
