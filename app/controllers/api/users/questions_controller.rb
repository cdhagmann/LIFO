class API::Users::QuestionsController < ApplicationController
  before_action :set_user, only: [:index, :show]
  before_action :set_question, only: [:show]

  def index
    @questions = Question.where("user_id=?",@user.id).page(params[:page]).per(10)
  end

  def show
  end

    private

  def question_params
    params.require(:question).permit(:body)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
