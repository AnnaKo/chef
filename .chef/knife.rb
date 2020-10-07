current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "akouser"
client_key               "#{current_dir}/admin.pem"
validation_client_name   "akoorg-validator"
validation_key           "#{current_dir}/akoorg-validator.pem"
chef_server_url          "https://chefserver/organizations/akoorg"
syntax_check_cache_path  "#{ENV['HOME']}/.chef/syntaxcache"
cookbook_path            ["#{current_dir}/../cookbooks"]
