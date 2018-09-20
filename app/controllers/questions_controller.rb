class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  def index
    session[:return_to] = root_path
    if params[:search]
      @questions = Question.left_outer_joins(:votes).left_outer_joins(:accepted_answer).left_outer_joins(:user)
                       .select('questions.*,
                            SUM(Coalesce(votes.value,0)) as vote_count, 
                            CASE WHEN max(answers.question_accepted_id) is NOT NULL THEN TRUE ELSE FALSE END as accepted,
                            MAX(users.username) as username,
                            (SELECT COUNT(*) FROM "answers" WHERE "answers"."question_id" = "questions"."id" ) as answer_count')
                       .group(:id)
                       .where(id: Question.search(params[:search]))
                       .order('vote_count DESC')
                       .order('created_At DESC').page(params[:page]).per(25)
    else
      @questions = Question.left_outer_joins(:votes).left_outer_joins(:accepted_answer).left_outer_joins(:user)
                       .select('questions.*,
                            SUM(Coalesce(votes.value,0)) as vote_count, 
                            CASE WHEN max(answers.question_accepted_id) is NOT NULL THEN TRUE ELSE FALSE END as accepted,
                            MAX(users.username) as username,
                            (SELECT COUNT(*) FROM "answers" WHERE "answers"."question_id" = "questions"."id" ) as answer_count')
                       .group(:id)
                       .order('vote_count DESC')
                       .order('created_At DESC').page(params[:page]).per(25)
    end
  end

  # GET /questions/1
  def show
    session[:return_to] = request.referer if request.referer != request.url
    @answers = @question.answers
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
  def update
    if @question.update(question_params)
      redirect_to @question, notice: 'Question was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /questions/1
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
