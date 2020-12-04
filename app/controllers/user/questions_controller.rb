class User::QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_question, only: [:show, :edit, :update, :destroy]
  before_action :search_method, only: [:solution_index]

  def index
    @question = Question.all
  end

  def show
    @question_comment = Comment.new
    @question_comments = @question.comments.order(created_at: :desc)
  end
  
  def solution_index
    @categories = Category.all
    @timeline = Question.where(solution_flag: false).order(created_at: :desc)
  end

  def edit
    @categories = Category.all
  end

  def new
    @question = Question.new
    @categories = Category.all
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    if @question.save
      redirect_to questions_path(@question), notice: '投稿に成功しました'
    else
      flash.now[:alert] = '入力に不備があります'
      render 'new'
    end
  end

  def update
    if @question.update(question_params)
      if @question.solution_flag == true
        @question.update(status: '質問/解決済み')
      elsif @question.solution_flag == false
        @question.update(status: '質問')
      end
      redirect_to question_path(@question), notice: '更新に成功しました'
    else
      flash.now[:alert] = '入力に不備があります'
      render 'questions/edit'
    end
  end

  def destroy
    if @question.destroy
      redirect_to questions_path, notice: '削除に成功しました'
    else
      redirect_to questions_path, alert: '削除できませんでした'
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :image, :solution_flag, :category_id, :status)
  end

  def find_question
    @question = Question.find(params[:id])
  end
end
