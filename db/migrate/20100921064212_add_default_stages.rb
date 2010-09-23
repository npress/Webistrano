class AddDefaultStages < ActiveRecord::Migration
  def self.up
    p=Project.find_by_name("Deployment")
    p.stages<<Stage.create(:name=>"sgplatform", :alert_emails=>"development@sleepygiant.com sys_admins@sleepygiant.com")
    p.stages<<Stage.create(:name=>"game content", :alert_emails=>"development@sleepygiant.com sys_admins@sleepygiant.com")
    p.stages<<Stage.create(:name=>"infrastructure tools", :alert_emails=>"development@sleepygiant.com sys_admins@sleepygiant.com")
    p.stages<<Stage.create(:name=>"CDN content", :alert_emails=>"development@sleepygiant.com sys_admins@sleepygiant.com")
       
  end

  def self.down
    Stage.find_by_name("sgplatform").destroy
    Stage.find_by_name("game content").destroy
    Stage.find_by_name("infrastructure tools").destroy
    Stage.find_by_name("CDN content").destroy
  end
end
