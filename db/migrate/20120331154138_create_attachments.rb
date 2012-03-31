class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :type
      t.integer :purchaseorder_id

      t.timestamps
    end
  end
end
