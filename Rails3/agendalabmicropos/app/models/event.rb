class Event < ActiveRecord::Base

  belongs_to :tipo
  belongs_to :usuario    #teste
  has_many :agendamentos, :dependent => :destroy
  validates_presence_of :title, :regpara

  
  def cor_fundo(data_inicial)
    hora = data_inicial.hour

    if hora > 18
      'white'
    elsif hora > 12
      'light green'
    else
      'yellow'
    end

   # 'white'
  end

  def odiainteiro
    if self.all_day?
      "Sim"
    else
      "Nao"
    end
  end

  scope :before,
        lambda {|end_time| {:conditions => ["starts_at < ?", Event.format_date(end_time)] }}
  scope :after,
        lambda {|start_time| {:conditions => ["ends_at > ?", Event.format_date(start_time)] }}

  
  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  def as_json(options = {})
     {
          :id => self.id,
          :title => self.title + " - " + self.nome + " - Ramal " +  self.ramal,
          :start => starts_at,
          :end => ends_at,
          :recurring => false,
          :allDay => false,
          #:url => "http://watson.icb.usp.br/agendamicro" << Rails.application.routes.url_helpers.event_path(id),
          :backgroundColor => self.cor,
          :url => Rails.application.routes.url_helpers.event_path(id)         #redireciona para a página do evento quando clica no dia no calendario
      }

  end

  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end
end

