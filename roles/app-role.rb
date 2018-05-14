name "app-role"
description "AKO Tomcat sample WAR deploy"
run_list "recipe[jboss]"
env_run_lists "Chef-dev" => ["recipe[jboss]"], "_default" => ["recipe[jboss]"]
