class CreateMicroposts < ActiveRecord::Migration[6.0]
  def change
    create_table :microposts do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    # user_idとcreated_atの両方を一つの配列に
    add_index :microposts, [:user_id, :created_at]
  end
end
