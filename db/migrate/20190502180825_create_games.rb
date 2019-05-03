class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :name
      t.string :description
      t.integer :developer_id
      t.string :image_icon_url
      t.string :image_header_url
    end
  end
end
