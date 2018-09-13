class API::QuestionsController < ApplicationController
  skip_before_action :verify_authentication, only: [:index, :show]

  before_action :set_question, only: [:show, :destroy]

  def index
    @questions = Question.order('created_at DESC').page(params[:page]).per(10)
  end

  def show
  end

  def create
    if !token_user
      render json: {error: "Must be logged in to question"}, status: :unprocessable_entity
    else
      @question = Question.new(title: question_params[:title], body: question_params[:body], user_id: token_user.id)
      if @question.save
        render :show, status: :created, location: api_question_url(@question.id)
      else
        render json: @question.errors, status: :unprocessable_entity
      end
    end
  end

  def destroy
    if token_user.id != @user.id
      render json: {error: "Must be the user to Delete This question"}
    else
      @question.destroy
      render json: @user.questions
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_question
    @question = Question.find(params[:id])
    @user = @question.user
  end

end
