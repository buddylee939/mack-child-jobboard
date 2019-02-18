class AddCategoryIdToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :category_id, :integer
  end
end
