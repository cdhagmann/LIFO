# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/
  def show
    @questions = Question.left_outer_joins(:votes).left_outer_joins(:accepted_answer).left_outer_joins(:user)
                         .select('questions.*,
                            SUM(Coalesce(votes.value,0)) as vote_count,
                            CASE WHEN max(answers.question_accepted_id) is NOT NULL THEN TRUE ELSE FALSE END as accepted,
                            MAX(users.username) as username,
                            (SELECT COUNT(*) FROM "answers" WHERE "answers"."question_id" = "questions"."id" ) as answer_count')
                         .group(:id)
                         .order('vote_count DESC')
                         .order('created_At DESC')
                         .where('questions.user_id=?', @user.id).page(params[:page]).per(10)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    session[:return_to] = root_path
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :api_token, :avatar)
  end
end
