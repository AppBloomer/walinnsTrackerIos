Pod::Spec.new do |s|
          #1.
          s.name               = "WalinnsTracker"
          #2.
          s.version            = "1.0.0"
          #3.
          s.summary         = "Sort description of 'WalinnsTracker' framework"
          #4.
          s.homepage        = "https://github.com/Rejoylin/walinnsTrackerIos"
          #5.
          s.license              = "MIT"
          #6.
          s.author               = "Rejoyline"
          #7.
          s.platform            = :ios, "10.3"
          #8.
          s.source              = { :git => "https://github.com/Rejoylin/walinnsTrackerIos.git", :tag => "1.0.0" }
          #9.
          s.source_files     = "WalinnsTracker", "WalinnsTracker/**/*.{h,m,swift}"
    end
