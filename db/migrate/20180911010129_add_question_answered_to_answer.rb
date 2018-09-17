class AddQuestionAnsweredToAnswer < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :question_accepted_id, :integer
  end
end
