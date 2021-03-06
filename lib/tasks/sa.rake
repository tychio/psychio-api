namespace :sa do
  desc "collect data to analysis group"
  task :collect => :environment do
    AnalysisGroup.collect
    puts "Collected data into analysis group."
  end

  desc "import picture naming data to results"
  task :import => :environment do
    response = `python lib/python/fetchCOS.py #{Rails.application.config.tencent_id} #{Rails.application.config.tencent_key}`
    results = JSON.parse response
    results.each do |json|
      result = JSON.parse json
      pictureNaming = JSON.generate result['results']['picture-naming']
      ExperimentResult.save(result['contact'], {
        :'picture-naming' => pictureNaming
      })
    end
    puts "Imported data into experiment results."
  end

  desc "handle experiment results to trials"
  task :trial, [:limit] => [:environment] do |t, args|
    ExperimentTrial.import args[:limit].to_i
    puts "Imported results to trials."
  end
end
