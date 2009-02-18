class ThoughtsController < ApplicationController
  
  before_filter :login_required
  after_filter :store_location, :only => [:index, :new, :show, :edit]

  # GET /thoughts
  # GET /thoughts.xml
  def index
    @user = User.find(current_user)
    @thoughts = @user.thoughts.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @thoughts }
      format.rss {
       @basesite = "http://thunk.herokugarden.com"
       headers["Content-Type"] = "application/xml"
       render :layout => false
      }
    end
  end

  # GET /thoughts/1
  # GET /thoughts/1.xml
  def show
    @thought = Thought.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @thought }
    end
  end

  # GET /thoughts/new
  # GET /thoughts/new.xml
  def new
    @thought = Thought.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @thought }
    end
  end

  # GET /thoughts/1/edit
  def edit
    @thought = Thought.find(params[:id])
  end

  # POST /thoughts
  # POST /thoughts.xml
  def create
    @thought = Thought.new(params[:thought])
    @thought.user_id = current_user.id

    respond_to do |format|
      if @thought.save
        flash[:notice] = "#{@thought.content} has been remembered."
        format.html { redirect_to :action => "new" }
        format.xml  { render :xml => @thought, :status => :created, :location => @thought }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @thought.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /thoughts/1
  # PUT /thoughts/1.xml
  def update
    @thought = Thought.find(params[:id])

    respond_to do |format|
      if @thought.update_attributes(params[:thought])
        flash[:notice] = 'Thought was successfully updated.'
        format.html { redirect_to(@thought) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @thought.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /thoughts/1
  # DELETE /thoughts/1.xml
  def destroy
    @thought = Thought.find(params[:id])
    @thought.destroy

    respond_to do |format|
      format.html { redirect_to(thoughts_url) }
      format.xml  { head :ok }
    end
  end
end
