platform :ios, '8.0'
use_frameworks!

def lollypop_pods
  pod 'AspectsV1.4.2', '~> 1.4.2'
  pod 'BTInfiniteScrollView', '1.0.1'
  pod 'CocoaLumberjack', '2.0.0'
  pod 'IQKeyboardManager', '4.0.4'
  pod 'JSONKit-NoWarning', '1.2'
  pod 'JSONModel', '1.0.2'
#  pod 'KVOController', '1.0.3'
  pod 'Masonry', '0.6.1'
  pod 'nv-ios-http-status', '0.0.1'
  pod 'NJKWebViewProgress', '0.2.3'
  pod 'pop', '1.0.7'
  pod 'SDWebImage', '3.7.2'
  pod 'Toast', '2.4'
  pod 'UIActionSheet+Blocks', '0.8.1'
  pod 'UIAlertView+Blocks', '0.8.1'
  pod 'YTKKeyValueStore', '0.1.2'
  pod 'YTKNetwork', '1.1.0'
  pod 'UIView+Loading', '1.0.0'
  pod 'AMapLocation', '1.0.1'
  pod    'EGOCache' , '2.1.3'
#  pod 'Reachability', '3.2'
  pod 'BMLayoutConstraint', '~> 1.1.1'
#  pod 'Qiniu', '~> 7.0'
#  pod 'RongCloudIMKit', '2.7.3'
#  pod 'MJRefresh'
end

target 'Demo0' do
  lollypop_pods
end

target 'Demo0Tests' do
  lollypop_pods
end

target 'Demo0UITests' do
  lollypop_pods
end



post_install do |installer|
  `find Pods -regex 'Pods/pop.*\\.h' -print0 | xargs -0 sed -i '' 's/\\(<\\)pop\\/\\(.*\\)\\(>\\)/\\"\\2\\"/'`
end

# pod 'Charts', '2.1.3'