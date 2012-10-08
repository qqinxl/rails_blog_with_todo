class Admin::Todo::TagsController < Admin::ApplicationController

  # POST /admin/todo/tags
  def create
    @admin_todo_tag = Admin::Todo::Tag.new(params[:admin_todo_tag])
    @admin_todo_tag.user = current_user

    if @admin_todo_tag.save
      render :json => @admin_todo_tag.to_json
    else
      render :json => {:errors => @admin_todo_tag.errors.full_messages}
    end
    
  end
  
  # DELETE /admin/todo/tags/1
  # DELETE /admin/todo/tags/1.json
  def destroy
    @admin_todo_tag = Admin::Todo::Tag.find(params[:id])
    @admin_todo_tag.destroy

    head :no_content
  end
end
