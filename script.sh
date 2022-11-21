# xcodebuild -workspace Parse.xcworkspace \
# -scheme Parse-iOS \
# -configuration Debug \
# -sdk iphonesimulator \
# -derivedDataPath Build/Parse

xcodebuild -workspace Parse.xcworkspace \
-scheme Parse-iOS \
-configuration Release \
-sdk iphonesimulator \
-derivedDataPath Build/Parse

# xcodebuild -workspace Parse.xcworkspace \
# -scheme Parse-iOS \
# -configuration Debug \
# -sdk iphoneos \
# -derivedDataPath Build/Parse

# xcodebuild -workspace Parse.xcworkspace \
# -scheme Parse-iOS \
# -configuration Release \
# -sdk iphoneos \
# -derivedDataPath Build/Parse

# xcodebuild -workspace Parse.xcworkspace \
# -scheme Parse-iOS \
# -configuration Debug \
# -sdk macosx \
# -derivedDataPath Build/Parse \
# SUPPORTS_MACCATALYST=YES

# xcodebuild -workspace Parse.xcworkspace \
# -scheme Parse-iOS \
# -configuration Release \
# -sdk macosx \
# -derivedDataPath Build/Parse \
# SUPPORTS_MACCATALYST=YES

# xcodebuild -workspace Parse.xcworkspace \
# -scheme Parse-iOS \
# -configuration Debug \
# -sdk macosx \
# -derivedDataPath Build/Parse \
# SUPPORTS_MACCATALYST=YES ONLY_ACTIVE_ARCH=NO

# xcodebuild -workspace Parse.xcworkspace \
# -scheme Parse-iOS \
# -configuration Release \
# -sdk macosx \
# -derivedDataPath Build/Parse \
# SUPPORTS_MACCATALYST=YES ONLY_ACTIVE_ARCH=NO

# xcodebuild -workspace Parse.xcworkspace \
# -scheme Parse-macOS \
# -configuration Debug \
# -sdk macosx \
# -derivedDataPath Build/Parse \

# xcodebuild -workspace Parse.xcworkspace \
# -scheme Parse-macOS \
# -configuration Release \
# -sdk macosx \
# -derivedDataPath Build/Parse \
