class CreateCounters < ActiveRecord::Migration
  def change
    create_table :counters do |t|
      t.string :iteration

      t.timestamps null: false
    end
  end
end
