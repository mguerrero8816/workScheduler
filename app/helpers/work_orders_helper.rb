module WorkOrdersHelper
  MIN_TO_PX = 1
  GENERAL_CELL_STYLE = 'border: 1px solid black;padding:0 4px;border-top-width:0;'

  def build_wo_hours_col
    height = 60 * MIN_TO_PX
    # remove px for border
    height -= 1
    content_tag(:div, style: 'display:inline-block;vertical-align:top') do
      concat(content_tag(:div, 'Time', style: "#{GENERAL_CELL_STYLE};height:#{height}px;"))
      24.times do |i|
        concat(content_tag(:div, "#{i}:00", style: "#{GENERAL_CELL_STYLE};height:#{height}px;"))
      end
    end
  end

  def build_wo_cols(work_orders)
    technicians_hash = build_wo_technicians_hash(work_orders)
    capture do
      technicians_hash.each do |technician_id, work_orders|
        concat(build_wo_technician_col(technician_id, work_orders))
      end
    end
  end

  def build_wo_technicians_hash(work_orders)
    technicians_hash = {}
    work_orders.order('work_orders.time').each do |work_order|
      technician_key = work_order.technician_id.to_s
      technicians_hash[technician_key] ||= []
      technicians_hash[technician_key] << work_order
    end
    technicians_hash
  end

  def build_wo_technician_col(technician_id, work_orders)
    content_tag(:div, style: 'display:inline-block;vertical-align:top') do
      concat(content_tag(:div, technician_id, style: "#{GENERAL_CELL_STYLE};height:#{(60 * MIN_TO_PX)-1}px;"))
      # set current time to beginning_of_day
      current_time_min = 0
      # set offset for overlapping work orders
      total_overlap_offset = 0
      work_orders.each do |work_order|
        wo_time_min = (work_order.time.hour * 60) + work_order.time.min
        gap_height = (wo_time_min - current_time_min) * MIN_TO_PX
        #remove px for border
        gap_height -= 1
        # add negative top positioning if overlapping
        if gap_height < 0
          total_overlap_offset += gap_height
        end
        # only add gap if it present
        if gap_height > 0
          concat(content_tag(:div, nil, style: "#{GENERAL_CELL_STYLE};height:#{gap_height}px;position:relative;top:#{total_overlap_offset}px;"))
        end
        height = work_order.duration * MIN_TO_PX
        #remove px for border
        height -= 1
        cell_style = "#{GENERAL_CELL_STYLE};height:#{height}px;position:relative;top:#{total_overlap_offset}px;"
        # add top border if current cell is overlapping
        if gap_height < 0
          cell_style << "border-top-width:1px"
        end
        concat(content_tag(:div, style: cell_style) do
          concat(content_tag(:div, work_order.time.strftime('%l:%M:%S %P')))
          concat(content_tag(:div, work_order.duration))
        end)
        # set current time to end of work order
        current_time_min = wo_time_min + work_order.duration
      end
      # build gap for end of day
      gap_height = ((24*60) - current_time_min) * MIN_TO_PX
      # remove px for border
      gap_height -= 1
      concat(content_tag(:div, nil, style: "#{GENERAL_CELL_STYLE};height:#{gap_height}px;position:relative;top:#{total_overlap_offset}px"))
    end
  end
end
