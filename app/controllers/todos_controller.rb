class TodosController < ApplicationController
  before_filter :require_user
  # GET /todos
  # GET /todos.xml
  def index
    wants = request.format
    if wants.json? || wants.xml?
      @todos = Todo.all(:order => 'updated_at DESC', :conditions=>{:user_id => current_user.id})
    else
      @todos = Todo.paginate(:page => params[:page], :order => 'updated_at DESC', :conditions=>{:user_id => current_user.id})
    end
    @unfinished_todos = Todo.unfinished_todos(current_user.id)
    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @todos }
      format.json  { render :json => @todos }
    end
  end
  
  def search
    wants = request.format
    pages = {
      :page     => params[:page] ? params[:page] : 1 ,
      :per_page => 10
    }
    
    scope = Todo
    scope = scope.filter_own_todos(current_user.id)
    scope = scope.search(params[:query]) unless params[:query].blank?
    if wants.json? || wants.xml?
      @todos = scope
    else
      @todos = scope.paginate(pages)
      @unfinished_todos = scope.unfinished_todos(current_user.id)
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @todos }
      format.json  { render :json => @todos }
    end
  end
  
  def update_todo_status
    @todo = Todo.find(params[:todo_id])
    @todo.completed = params[:status]
    @unfinished_todos = Todo.unfinished_todos(current_user.id)
    if @todo.save
      render :text => "#{@unfinished_todos.count}-#{@unfinished_todos.sum('expected_duration')}".to_s
    else
      render :text => 'Error'
    end
  end

  # GET /todos/new
  # GET /todos/new.xml
  def new
    @todo = Todo.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @todo }
    end
  end

  # GET /todos/1/edit
  def edit
    @todo = Todo.find(params[:id])
  end

  # POST /todos
  # POST /todos.xml
  def create

    @todo = current_user.todos.build(params[:todo])

    respond_to do |format|
      if @todo.save
        format.html { redirect_to(:todos, :notice => 'Todo was successfully created.') }
        format.xml  { render :xml => @todo, :status => :created, :location => @todo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @todo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /todos/1
  # PUT /todos/1.xml
  def update
    @todo = Todo.find(params[:id])
    @todo.user_id = current_user.id

    respond_to do |format|
      if @todo.update_attributes(params[:todo])
        format.html { redirect_to(:todos, :notice => 'Todo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @todo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.xml
  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to(todos_url) }
      format.xml  { head :ok }
    end
  end
end
