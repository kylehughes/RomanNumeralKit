Pod::Spec.new do |s|
    s.name = "RomanNumeralKit"
    s.version = "1.2.1"
    s.license = "MIT"
    s.summary = "First-class Roman numeral support for Swift."
    s.homepage = "https://github.com/kylehughes/RomanNumeralKit"
    s.authors = "Kyle Hughes"
    s.source = { :git => "https://github.com/kylehughes/RomanNumeralKit.git", :tag => s.version }
  
    s.ios.deployment_target = "10.0"
    s.osx.deployment_target = "10.12"
    s.tvos.deployment_target = "10.0"
    s.watchos.deployment_target = "3.0"
  
    s.swift_version = "5.0"

    s.source_files = "Sources/RomanNumeralKit/**/*.swift"
  end
