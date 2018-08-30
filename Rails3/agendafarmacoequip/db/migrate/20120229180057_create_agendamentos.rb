class CreateAgendamentos < ActiveRecord::Migration
  def self.up
    create_table :agendamentos do |t|
      t.date :data_inicio
      t.date :data_fim
      t.time :hora_inicio
      t.time :hora_fim
      t.integer :event_id

      t.timestamps
    end
  end

  def self.down
    drop_table :agendamentos
  end
end
