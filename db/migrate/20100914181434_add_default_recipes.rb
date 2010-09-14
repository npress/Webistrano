class AddDefaultRecipes < ActiveRecord::Migration
  def self.up
    
    Recipe.create(:name=>"status", 
    :description =>"Return the process running on each server.",
    :body=> "task :status do\n run \"ps aux\"\n end", 
    :version=>1, 
    :role_needed=>false)
    
    Recipe.create(:name=>"server", 
    :description=>"Display a quick status of the server listed.",
    :body=> "task :server do\n puts \"Displaying the status of the server.\"\nend" , 
    :version=>1, 
    :role_needed=>false)
    
    Recipe.create(:name=>"serverreport", 
    :description=>"If no <ip_list> is specified, all servers will be displayed. Display a deep "+
    "report of server settings.",
    :body=> "task :server do\n puts \"Displaying deep report of server settings.\"\n end" , 
    :version=>1, 
    :role_needed=>false)
    
    Recipe.create(:name=>"restartserver", 
    :description=>"Reboot all the game servers.  If no <ip_list> is specified, all game servers will "+
    "be rebooted.",
    :body=> "task :restartserver do\n puts \"Rebooting game servers.\"\n end" , 
    :version=>1, 
    :role_needed=>false)
    
    Recipe.create(:name=>"restartwebserver", 
    :description=>"Reboot all web servers.  If no <ip_list>, all servers will be displayed.",
    :body=> "task :restartwebserver do\n puts \"Rebooting game servers.\"\n end" , 
    :version=>1, 
    :role_needed=>false)
    
    Recipe.create(:name=>"db", 
    :description=>"Display a report of database server listed.  List of dbs, and size of dbs. "+ 
    "If no <ip_list>, all db servers will be displayed.",
    :body=> "task :db do\n puts \"Displaying report of db servers.\"\n end" , 
    :version=>1, 
    :role_needed=>false)
    
    Recipe.create(:name=>"dbbackup", 
    :description=>"On the database servers, using script ~/backups/auto_backup_mysql.sh, back up "+
    "the database in ~backups/mysql_backups/latest/ and a copy in ~/backups/deploymentbackup/",
    :body=> "task :dbbackup do \nputs \"Reading ~/backups/auto_backup_mysql.sh.\"
    puts \"backing up the database in ~backups/mysql_backups/latest/\"
    puts \"copying into ~/backups/deploymentbackup/\" \nend" , 
    :version=>1, 
    :role_needed=>false)
    
    Recipe.create(:name=>"statusslave", 
    :description=>"Display the status of the MySQL replication slaves and information about their "+
    "configuration and last error.",
    :body=> "task :statusslave do\n puts \"Displaying the status of the MySQL replication slaves "+
    "and information. \nend", 
    :version=>1, 
    :role_needed=>false)
    
    Recipe.create(:name=>"startslave", 
    :description=>"If no <slave> is specified, it will apply on all slaves if <slave> is specified, "+
    "it will apply to the slave <slave>. Start the replication process on the slave server",
    :body=> "task :startslave do\n puts \"Restarting replication process on the slave server(s)\"\nend" , 
    :version=>1, 
    :role_needed=>false)
    
    Recipe.create(:name =>"stopslave", 
                  :description =>"If no <slave> is specified, it will apply on all slaves. If <slave> is specified it will apply to the slave <slave>. Start the replication process on the slave server.",
                  :body => "task :stopslave do \nputs \"Restarting replication process on the slave server(s) \" \end" , 
                  :version =>1, 
                  :role_needed=>false)
    
    Recipe.create(:name=>"fillslave", 
    :description=>"The argument <slave> is required.  Copy and unzip the latest backups of the "+
    "master databases on the slave server (daily backup or latest in case of more recent backups). "+
    "Retrieve the commented replication configuration from the file (log file and position), stop "+
    "the replication, import the databases backup, reconfigure the replication with the new "+
    "configuration.  Restart the slave.",
    :body=> "task :stopslave do \nputs \"Restarting replication process on the slave server(s) \" \end" , 
    :version=>1, 
    :role_needed=>true)
    
    Recipe.create(:name=>"cdndeploy", 
    :description=>"Upload the files from ~releases_storage/client_stage or ~/releases_storage/client_prod to the CDN.",
    :body=> "task :cdndeploy do \nputs \"Uploading the files from ~releases_storage/client_stage or "+
    "~/releases_storage/client_prod to the CDN\"\nend", 
    :version=>1, 
    :role_needed=>false)
    
  end

  def self.down
#    Recipe.find_by_name("status").destroy
#    Recipe.find_by_name("server").destroy
#    Recipe.find_by_name("serverreport").destroy
#    Recipe.find_by_name("restartserver").destroy
#    Recipe.find_by_name("restartwebserver").destroy
#    Recipe.find_by_name("db").destroy
#    Recipe.find_by_name("dbbackup").destroy
#    Recipe.find_by_name("statusslave").destroy
#    Recipe.find_by_name("startslave").destroy
#    Recipe.find_by_name("stopslave").destroy
#    Recipe.find_by_name("fillslave").destroy
#    Recipe.find_by_name("cdndeploy").destroy
    
  end
end
