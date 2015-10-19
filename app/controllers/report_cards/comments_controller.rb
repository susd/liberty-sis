module ReportCards
  class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!
    before_action :set_form
    
    def index
      @comments = comments_scope.all
    end
    
    def edit
      @comment = comments_scope.find(params[:id])
    end
    
    def update
      @comment = comments_scope.find(params[:id])
      
      if @comment.update(comment_params)
        redirect_to report_cards_form_comments_path(@form), notice: 'Comment updated.'
      else
        render :edit
      end
    end
    
    private
    
    def comments_scope
      @form.comments.includes(:comment_group).order(:comment_group_id)
    end
    
    def comment_params
      params.require(:comment).permit(:english, :spanish, :comment_group_id)
    end
    
    def set_form
      @form = Form.find(params[:form_id])
    end
    
  end
end