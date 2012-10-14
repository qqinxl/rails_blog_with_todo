class Admin::Todo::ListsController < Admin::ApplicationController
 
  before_filter :get_todo_tags
  
  # GET /admin/todo/lists
  # GET /admin/todo/lists.json
  def index
    # @admin_todo_lists = Admin::Todo::List.all
    @admin_todo_lists = Admin::Todo::List.paginate(:per_page => 10, :page => params[:page])
    @admin_todo_lists.each{|e|
      e.tag = @admin_todo_tag_map[e.todo_tag_id] 
    }
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json=> @admin_todo_lists.to_json(:include => :tag) }
    end
  end

  # GET /admin/todo/lists/1
  # GET /admin/todo/lists/1.json
  def show
    @admin_todo_list = Admin::Todo::List.find(params[:id])

    if @admin_todo_list 
      @admin_todo_list.tag = @admin_todo_tag_map[@admin_todo_list.todo_tag_id] 
      render :json => {:data => @admin_todo_list.to_json(:include => :tag)}
    else
      render :json => {:errors => "There is no data."}
    end
  end

  # GET /admin/todo/lists/1/edit
  def edit
    @admin_todo_list = Admin::Todo::List.find(params[:id])
    @admin_todo_list.tag = @admin_todo_tag_map[@admin_todo_list.todo_tag_id] 
  end

  # POST /admin/todo/lists
  # POST /admin/todo/lists.json
  def create
    @admin_todo_list = Admin::Todo::List.new(params[:admin_todo_list])
    @admin_todo_list.user = current_user
    #@admin_todo_list.tag = @admin_todo_tag_map[params[:admin_todo_list][:todo_tag_id]] 
    
    if @admin_todo_list.save
      render :json => {:data => @admin_todo_list.to_json}
    else
      render :json => {:errors => @admin_todo_list.errors.full_messages, :data => @admin_todo_list.to_json}
    end
  end

  # PUT /admin/todo/lists/1
  # PUT /admin/todo/lists/1.json
  def update
    @admin_todo_list = Admin::Todo::List.find(params[:id])
    @admin_todo_list.tag = @admin_todo_tag_map[@admin_todo_list.todo_tag_id] 
    
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

  # GET /admin/todo/done/1
  def done
    @admin_todo_list = Admin::Todo::List.find(params[:id])

    if @admin_todo_list.update_attribute(:completed_at, DateTime.now) 
      render :json => {:data => @admin_todo_list.to_json}
    else
      render :json => {:errors => @admin_todo_list.errors.full_messages, :data => @admin_todo_list.to_json} 
    end
  end

  # DELETE /admin/todo/lists/1
  def destroy
    @admin_todo_list = Admin::Todo::List.find(params[:id])

    if @admin_todo_list.update_attribute(:deleted_at, DateTime.now) 
      render :json => {:data => @admin_todo_list.to_json}
    else
      render :json => {:errors => @admin_todo_list.errors.full_messages, :data => @admin_todo_list.to_json} 
    end
  end
  
  private 
  def get_todo_tags    
    @admin_todo_tags = Admin::Todo::Tag.all
    @admin_todo_tag_map = @admin_todo_tags.inject(Hash.new(0)){|map, e| map.store(e.id , e); map}
    @admin_todo_tag_names = @admin_todo_tags.inject(Hash.new(0)){|map, e| map.store(e.name , e.id); map}
    @admin_todo_tags_exist = Admin::Todo::List.select(:todo_tag_id).uniq
    
    
    @admin_todo_tag = Admin::Todo::Tag.new
    @admin_todo_tag.user = current_user
    @admin_todo_list = Admin::Todo::List.new
    @admin_todo_list.user = current_user
  end
end
