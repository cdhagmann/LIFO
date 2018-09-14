class QuestionsController < ApplicationController
  skip_before_action :verify_authentication

  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  def index
    @questions = Question.order('created_at DESC').page(params[:page]).per(25)
  end

  # GET /questions/1
  def show
    @answers = Answer
                   .left_joins(:votes)
                   .group(:id)
                   .order('SUM(votes.value) DESC')
                   .where(question_id: @question.id)
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to @question, notice: 'Question was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    if @question.update(question_params)
      redirect_to @question, notice: 'Question was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    redirect_to questions_url, notice: 'Question was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def question_params
    params.require(:question).permit(:title, :body, :user_id)
  end
end
