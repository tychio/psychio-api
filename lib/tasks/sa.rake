namespace :sa do
  desc "collect data to analysis group"
  task :collect => :environment do
    AnalysisGroup.collect
    puts "Collected data into analysis group."
  end
end
