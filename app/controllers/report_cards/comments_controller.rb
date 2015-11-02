module ReportCards
  class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!
    before_action :set_form
    helper_method :submit_path_for

    def index
      @comments = comments_scope.all
    end

    def new
      @comment = @form.comments.new
    end

    def edit
      @comment = comments_scope.find(params[:id])
    end

    def create
      @comment = @form.comments.new(comment_params)
      if @comment.save
        redirect_to report_cards_form_comments_path(@form), notice: 'Comment saved.'
      else
        render :new
      end
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
      @form.comments.includes(:comment_group).order(:report_card_comment_group_id)
    end

    def comment_params
      params.require(:report_card_comment).permit(:english, :spanish, :report_card_comment_group_id)
    end

    def set_form
      @form = ReportCard::Form.find(params[:form_id])
    end

    def submit_path_for(form, comment)
      if comment.new_record?
        report_cards_form_comments_path(form)
      else
        report_cards_form_comment_path(form, comment)
      end
    end

  end
end
