# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'DoctorHere' do
  # Comment the next line if you don't want to use dynamic frameworks
  platform :ios, '13.0'  # or '14.0' if needed

  use_frameworks!
  
   pod 'HCSStarRatingView'
   pod 'FSCalendar'
   pod 'IQKeyboardManagerSwift'
  
  post_install do |installer|
      installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
              end
          end
      end
  end

end
