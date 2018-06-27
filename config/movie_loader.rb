# require 'nokogiri'
# require 'open-uri'
# require 'json'

# class MovieLoader
#   def compile_todays_list
#     # Grabs info from internet
#     list_page = Nokogiri::HTML(open('http://www.fandango.com/amcrivereast21_aaqow/theaterpage'))
#     collection = []

#     list_page.css('div.showtimes-movie-container').each do |link|

#       title = link.css('a.showtimes-movie-title').first.content
#       rating_time = link.css('div.showtimes-movie-rating-runtime').first.content
#       rating_time_stripped = rating_time.gsub(/\n\s+(\b|\z)/,'')
#       rating_time_array = rating_time_stripped.split(" , ")
#       time = rating_time_array.last
#       rating = rating_time_array.first

#       collection << {
#                       title: title,
#                       time: time,
#                       rating: rating
#                       }
#     end

#     # writes to file, ruby terminal app
#     File.open("movie_list.json","w") do |f|
#       f.write(collection.to_json)
#     end
#   end
# end

require 'nokogiri'
require 'open-uri'
require 'json'

class MovieLoader
  def compile_todays_list
    # Grabs info from internet
    list_page = Nokogiri::HTML(open('https://www.amctheatres.com/movie-theatres/chicago/amc-river-east-21'))
    collection = []

    list_page.css('.PosterContent').each do |element|
      title = element.css('h3').first.content
      time = element.css('.u-separator.js-runtimeConvert.u-inlineFlexCenter').first.content
      rating = element.css('.Headline--eyebrow p span')[3].content

      collection << {
                      title: title,
                      time: time,
                      rating: rating
                      }
    end

    # writes to file, ruby terminal app
    File.open("movie_list.json","w") do |f|
      f.write(collection.to_json)
    end
  end
end