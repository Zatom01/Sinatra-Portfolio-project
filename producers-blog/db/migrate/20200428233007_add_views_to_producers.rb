class AddViewsToProducers < ActiveRecord::Migration
  def change
    add_column :producers, :views, :integer ,:boolean=>false, :default=>0
  end
end
