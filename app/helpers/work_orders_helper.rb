module WorkOrdersHelper
  MIN_TO_PX = 2

  def build_wo_hours_col
    content_tag(:div, style: 'display:inline-block') do
      24.times do |i|
        height = 60 * MIN_TO_PX
        concat(content_tag(:div, "#{i+1}:00", style: "border: 1px solid black;height:#{height}px;padding:0 4px"))
      end
    end
  end
end
