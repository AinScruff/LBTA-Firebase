# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

target 'LBTA-Firebase' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for LBTA-Firebase
  pod 'Firebase/Analytics'
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  pod 'Firebase/Storage'
 
  target 'LBTA-FirebaseTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'LBTA-FirebaseUITests' do
    # Pods for testing
  end

end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
      end
    end
end