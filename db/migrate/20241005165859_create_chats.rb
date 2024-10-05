class CreateChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chats do |t|
      t.string :session_id

      t.timestamps
    end
  end
end
