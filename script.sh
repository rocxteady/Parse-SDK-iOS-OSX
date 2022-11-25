command=${1}
#valid commands: run_tests, debug, create_frameworks, clean

if [ -z $command ]; then
    command=create_frameworks
elif [ $command != run_tests ] && [ $command != debug ] && [ $command != create_frameworks ] && [ $command != clean ]; then
    echo "Not a valid command: ${command}"
    exit 1
fi

build() {
    scheme=${1}
    configuration=${2}
    os=${3}
    build_command=${4}
    #valid commands: test
    only_build_active_arch=NO

    params=()
    if [ $os == catalyst ]; then
    params+=(SUPPORTS_MACCATALYST=YES)
    os=macosx
    fi

    if [ ! -z $build_command ]; then
        params+=($build_command)
    fi

    if [ ! -z $build_command ] && [ $build_command == test ]; then
        if [ $os == iphonesimulator ]; then
            params+=(-destination 'platform=iOS Simulator,name=iPhone 14 Pro')
        elif [ $os == macosx ]; then
            params+=(-destination 'platform=macOS')
        fi
        only_build_active_arch=YES
    fi
    
    xcodebuild -workspace Parse.xcworkspace \
    -scheme ${scheme} \
    -configuration ${configuration} \
    -sdk ${os} \
    -derivedDataPath build \
    ONLY_ACTIVE_ARCH=${only_build_active_arch} "${params[@]}"
}

create_xcframeworks() {
    framework=${1}
    configuration=${2}
    os=${3}
    
    if [ -z $os ]; then
        os=all
    fi

    path=build/Build/Products/${configuration}

    params=()
    if [ $os == ios ]; then
        params+=(-framework ${path}-iphoneos/${framework}.framework)
        params+=(-framework ${path}-iphonesimulator/${framework}.framework)
    elif [ $os == tv ]; then
        params+=(-framework ${path}-appletvos/${framework}.framework)
        params+=(-framework ${path}-appletvsimulator/${framework}.framework)
    elif [ $os == mac ]; then
        params+=(-framework ${path}/${framework}.framework)
    elif [ $os == catalyst ]; then
        params+=(-framework ${path}-maccatalyst/${framework}.framework)
    elif [ $os == tv ]; then
        params+=(-framework ${path}-watchos/${framework}.framework)
        params+=(-framework ${path}-watchsimulator/${framework}.framework)
    else
        params+=(-framework ${path}/Parse.framework)
        params+=(-framework ${path}-appletvos/Parse.framework)
        params+=(-framework ${path}-appletvsimulator/Parse.framework)
        params+=(-framework ${path}-iphoneos/Parse.framework)
        params+=(-framework ${path}-iphonesimulator/Parse.framework)
        params+=(-framework ${path}-maccatalyst/Parse.framework)
        params+=(-framework ${path}-watchos/Parse.framework)
        params+=(-framework ${path}-watchsimulator/Parse.framework)
    fi

    xcodebuild -create-xcframework \
    "${params[@]}" \
    -output build/Frameworks/${framework}.xcframework
}

copy_facebook_dependencies() {
    cp -r Carthage/Build/FBSDKCoreKit.xcframework build/Frameworks
    cp -r Carthage/Build/FBSDKLoginKit.xcframework build/Frameworks
    cp -r Carthage/Build/FBSDKCoreKit_Basics.xcframework build/Frameworks
    cp -r Carthage/Build/FBAEMKit.xcframework build/Frameworks
    cp -r Carthage/Build/FBSDKTVOSKit.xcframework build/Frameworks
}

#clean
clean() {
    rm -rf build
}

#create frameworks
debug() {
    build Parse-iOS Debug iphonesimulator
    build Parse-iOS Debug iphoneos
    build Parse-iOS Debug catalyst
    build Parse-macOS Debug macosx
    build Parse-tvOS Debug appletvsimulator
    build Parse-tvOS Debug appletvos
    build Parse-watchOS Debug watchsimulator
    build Parse-watchOS Debug watchos

    build ParseFacebookUtilsiOS Debug iphonesimulator
    build ParseFacebookUtilsiOS Debug iphoneos

    build ParseFacebookUtilsTvOS Debug appletvsimulator
    build ParseFacebookUtilsTvOS Debug appletvos

    build ParseFacebookUtilsTvOS Debug appletvsimulator
    build ParseFacebookUtilsTvOS Debug appletvos

    build ParseUI Debug iphonesimulator
    build ParseUI Debug iphoneos
}

#create frameworks
create_framework_for_parse() {
    build Parse-iOS Release iphonesimulator
    build Parse-iOS Release iphoneos
    build Parse-iOS Release catalyst
    build Parse-macOS Release macosx
    build Parse-tvOS Release appletvsimulator
    build Parse-tvOS Release appletvos
    build Parse-watchOS Release watchsimulator
    build Parse-watchOS Release watchos

    create_xcframeworks Parse Release
    create_xcframeworks Bolts Release
}

create_framework_for_facebook_ios() {
    build ParseFacebookUtilsiOS Release iphonesimulator
    build ParseFacebookUtilsiOS Release iphoneos

    create_xcframeworks ParseFacebookUtilsiOS Release ios
}

create_framework_for_facebook_tvos() {
    build ParseFacebookUtilsTvOS Release appletvsimulator
    build ParseFacebookUtilsTvOS Release appletvos

    create_xcframeworks ParseFacebookUtilsTvOS Release tv
}

create_framework_for_twitter() {
    build ParseTwitterUtils-iOS Release iphonesimulator
    build ParseTwitterUtils-iOS Release iphoneos

    create_xcframeworks ParseTwitterUtils Release ios
}

create_framework_for_parseui() {
    build ParseUI Release iphonesimulator
    build ParseUI Release iphoneos

    create_xcframeworks ParseUI Release ios
}

#Tests
run_tests_for_parse() {
    build Parse-iOS Debug iphonesimulator test
    build Parse-macOS Debug macosx test
}

run_tests_for_facebook() {
    build ParseFacebookUtilsiOS Debug iphonesimulator test
}

run_tests_for_twitter() {
    build ParseTwitterUtils-iOS Debug iphonesimulator test
}

run_tests_for_parseui() {
    build ParseUI Debug iphonesimulator test
}

run_tests() {
    run_tests_for_parse
    run_tests_for_facebook
    run_tests_for_twitter
    run_tests_for_parseui
}

create_frameworks() {
    # create_framework_for_parse
    # create_framework_for_facebook_ios
    # create_framework_for_facebook_tvos
    # create_framework_for_twitter
    # create_framework_for_parseui
    copy_facebook_dependencies
}

if [ $command == run_tests ]; then
    run_tests
elif [ $command == debug ]; then
    debug
elif [ $command == create_frameworks ]; then
    create_frameworks
elif [ $command == clean ]; then
    clean
fi
