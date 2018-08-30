class CreateVinculo < ActiveRecord::Migration
  def self.up
    create_table :vinculos do |t|
      t.string :vinculo
      t.timestamps
    end
  end

  def self.down
    drop_table :vinculos



  end
end
