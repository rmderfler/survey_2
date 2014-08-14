class CreateSurveyTakers < ActiveRecord::Migration
  def change
    create_table :survey_takers do |t|
      t.column :name, :string
      t.column :response_id, :integer
    end
  end
end
