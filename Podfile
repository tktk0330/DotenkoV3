# Uncomment the next line to define a global platform for your project
platform :ios, '16.0'

target 'DotenkoV3' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for DotenkoV3
  
  # Google AdMob SDK（AdMobテスト用）
  pod 'Google-Mobile-Ads-SDK'

  target 'DotenkoV3Tests' do
    inherit! :search_paths
    # Pods for testing
  end

end

# Xcode 16 CocoaPods workaround
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.6'
      config.build_settings['ENABLE_BITCODE'] = 'NO'
      
      # Fix for Xcode 16 sandboxing issue
      if target.name == 'BoringSSL-GRPC'
        config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = 'YES'
      end
      
      # Disable code signing for Pods
      config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
      config.build_settings['CODE_SIGNING_REQUIRED'] = 'NO'
      config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ''
      config.build_settings['CODE_SIGNING_IDENTITY'] = ''
    end
  end
end 