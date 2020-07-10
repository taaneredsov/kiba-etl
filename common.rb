# file to store ETL classes

require 'csv' 

class SourceCSV
  def initialize(filename:)
    @filename = filename
  end

  # Iterates over each line in the CSV so we can pass them one at a
  # time to transform in the next step

  def each
    csv = CSV.open(@filename, headers:true)

    csv.each do |row|
      yield(row.to_hash)
    end

    csv.close
  end
end

class DestinationCSV
  def initialize(filename:)
  	@csv = CSV.open(filename, 'w')
  	@headers_written = false
  end

  def write(row)
  	if !@headers_written
  	  # Add headers on first row
  	  # After which, don't add headers
  	  @headers_written = true
  	  @csv << row.keys
  	end
  	@csv << row.values
  end

  def close
    @csv.close
  end
end

class TransformClean

  def initialize(field:)
    @field = field
  end

  def process(row)
    number = row[@field] # remove non-numeric characters
    row[:number_cleaned] = number.tr('^0-9', '') # count number of characters
    row[:digit_count] = row[:number_cleaned].length
    row
  end

end

class TransformDropFake

  def initialize(field:)
    @field = field
  end

  def process(row)
    number = row[@field]
    row[:digit_count] == 10 ? row :nil
  end

end