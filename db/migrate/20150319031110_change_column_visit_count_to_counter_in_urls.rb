class ChangeColumnVisitCountToCounterInUrls < ActiveRecord::Migration
  def change
    remove_column :urls, :visit_counter
    add_column :urls, :counter, :integer, :default => 0
  end
end
