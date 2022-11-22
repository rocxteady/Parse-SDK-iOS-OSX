build() {
    scheme=${1}
    configuration=${2}
    os=${3}

    params=()
    if [ $os == catalyst ]; then
    params+=(SUPPORTS_MACCATALYST=YES)
    os=macosx
    fi
    
    xcodebuild -workspace Parse.xcworkspace \
    -scheme ${scheme} \
    -configuration ${configuration} \
    -sdk ${os} \
    -derivedDataPath Build/Parse \
    ONLY_ACTIVE_ARCH=NO "${params[@]}"
}

create_xcframeworks() {
    configuration=${1}
    path=Build/Parse/Build/Products/${configuration}
    xcodebuild -create-xcframework \
    -framework ${path}/Parse.framework \
    -framework ${path}-appletvos/Parse.framework \
    -framework ${path}-appletvsimulator/Parse.framework \
    -framework ${path}-iphoneos/Parse.framework \
    -framework ${path}-iphonesimulator/Parse.framework \
    -framework ${path}-maccatalyst/Parse.framework \
    -framework ${path}-watchos/Parse.framework \
    -framework ${path}-watchsimulator/Parse.framework \
    -output Build/Parse.xcframework
    # rm -rf Build/Parse
}

create_bolts_xcframeworks() {
    configuration=${1}
    path=Build/Parse/Build/Products/${configuration}
    xcodebuild -create-xcframework \
    -framework ${path}/Bolts.framework \
    -framework ${path}-appletvos/Bolts.framework \
    -framework ${path}-appletvsimulator/Bolts.framework \
    -framework ${path}-iphoneos/Bolts.framework \
    -framework ${path}-iphonesimulator/Bolts.framework \
    -framework ${path}-maccatalyst/Bolts.framework \
    -framework ${path}-watchos/Bolts.framework \
    -framework ${path}-watchsimulator/Bolts.framework \
    -output Build/Bolts.xcframework
    # rm -rf Build/Parse
}

# create_xcframeworks Release
create_bolts_xcframeworks Release