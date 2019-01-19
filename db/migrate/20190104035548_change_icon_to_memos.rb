class ChangeIconToMemos < ActiveRecord::Migration[5.1]
  def change
    change_column :memos, :icon, 'text USING CAST(icon AS text)'
  end
end
