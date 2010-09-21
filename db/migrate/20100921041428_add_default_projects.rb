class AddDefaultProjects < ActiveRecord::Migration
  def self.up
    Project.create(:name=>"Deployment", :description=>"Deployment is a non-Rails project using the Pure File template, which enables the user to run commands on remote machines.", :template=> "pure_file")
  end

  def self.down
    Project.find_by_name("Deployment").destroy
  end
end
