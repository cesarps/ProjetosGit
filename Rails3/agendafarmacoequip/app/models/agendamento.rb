class Agendamento < ActiveRecord::Base
  belongs_to :event   #, :class_name => "Event", :foreign_key => "event_id"
end