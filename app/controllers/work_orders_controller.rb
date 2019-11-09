class WorkOrdersController < ApplicationController
  def index
    start_date = Time.zone.local(2019, 10, 1).beginning_of_day
    finish_date = start_date.end_of_day
    @work_orders = (
      WorkOrder.select('work_orders.*,
                        technicians.name AS technician_name,
                        locations.name AS location_name,
                        locations.city AS location_city')
               .joins('LEFT JOIN technicians ON technicians.id = work_orders.technician_id')
               .joins('LEFT JOIN locations ON locations.id = work_orders.location_id')
               .where('work_orders.time >= ? AND work_orders.time <= ?', start_date, finish_date)
    )
  end
end
