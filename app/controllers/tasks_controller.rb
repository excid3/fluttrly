class TasksController < ApplicationController
  protect_from_forgery :except => :sms
  before_filter :authenticate_user!, :only => [:public, :claim]
  #TODO: Redirect back if user not authenticated

  def home
    redirect_to index_path(params[:name].gsub(" ", "%20")) and return if params[:name]

    @total_tasks = Task.count
    @total_lists = Task.select("DISTINCT(name)").count
  end
 
  def features
  end

  def public
    @list = List.find_by_name(params[:name])
    @list.update_attribute(:public, !@list.public) if current_user.id == @list.user_id
  end

  def claim
    @list = List.find_or_create_by_name(params[:name])
    if not @list.nil? and @list.user_id
      # Remove it
      @list.update_attribute(:user_id, nil)
    else
      @list.update_attribute(:user_id, current_user.id)
    end
    
    redirect_to index_path(params[:name].gsub(" ", "%20"))
  end

  # GET /tasks
  # GET /tasks.xml
  def index
    #TODO: validate that params[:name] is a valid URL

    @list = List.where(["name = ?", params[:name]]).first

    # Check to make sure the list exists
    if not @list.nil? 

      # Its a private list
      if !@list.public and not @list.user_id.blank?

        if not user_signed_in?
          authenticate_and_redirect

        # Signed in but user doesn't own the list
        elsif @list.user_id != current_user.id 
          redirect_to(root_path, :notice => "You aren't allowed to access this list.") and return
        end

      end

      @tasks = @list.tasks.order("completed ASC, created_at DESC")

    else
      @tasks = []
    end

    # Initialize the defaults
    @task = Task.new
    @count = 0

    @tasks.each do |t|
      @count += 1 unless t.completed
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks  }
      format.json { render :json => @tasks }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    @list = List.where(["name = ?", params[:task][:name]]).first
    
    # List has never been created before
    if @list.nil?
      puts "Creating new list"
      @list = List.new({:name => params[:task][:name]})
      @list.user_id = current_user.id if user_signed_in? # Auto claim lists
      @list.save
    end
    @task = @list.tasks.new(params[:task])

    respond_to do |format|
      if @task.save
        format.html { redirect_to(index_path(params[:task][:name]), :notice => 'Task was successfully created.') }
        format.xml  { render :xml => @task, :status => :created, :location => @task  }
        format.json { render :json => @task, :status => :created, :location => @task }
        format.js
      else
        format.html { render :action => "new", :errors => "Task cannot be blank" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity  }
        format.json { render :json => @task.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = Task.find(params[:id])
    
    @task.update_attribute(:completed, params[:completed])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to(@task, :notice => 'Task was successfully updated.') }
        format.xml  { head :ok }
        format.json { head :ok }
        format.js
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity  }
        format.json { render :json => @task.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task = Task.find(params[:id])
    params[:completed] = @task.completed
    name = @task.name
    @task.destroy

    respond_to do |format|
      format.html { redirect_to(tasks_url) }
      format.xml  { head :ok }
      format.json { head :ok }
      format.js
    end
  end

  # recieve a text, parse it and send it to update
#  def sms
#    @name, @content = params[:Body].split(":", 2)
#    if not @name.nil? and @name != "" and not @content.nil? and @content != "" 
#      @content.strip!
#      
#      if @content.match(/^incomplete/)
#        @tasks = Task.where(["name = ? and completed = ?", @name, false]).order("created_at DESC")
#        @tasks = @tasks.collect{ |task| task.content }.join(". ")
#        render :action => "incomplete", :layout => false
#        return
#
#      else
#        task = Task.new({ :name => @name, :content => @content })
#        @success = task.save
#      end
#
#    else
#      @success = false
#    end
#    render :layout => false
#  end
end
