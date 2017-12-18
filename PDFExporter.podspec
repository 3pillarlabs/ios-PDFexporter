Pod::Spec.new do |s|
  s.name         = "PDFExporter"
  s.version      = "1.0.1"
  s.summary      = "PDFExporter"
  s.description  = "PDFExporter is a simple implementation made to easily export PDF files."
  s.homepage     = "https://github.com/3pillarlabs/ios-PDFexporter"
  s.license      = "MIT (example)"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Bogdan Todea" => "bogdan.todea@3pillarglobal.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/3pillarlabs/ios-PDFexporter.git", :tag => "#{s.version}" }
  s.source_files  = "PDFExporter", "PDFExporter/**/*.{h,m}"
end
