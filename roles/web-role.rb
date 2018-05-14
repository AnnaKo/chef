name "web-role"
description "Nginx with Upstream pool of AppServers"
run_list "recipe[web]"
env_run_lists "Chef-dev" => ["recipe[web]"], "_default" => ["recipe[web]"]
