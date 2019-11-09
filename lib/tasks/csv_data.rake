namespace :csv_data do
  desc 'Calls CsvDataRecorder class which reads and saves data without duplicate ids from the locations.csv, technicians.csv and work_orders.csv files in the public folder'
  task record: :environment do
    CsvDataRecorder.call('Location', 'public/locations.csv')
  end
end
