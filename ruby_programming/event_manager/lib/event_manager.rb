require "csv"
require 'google/apis/civicinfo_v2'
require 'erb'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0...5]
end

def clean_phone_number(phone_number)
  phone = phone_number.gsub(/[^\d]/, '')
  if phone.length == 10
    # return formatted phone_number 123-456-7899
    phone[0..2] + "-" + phone[3..5] + "-" + phone[6..9]
  elsif phone.length == 11 && phone[0] == "1"
    # delete leading '1' and return formatted number
    phone[1..3] + "-" + phone[4..6] + "-" + phone[7..10]
  else
    # bad number
    "000-000-0000"
  end
end

def most_visited_hour(reg_dates)
  count_hours = Hash.new(0)
  reg_dates.each { |date| count_hours[date.hour] +=  1 }
  max_hours = count_hours.select { |k, v| v == count_hours.values.max }
  puts "Most visited hour(s): #{max_hours.keys.join(", ")}."
end

def most_visited_weekday(reg_dates)
  count_days = Hash.new(0)
  reg_dates.each { |date| count_days[date.strftime('%A')] +=  1 }
  max_days = count_days.select { |k, v| v == count_days.values.max }
  puts "Most visited weekday(s): #{max_days.keys.join(", ")}."
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
  end
end

def save_thank_you_letters(id,form_letter)
  Dir.mkdir("output") unless Dir.exists?("output")

  filename = "output/thanks_#{id}.html"

  File.open(filename,'w') do |file|
    file.puts form_letter
  end
end

puts "EventManager Initialized!"

contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter
reg_dates = []

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  phone_number = clean_phone_number(row[:homephone])

  reg_dates << DateTime.strptime(row[:regdate], "%D %H:%M")

  zipcode = clean_zipcode(row[:zipcode])

  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)


  save_thank_you_letters(id,form_letter)
end

most_visited_hour(reg_dates)
most_visited_weekday(reg_dates)