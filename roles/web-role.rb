name "web-role"
description "Nginx with Upstream pool of AppServers"
run_list "recipe[nginx]"
env_run_lists "Chef-dev" => ["recipe[nginx]"], "_default" => ["recipe[nginx]"]
