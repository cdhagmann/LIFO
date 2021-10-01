# frozen_string_literal: true

module API
  class VotesController < ApplicationController
    before_action :set_vote
    before_action :verify_authentication

    def upvote
      if @vote
        if @vote.update({ value: [@vote.value + 1, 1].min, user_id: token_user.id }.merge(vote_params))
          if @vote.question.nil?
            redirect_to api_question_answer_path(params[:question_id], @vote.answer.id)
          else
            redirect_to api_question_path(@vote.question)
          end
        else
          render json: @vote.errors, status: :unprocessable_entity
        end
      else
        @vote = Vote.new({ value: 1, user_id: token_user.id }.merge(vote_params))
        if @vote.save
          if @vote.question.nil?
            redirect_to api_question_answer_path(@vote.answer)
          else
            redirect_to api_question_path(@vote.question)
          end
        else
          render json: @vote.errors, status: :unprocessable_entity
        end
      end
    end

    def downvote
      if @vote
        if @vote.update({ value: [@vote.value - 1, -1].max, user_id: token_user.id }.merge(vote_params))
          if @vote.question_id.nil?
            redirect_to api_question_answer_path(params[:question_id], @vote.answer)
          else
            redirect_to api_question_path(@vote.question)
          end
        else
          render json: @vote.errors, status: :unprocessable_entity
        end
      else
        @vote = Vote.new({ value: -1, user_id: token_user.id }.merge(vote_params))
        if @vote.save
          if @vote.question.nil?
            redirect_to api_question_answer_path(@vote.answer)
          else
            redirect_to api_question_path(@vote.question)
          end
        else
          render json: @vote.errors, status: :unprocessable_entity
        end
      end
    end

    private

    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_params
      if params.key?(:answer_id)
        params.permit(:value, :user_id, :answer_id)
      else
        params.permit(:value, :user_id, :question_id)
      end
    end

    def set_vote
      @vote = if vote_params.key?(:answer_id)
                Vote.where(user_id: token_user.id, answer_id: vote_params[:answer_id])[0]
              else
                Vote.where(user_id: token_user.id, question_id: vote_params[:question_id])[0]
              end
    end
  end
end
