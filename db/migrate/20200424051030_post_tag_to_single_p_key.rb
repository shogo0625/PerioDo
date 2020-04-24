class PostTagToSinglePKey < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :post_tag, :post_id
  end
end
