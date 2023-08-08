xcodebuild \
  -workspace DigioOneFinger.xcworkspace \
  -scheme DigioOneFinger \
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 13 mini,OS=15.5' \
  test | xcpretty -t
