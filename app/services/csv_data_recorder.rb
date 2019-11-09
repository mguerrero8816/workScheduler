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
            new_object[object_keys[i].to_sym] = val
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
