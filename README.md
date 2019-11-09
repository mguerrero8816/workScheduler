# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  ruby 2.6.3p62 (2019-04-16 revision 67580) [x86_64-linux]

* Rails version
  Rails 6.0.1

* System dependencies
  postgresql
  nodejs
  yarn

* Configuration
  # install gems
  bundle install
  # install webpacker
  rails webpacker:install

* Database creation
  rake db:create

* Database initialization
  rake db:migrate
  rake csv_data:record

* Designing
  My plan of action was to build the application from the backend to the frontend
  1. the database tables and models were created in order to establish the relationships between the models
  2. the rake task to populate the database was created so there would be data to use in the view
  3. the grid was built using divs in order to overcome the restrictions associated with using tables
  4. the height of each div would be determined by how many minutes were accounted for in the specific segment of the column
     4a. the pixel width of the borders for each cell needed to be taken into account to get heights that would match each column
     4b. relative positioning had to be used in order to overlap divs for work orders that overlapped
  5. work orders were order by time and grouped by technicians in order to perform loops through each work order per technician
  6. jquery was added and generic alerts showing hours and minutes were added
  7. special alerts were added for the first and last gaps in a day

* Challenges
  1. The included csv files had special blank space characters.  It took me a while to find what was causing a problem when trying to save the information to the database.  I used a regex to only permit the alphabet, numbers, and certain characters
  2. The overlapping work orders on the last day.  I had to use relative positioning in order to move the divs on top of each other to represent the overlap.

* Future Improvements
  1. click on a work order and edit (including delete) it
  2. click on a gap and add a work order to it
  3. drag and drop work orders across technicians and timeslots
  4. drap mouse to create work order across the dragged timeframe
