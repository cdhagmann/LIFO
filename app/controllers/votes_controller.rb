class VotesController < ApplicationController
  skip_before_action :verify_authentication

  def create
    if current_user
      if vote_params.key?(:answer_id)
        @vote = Vote.where(user_id: current_user.id, answer_id: vote_params[:answer_id])[0]
      else
        @vote = Vote.where(user_id: current_user.id, answer_id: vote_params[:quesetion_id])[0]
      end

      if @vote
        @vote.update(vote_params)
      else
        @vote = Vote.new(vote_params)
        @vote.save
      end
    end
    if @vote.question.nil?
      redirect_to question_path(@vote.answer.question, anchor: 'answer_' + @vote.answer.id.to_s)
    else
      redirect_to question_path(@vote.question)
    end
  end

  def destroy
    @vote = Vote.find(params[:id])
    if @vote.question.nil?
      @vote.destroy
      redirect_to question_path(@vote.answer.question, anchor: 'answer_' + @vote.answer.id.to_s)
    else
      @vote.destroy
      redirect_to question_path(@vote.question)
    end
  end
  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def vote_params
    params.require(:vote).permit(:value, :user_id, :answer_id, :question_id)
  end
end
