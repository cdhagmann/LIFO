# frozen_string_literal: true

module API
  class QuestionsController < ApplicationController
    before_action :verify_authentication
    skip_before_action :verify_authentication, only: %i[index show]
    before_action :set_question, only: %i[show destroy]

    def index
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

    def show; end

    def create
      if !token_user
        render json: { error: 'Must be logged in to question' }, status: :unprocessable_entity
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
        render json: { error: 'Must be the user to Delete This question' }
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
end
