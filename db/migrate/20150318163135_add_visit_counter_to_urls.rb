class AddVisitCounterToUrls < ActiveRecord::Migration
  def change
    add_column :urls, :visit_counter, :integer, :default => 0
  end
end
