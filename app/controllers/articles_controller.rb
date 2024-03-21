class ArticlesController < ApplicationController
  def index
    @schedule = Schedule.new
    @schedule.start_time =  Time.new(2023, 1, 1, 14, 0, 0)
    @schedule.end_time =  Time.new(2023, 1, 1, 16, 20, 0)
    @reservations = []

    r = Reservation.new
    r.start_time = Time.new(2023, 1, 1, 14, 10, 0)
    r.duration = 30
    @reservations << r

    r = Reservation.new
    r.start_time = Time.new(2023, 1, 1, 15, 10, 0)
    r.duration = 30
    @reservations << r
  end
end
