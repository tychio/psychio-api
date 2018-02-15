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

  desc "handle experiment results to trails"
  task :trail => :environment do
    ExperimentTrial.import
    puts "Imported results to trails."
  end
end
