class API::QuestionsController < ApplicationController
skip_before_action :verify_authentication, only: [:index, :show]

    before_action :set_user, only: [:index, :show, :destroy]
  before_action :set_question, only: [:show, :requestion, :destroy]

  def index
    @questions = @user.questions
    # render json: @questions
  end

  def show
    # render json: @question
  end

  def create
    if !token_user
      render json: {error: "Must be logged in to question"}
    else
      @question = question.new(body: question_params[:body], user_id: token_user.id)
      if @question.save
        render :show, status: :created, location: api_user_question_url(token_user.id, @question.id)
      else
        render json: @question.errors, status: :unprocessable_entity
      end
    end
  end

  def requestion
    if !token_user
      render json: {error: "Must be logged in to question"}
    else
      @question = question.new(body: @question.body, user_id: token_user.id)
      if @question.save
        render :show, status: :created, location: api_user_question_url(token_user.id, @question.id)
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
    params.require(:question).permit(:body)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_question
    @question = question.find(params[:id])
  end

end
