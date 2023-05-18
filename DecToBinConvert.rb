def dec_to_bin(dec_number)
    # Converts the decimal number to binary
    if dec_number == 0
        return 0
    else
        return (dec_number % 2) + 10 * dec_to_bin(dec_number / 2)
    end
end

input_file = "input.txt"
output_file = "output.txt"

begin
    # Open input file for reading
    input = File.open(input_file, "r")
    # Open output file for writing
    output = File.open(output_file, "w")

    # Read each line from the input file
    input.each_line do |line|
        begin
            # Convert the line to an integer
            decimal = Integer(line.chomp)

            # Convert decimal to binary using the function
            binary = dec_to_bin(decimal)
            numberString = binary.to_s
            while numberString.length % 8 != 0
                numberString = "0" + numberString
            end
            spaced_numbers = ""
            numberString.chars.each_with_index do |character, spaces|
                spaced_numbers += character
                if (spaces + 1) % 4 == 0
                    spaced_numbers += " "
                end
            end

            # Write the result to the output file
            output.puts "The binary of #{decimal} is #{spaced_numbers}"
        rescue ArgumentError
            # Display error if the line is not a valid integer
            output.puts "Error: Invalid, '#{line.chomp}' is not a valid number."
        end
    end

    puts "Conversion complete. Results written to #{output_file}."
rescue IOError => e
    # Display error if there is an issue with file operations
    puts "An error occurred: #{e.message}"
ensure
    # Close input and output files
    input.close unless input.nil?
    output.close unless output.nil?
end
