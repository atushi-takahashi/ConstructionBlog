class Admins::QuestionsController < ApplicationController
  before_action :find_question, only: [:show, :update]
  
  def index
  end

  def show
  end

  def update
    @question.update(question_params)
    if @question.delete_flag == true
      flash[:notice] = "記事を非表示にしました"
      redirect_back(fallback_location: root_path)
    elsif @question.delete_flag == false
      flash[:notice] = "記事を表示しました"
      redirect_back(fallback_location: root_path)
    end
  end
  
  private
  def find_question
    @question = Question.find(params[:id])
  end
  def question_params
    params.permit(:delete_flag)
  end
end
