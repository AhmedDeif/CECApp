
target 'ConstructionReviewApp' do
	
  use_frameworks!
  pod 'Alamofire', '~> 4.7'
  pod 'Cosmos', '~> 16.0'
  pod 'Toast-Swift', '~> 3.0.1'
  pod 'NVActivityIndicatorView'
  pod 'Fabric', '~> 1.9.0'
  pod 'Crashlytics', '~> 3.12.0'
  pod 'Firebase/Core'
  pod 'Firebase/Messaging'
post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end

  target 'ConstructionReviewAppTests' do
    inherit! :search_paths
  end

end
