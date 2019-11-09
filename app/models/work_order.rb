class WorkOrder < ApplicationRecord
  belongs_to :location
  belongs_to :technician
end
