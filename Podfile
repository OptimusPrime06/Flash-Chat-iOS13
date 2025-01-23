platform :ios, '13.0'

post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
  end
 end
end

target 'Flash Chat iOS13' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Flash Chat iOS13

  pod 'FirebaseAuth'
  pod 'FirebaseFirestore'
  pod 'CLTypingLabel', '~> 0.4.0'

end
