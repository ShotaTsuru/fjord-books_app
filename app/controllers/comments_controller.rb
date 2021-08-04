class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @book = Book.find(params[:book_id])
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
  end

  private
  def comment_params
    params.require(:comment).permit(:text)
  end
end
