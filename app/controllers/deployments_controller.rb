class DeploymentsController < ApplicationController
  
  before_filter :load_stage
  before_filter :ensure_deployment_possible, :only => [:new, :create]
  
  # GET /projects/1/stages/1/deployments
  # GET /projects/1/stages/1/deployments.xml
  def index
    @deployments = @stage.deployments

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @deployments.to_xml }
    end
  end

  # GET /projects/1/stages/1/deployments/1
  # GET /projects/1/stages/1/deployments/1.xml
  def show
    @deployment = @stage.deployments.find(params[:id])
    set_auto_scroll
    
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @deployment.to_xml }
      format.js { render :partial => 'status.html.erb' }
    end
  end

  # GET /projects/1/stages/1/deployments/new
  def new
    @deployment = @stage.deployments.new
    @deployment.task = params[:task]
    #if the recipe selected for deployment has a server_type that has no roles
    #propage roles
    propagate_roles_needed(@deployment.task)
    if params[:repeat]
      @original = @stage.deployments.find(params[:repeat])
      @deployment = @original.repeat
    end
  end

  # POST /projects/1/stages/1/deployments
  # POST /projects/1/stages/1/deployments.xml
  def create
    @deployment = Deployment.new
    
    respond_to do |format|
      if populate_deployment_and_fire
        
        @deployment.deploy_in_background!

        format.html { redirect_to project_stage_deployment_url(@project, @stage, @deployment)}
        format.xml  { head :created, :location => project_stage_deployment_url(@project, @stage, @deployment) }
      else
        @deployment.clear_lock_error
        format.html { render :action => "new" }
        format.xml  { render :xml => @deployment.errors.to_xml }
      end
    end
  end

  # GET /projects/1/stages/1/deployments/latest
  def latest
    @deployment = @stage.deployments.find(:first, :order => "created_at desc")

    respond_to do |format|
      format.html { render :action => "show"}
      format.xml do
        if @deployment
          render :xml => @deployment.to_xml
        else
          render :status => 404, :nothing => true
        end
      end
    end
  end
  
  # POST /projects/1/stages/1/deployments/1/cancel
  def cancel
    redirect_to "/" and return unless request.post?
    @deployment = @stage.deployments.find(:first, :order => "created_at desc")

    respond_to do |format|
      begin
        @deployment.cancel!
        
        flash[:notice] = "Cancelled deployment by killing it"
        format.html { redirect_to project_stage_deployment_url(@project, @stage, @deployment)}
        format.xml  { head :ok }
      rescue => e
        flash[:error] = "Cancelling failed: #{e.message}"
        format.html { redirect_to project_stage_deployment_url(@project, @stage, @deployment)}
        format.xml  do
          @deployment.errors.add("base", e.message)
          render :xml => @deployment.errors.to_xml 
        end
      end
    end
  end
  
  protected
  #propagate_roles_needed takes a task_name that defines the recipe
  #the deployment will execute
  def propagate_roles_needed(task_name) 
    
    #All recipes besides server have the same name in their body; thus task_name usually is
    #Recipe.name.  However, if you are executing a task that appears
    #as 'server_display' in the dropdown menu, it is actually named 'server' in the 
    #recipes and in the database.
    if(task_name!="server_display")
      recipe_to_run=Recipe.find_by_name(task_name) 
    else 
      recipe_to_run = Recipe.find_by_name("server")
      if !recipe_to_run.role_needed then
      #Check if the recipe chosen to run on this deployment is a predefined recipe
      #that does not require a parameter, i.e. a specific ip_address list.
      #check to see that current_stage has all roles needed for the recipes it has,
      #otherwise propagate them.
      recipe_types = recipe_to_run.server_types  #aggregating the server_types for all recipes in this stage
      recipe_types.each{|t| 
      if !current_stage.roles.map{|r|r.name}.include?(t.name)then
          
              #propagate a role for every host that fits type t:
              t.hosts.each do |h|
                      if(t.name=="db")
                        @role = current_stage.roles.build({"no_release"=>"0", "name"=>t.name, "primary"=>"1", "ssh_port"=>"", "no_symlink"=>"0", "host_id"=>h.id})
                      else
                        @role = current_stage.roles.build({"no_release"=>"0", "name"=>t.name, "primary"=>"0", "ssh_port"=>"", "no_symlink"=>"0", "host_id"=>h.id})
                      end
                      if(!@role.save)
                        RAILS_DEFAULT_LOGGER.error("could not save the given role #{t.name} on host #{h.name}");
                      end
              end
           
           end
      
      }
    end    
    end
  end
  
  
  
  def ensure_deployment_possible
    if current_stage.deployment_possible? then
        
        true
    else
      if (current_stage.deployment_problems.include?(:roles)&& 
        current_stage.deployment_problems.size==1) then
        
        role_necessary=current_stage.recipes.find(:all, :select=>:role_needed)
        
        if role_necessary.map{|r|r.role_needed}.include?(false)
          
          #assign all servers to the role of app server
          #render :text=> "You chose a prefabbed recipe."
          current_stage.recipes.all.each  do |cmd|
           s_type = cmd.server_types.find(:all)
           s_type.each do |t|
              
              t.hosts.each do |h|
                if(t.name=="db")
                  @role = current_stage.roles.build({"no_release"=>"0", "name"=>t.name, "primary"=>"1", "ssh_port"=>"", "no_symlink"=>"0", "host_id"=>h.id})
                else
                  @role = current_stage.roles.build({"no_release"=>"0", "name"=>t.name, "primary"=>"0", "ssh_port"=>"", "no_symlink"=>"0", "host_id"=>h.id})
                end
                if(!@role.save)
                  puts "could not save the given role #{t.name} on host #{h.name}"
                end
              end
           end
         end
         return true
         
        
      end
      end
      respond_to do |format|  
        flash[:error] = 'A deployment is currently not possible.'
        format.html { redirect_to project_stage_url(@project, @stage) }
        format.xml  { render :xml => current_stage.deployment_problems.to_xml }
        false
      end
      
    end
  end
  
  def set_auto_scroll
    if params[:auto_scroll].to_s == "true"
      @auto_scroll = true
    else
      @auto_scroll = false
    end
  end
  
  # sets @deployment
  def populate_deployment_and_fire
    return Deployment.lock_and_fire do |deployment|
      @deployment = deployment
      @deployment.attributes = params[:deployment]
      @deployment.prompt_config = params[:deployment][:prompt_config] rescue {}
      @deployment.stage = current_stage
      @deployment.user = current_user
    end
  end
  
end
