class CsvDataRecorder
  class << self
    def call(data_type, filename)
      ActiveRecord::Base.connection
      data_class = data_type.safe_constantize
      # only store data if correct type is passed
      if data_class.present?
        file_string = File.read(filename)
        file_rows = file_string.split("\r\n")
        object_keys = file_rows.first.gsub(/[^0-9A-Za-z,_]/, '').split(',')
        file_rows.drop(1).each do |object_values|
          new_object = data_class.new
          object_values.split(',').each_with_index do |val, i|
            key_to_save = object_keys[i]
            if data_type == 'WorkOrder' && key_to_save == 'time'
              month = val.split('/').first.to_i
              day = val.split('/')[1].to_i
              year = val.split('/').last.split(' ').first.to_i + 2000
              hour = val.split(' ').last.split(':').first.to_i
              minute = val.split(':').last.to_i
              val_to_save = Time.zone.local(year, month, day, hour, minute, 0)
            else
              val_to_save = val
            end
            new_object[key_to_save] = val_to_save
          end
          begin
            new_object.save
          rescue ActiveRecord::RecordNotUnique
          end
        end
      end
    end
  end
end
