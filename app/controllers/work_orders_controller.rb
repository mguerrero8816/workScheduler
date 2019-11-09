class WorkOrdersController < ApplicationController
  def index
    start_date = Time.zone.local(2019, 10, 1).beginning_of_day
    finish_date = start_date.end_of_day
    @work_orders = WorkOrder.where('time >= ? AND time <= ?', start_date, finish_date)
  end
end
