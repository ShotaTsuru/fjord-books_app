# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]
  before_action :user_only_contributor, only: %i[edit update destroy]

  def create
    if params[:book_id]
      @book = Book.find(params[:book_id])
      @comment = @book.comments.build(comment_params)
      @comment.user = current_user
      @comments = @book.comments.order(:id)
      @article = @comment.commentable
      if @comment.save
        redirect_to book_path(@book), notice: t('controllers.common.notice_create', name: Comment.model_name.human)
      else
        render 'books/show', status: :unprocessable_entity
      end
    elsif params[:report_id]
      @report = Report.find(params[:report_id])
      @comment = @report.comments.build(comment_params)
      @comment.user = current_user
      @comments = @report.comments.order(:id)
      @article = @comment.commentable
      if @comment.save
        redirect_to report_path(@report), notice: t('controllers.common.notice_create', name: Comment.model_name.human)
      else
        render 'reports/show', status: :unprocessable_entity
      end
    end
  end

  def edit
    @article = @comment.commentable
  end

  def update
    @comment.update(comment_params)
    redirect_to polymorphic_path(@comment.commentable)
  end

  def destroy
    @comment.destroy
    if params[:book_id]
      @book = Book.find(params[:book_id])
      redirect_to book_path(@book)
    elsif params[:report_id]
      @report = Report.find(params[:report_id])
      redirect_to report_path(@report)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def user_only_contributor
    redirect_to polymorphic_path(@comment.commentable) unless @comment.user == current_user
  end
end
