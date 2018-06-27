require_relative '../config/ruby_manifest.rb'
require 'json'

class SchedulerController
  attr_reader :load_view, :runner_view, :movie_loader, :today
  attr_accessor :finished

  def initialize
    @load_view = LoadView.new
    @runner_view = RunnerView.new
    @movie_loader = MovieLoader.new
    @today = Time.now
    @finished = false
  end

  def run_program #This is the flow of your program, call other classes and methods to complete
    runner_view.reset_screen!
    load_view.ask_to_reload(today)
    reload_input = gets.chomp

    if reload_input == 'yes'
      movie_loader.compile_todays_list
      load_view.finished
    end

    file = File.read('movie_list.json')
    data_hash = JSON.parse(file)
    movies = data_hash
    index = 0
    movies.each do |title|
      p movies[index]['title']
      index += 1
    end
    until finished
      # logic for your program

      standard_movie_times = []
      standard_movie_end_times = []
      t = Time.new(2018, 06, 26, 11, 30)
      t2 = t + 7200

      


      standard_movie_times << t.strftime('%I:%M %p')
      standard_movie_end_times << t2.strftime('%I:%M %p')
      three_d_movie_times = ["11:00"]
      

      runner_view.ask_if_user_is_finished
      picked_movie = gets.chomp

      index = 0
      movies.length.times do
        if picked_movie == movies[index]['title']
          runner_view.three_d_question

          version = gets.chomp.downcase
          if version == "standard"
            p movies[index]['title']
            p movies[index]['rating']
            p movies[index]['time']
            p movies[index]['theatre']
            p standard_movie_times
            p standard_movie_end_times
            break
          else 
            p three_d_movie_times
            break
          end
        else
         index += 1
        end
      end


      if picked_movie == 'end'
        exit_program 
      end
    end    
  end

  def exit_program
    self.finished = true
    runner_view.good_bye_message
  end
end
