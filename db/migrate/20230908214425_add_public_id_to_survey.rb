class AddPublicIdToSurvey < ActiveRecord::Migration[7.0]
  def change
    add_column :surveys, :public_id, :string, null: false, index: { unique: true }
  end
end
