class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.column :question, :string
      t.column :survey_id, :integer
    end
  end
end
