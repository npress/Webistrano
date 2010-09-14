class AddDefaultRecipes < ActiveRecord::Migration
  def self.up
     Recipe.create(:name=>"status",
    :description=>"Return the process running on each server.",
    :body=>"task :status do\n run \"ps aux\"\nend", :version=>1);
    Recipe.create(:name =>"server",
    :description => "Display a quick status of the server listed.",
    :body=> "task :server do\n puts \"Displaying the status of the server.\"\nend",
    :version=>1);
    Recipe.create(:name =>"serverreport",
    :description => "If no <ip_list> is specified, all servers will be displayed.\n
    Display a deep report of server settings.",
    :body=> "task :server do\n puts \"Displaying deep report of server settings.\"\nend", 
    :version=>1);
    Recipe.create(:name =>"restartserver",
    :description => "Reboot all the game servers.\n
    If no <ip_list> is specified, all game servers will be rebooted.",
    :body=> "task :server do\n puts \"Rebooting game servers.\"\nend", 
    :version=>1);
    Recipe.create(:name => "restartwebserver", 
    :description => "Reboot all game servers.\n
    If no <ip_list>, all servers will be displayed.",
    :body => "task :restartwebserver do\n puts \"Rebooting webservers.\"\n end",
    :version=> 1);
    Recipe.create(:name => "db", 
    :description => "Display a report of database server listed.\n
    List of dbs, and size of dbs\n
    If no <ip_list>, all db servers will be displayed.",
    :body => "task :db do\n puts \"Displaying report of db servers.\"\n end",
    :version=> 1);
    Recipe.create(:name => "dbbackup", 
    :description => "On the database servers, using script 
    ~/backups/auto_backup_mysql.sh, back up the database in 
    ~backups/mysql_backups/latest/\n
    and a copy in ~/backups/deploymentbackup/",
    :body => "task :dbbackup do\n puts \"Reading 
    ~/backups/auto_backup_mysql.sh. \"
    puts \"backing up the database in 
    ~backups/mysql_backups/latest/\"
    puts\"copying into ~/backups/deploymentbackup/\"\n end",
    :version=> 1);
    Recipe.create(:name => "statusslave", 
    :description => "Display the status of the MySQL replication slaves and information
    about their configuration and last error.",
    :body => "task :statusslave do\n puts \"Displaying the status of the MySQL 
    replication slaves and information.\"\n end",
    :version=> 1);
    Recipe.create(:name => "startslave", 
    :description => "If no <slave> is specified, it will apply on all slaves 
    if <slave> is specified, it will apply to the slave <slave>. 
    Start the replication process on the slave server",
    :body => "task :startslave do\n puts \"Restarting replication process on the slave server(s) \"\n end",
    :version=> 1);
    Recipe.create(:name => "stopslave", 
    :description => "If no <slave> is specified, it will apply on all slaves \
    if <slave> is specified, it will apply to the slave <slave>.  \
    Start the replication process on the slave server",
    :body => "task :stopslave do\n puts \"Restarting replication process on the slave server(s) \"\n end",
    :version=> 1);
    Recipe.create(:name => "fillslave", 
    :description => "The argument <slave> is required.  Copy and unzip the latest \
    backups of the master databases on the slave server (daily backup or latest in \
    case of more recent backups).   Retrieve the commented replication configuration \
    from the file (log file and position), stop the replication, import the \
    databases backup, reconfigure the replication with the new configuration. \
    Restart the slave.",
    :body => "task :startslave do\n puts \"Copying and unzipping the latest \
    backups of the master databases on the slave server.\" 
    puts \"Retrieving the commented replication configuration from the file (log file and position)\"
    puts \"Stopping the replication.\"
    puts \"Importing the database backup.\"
    puts \"Reconfiguring the replication with the new configuration\"
    puts \"Restarting the slave.\"
    end",
    :version=> 1);
    Recipe.create(:name => "cdndeploy", 
    :description => "Upload the files from ~releases_storage/client_stage or \
    ~/releases_storage/client_prod to the CDN.",
    :body => "task :cdndeploy do\n puts \"Uploading the files from \
    ~releases_storage/client_stage \"\n end",
    :version=> 1);
   
  end

  def self.down
    Recipe.find_by_name("status").destroy
    Recipe.find_by_name("server").destroy
    Recipe.find_by_name("serverreport").destroy
    Recipe.find_by_name( "restartserver").destroy
    Recipe.find_by_name( "restartwebserver").destroy
    Recipe.find_by_name( "db").destroy
    Recipe.find_by_name( "dbbackup").destroy
    Recipe.find_by_name( "statusslave").destroy
    Recipe.find_by_name( "startslave").destroy
    Recipe.find_by_name("stopslave").destroy
    Recipe.find_by_name("fillslave").destroy
    Recipe.find_by_name("cdndeploy").destroy
  end
end
