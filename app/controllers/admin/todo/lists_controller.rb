class Admin::Todo::ListsController < Admin::ApplicationController
 
  before_filter :get_todo_tags
  
  # GET /admin/todo/lists
  # GET /admin/todo/lists.json
  def index
    @admin_todo_lists = Admin::Todo::List.all
         
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_todo_lists }
    end
  end

  # GET /admin/todo/lists/1
  # GET /admin/todo/lists/1.json
  def show
    @admin_todo_list = Admin::Todo::List.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_todo_list }
    end
  end

  # GET /admin/todo/lists/new
  # GET /admin/todo/lists/new.json
  def new
    @admin_todo_list = Admin::Todo::List.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_todo_list }
    end
  end

  # GET /admin/todo/lists/1/edit
  def edit
    @admin_todo_list = Admin::Todo::List.find(params[:id])
  end

  # POST /admin/todo/lists
  # POST /admin/todo/lists.json
  def create
    @admin_todo_list = Admin::Todo::List.new(params[:admin_todo_list])

    respond_to do |format|
      if @admin_todo_list.save
        format.html { redirect_to @admin_todo_list, notice: 'List was successfully created.' }
        format.json { render json: @admin_todo_list, status: :created, location: @admin_todo_list }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_todo_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/todo/lists/1
  # PUT /admin/todo/lists/1.json
  def update
    @admin_todo_list = Admin::Todo::List.find(params[:id])

    respond_to do |format|
      if @admin_todo_list.update_attributes(params[:admin_todo_list])
        format.html { redirect_to @admin_todo_list, notice: 'List was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_todo_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/todo/lists/1
  # DELETE /admin/todo/lists/1.json
  def destroy
    @admin_todo_list = Admin::Todo::List.find(params[:id])
    @admin_todo_list.destroy

    respond_to do |format|
      format.html { redirect_to admin_todo_lists_url }
      format.json { head :no_content }
    end
  end
  
  private 
  def get_todo_tags    
    @admin_todo_tags = Admin::Todo::Tag.all
    @admin_todo_tag = Admin::Todo::Tag.new
  end
end
