class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  # GET /answers
  def index
    @answers = Answer.all
  end

  # GET /answers/1
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers
  def create
    @answer = Answer.new(answer_params)
      if @answer.save
        UserMailer.with(user: @answer.question.user, url: question_url(@answer.question, anchor: 'answer_' + @answer.id.to_s)).alert_email.deliver_now
        redirect_to @answer.question, notice: 'Answer was successfully created.'
      else      
        redirect_to @answer.question
      end 
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    if (answer_params[:question_accepted_id] != nil && Answer.exists?(question_accepted_id: answer_params[:question_accepted_id]))
      redirect_to @answer.question
    else
      if @answer.update({question_accepted_id: nil}.merge(answer_params))
        redirect_to @answer.question, notice: 'Answer was successfully updated.'
      else
        redirect_to @answer.question
      end
    end
  end



  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    redirect_to @question, notice: 'Answer was successfully destroyed.'
  end

  private


  # Use callbacks to share common setup or constraints between actions.
  def set_answer
    @answer = Answer.find(params[:id])
    @question = @answer.question
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def answer_params
    params.permit(:body, :user_id, :question_id, :question_accepted_id)
  end
end
