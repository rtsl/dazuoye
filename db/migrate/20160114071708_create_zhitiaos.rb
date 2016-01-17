class CreateZhitiaos < ActiveRecord::Migration
  def change
    create_table :zhitiaos do |t|
      t.text :content
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :zhitiaos, :users
  end
end
