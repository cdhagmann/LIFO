# frozen_string_literal: true

class VotesController < ApplicationController
  before_action :set_vote, only: :create

  def create
    if current_user
      if @vote
        @vote.update(vote_params)
      else
        @vote = Vote.new(vote_params)
        @vote.save
      end
    end
    if @vote.question.nil?
      redirect_to question_path(@vote.answer.question, anchor: "answer_#{@vote.answer.id}")
    else
      redirect_to question_path(@vote.question)
    end
  end

  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy
    if @vote.question.nil?
      redirect_to question_path(@vote.answer.question, anchor: "answer_#{@vote.answer.id}")
    else
      redirect_to question_path(@vote.question)
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def vote_params
    if params.key?(:answer_id)
      params.require(:vote).permit(:value, :user_id, :answer_id)
    else
      params.require(:vote).permit(:value, :user_id, :question_id)
    end
  end

  def set_vote
    @vote = if vote_params.key?(:answer_id)
              Vote.where(user_id: current_user.id, answer_id: vote_params[:answer_id])[0]
            else
              Vote.where(user_id: current_user.id, question_id: vote_params[:question_id])[0]
            end
  end
end
