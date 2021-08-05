class CommentsController < ApplicationController
  def create
    if params[:book_id]
      @book = Book.find(params[:book_id])
      @comment = @book.comments.build(comment_params)
      @comments = @book.comments
      respond_to do |format|
        if @comment.save
          format.html { redirect_to book_path(@book), notice: "Comment was successfully created." }
          format.json { render :show, status: :created, location: @book }
        else
          format.html { render 'books/show', status: :unprocessable_entity }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    elsif params[:report_id]
      @report = Report.find(params[:report_id])
      @comment = @report.comments.build(comment_params)
      @comments = @report.comments
      respond_to do |format|
        if @comment.save
          format.html { redirect_to report_path(@report), notice: "Comment was successfully created." }
          format.json { render :show, status: :created, location: @report }
        else
          format.html { render 'reports/show', status: :unprocessable_entity }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @article = @comment.commentable
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    redirect_to  polymorphic_path(@comment.commentable)
  end

  def destroy
    @comment = Comment.find(params[:id])
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
    params.require(:comment).permit(:text).merge(user_id: current_user.id)
  end
end
