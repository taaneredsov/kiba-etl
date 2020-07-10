# We’ll use a rake task to kickstart the Kiba job.
# In a real situation, you might use a service like Twilio to detect if they’re real phone numbers.

require 'kiba'
require_relative 'common'

task :kiba_run do
  puts "The job is running ..."
  
  Kiba.run(
    Kiba.parse do
      ##############################################################
      source SourceCSV, filename: 'numbers.csv'

      transform TransformClean, field: 'number'
      transform TransformDropFake, field: 'number'

      destination DestinationCSV, filename: 'numbers-cleaned.csv'
      ##############################################################
    end
  )

  puts "... the job is finished"
end

# in shell:
# cat numbers-cleaned.csv | column -t -s, | less -S