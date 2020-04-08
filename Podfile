platform :ios, '8.0'

workspace 'fuji.xcworkspace'
project 'pubsdk/pubsdk.xcodeproj'

target 'pubsdkTests' do
    pod 'OCMock','~> 3.4.3'
    pod 'Google-Mobile-Ads-SDK','~> 7.35.2'
    pod 'mopub-ios-sdk', '~> 5.4.0'
end

target 'pubsdk' do
    pod 'Cassette','1.0.0-beta3'
end

target 'CriteoPublisherSdk' do
    pod 'Cassette','1.0.0-beta3'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '8.0'
    end
  end
end

