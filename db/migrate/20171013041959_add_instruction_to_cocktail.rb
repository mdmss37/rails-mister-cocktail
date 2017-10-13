class AddInstructionToCocktail < ActiveRecord::Migration[5.0]
  def change
    add_column :cocktails, :instruction, :text
  end
end
