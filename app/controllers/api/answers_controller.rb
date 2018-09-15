class API::AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.where("question_id=?",params[:question_id]).page(params[:page]).per(10)
  end

  # GET /answers/1
  # GET /answers/1.json
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
  # POST /answers.json
  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      UserMailer.with(user: @answer.question.user, url: question_url(@answer.question, anchor: 'answer_' + @answer.id.to_s)).alert_email.deliver_now
      render :show, status: :created, location: @answer
    else
      render json: @answer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    if @answer.update({question_accepted_id: @answer.question_accepted_id}.merge(answer_params))
      render :show, status: :ok, location: api_question_answer_url(@answer.question, @answer)
    else
      render json: @answer.errors, status: :unprocessable_entity
    end
  end

  def accept
    @answer = Answer.find(params[:answer_id])
    @question = @answer.question
    if token_user.id != @answer.question.user.id
      render json: {error: "You can only accept answers to question which you asked."}, status: :unauthorized
    elsif (Answer.exists?(question_accepted_id: @question.id))
      render json: {error: "You can only accept one answer per question."}, status: :conflict
    else
      if @answer.update({question_accepted_id: @answer.question.id})
        render :show, status: :ok, location: api_question_answer_url(question_id: @question.id, id: @answer.id)
      else
        render json: @answer.errors, status: :unprocessable_entity
      end
    end
  end

  def reject
    @answer = Answer.find(params[:answer_id])
    @question = @answer.question
    if token_user.id != @question.user.id
      render json: {error: "You can only reject answers to question which you asked."}, status: :unauthorized
    else
      if @answer.update({question_accepted_id: nil})
        render :show, status: :ok, location: api_question_answer_url(question_id: @question.id, id: @answer.id)
      else
        render json: @answer.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    head :no_content
  end

  private


  # Use callbacks to share common setup or constraints between actions.
  def set_answer
    @answer = Answer.find(params[:id]) 
    @question = @answer.question
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def answer_params
    params.permit(:body, :user_id, :question_id)
  end
end
