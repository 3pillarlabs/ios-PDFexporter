Pod::Spec.new do |s|
  s.name         = "PDFExporter"
  s.version      = "2.0.1"
  s.summary      = "PDFExporter"
  s.description  = "PDFExporter is a simple framework used to easily export PDF files."
  s.homepage     = "https://github.com/3pillarlabs/ios-PDFexporter"
  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = "3Pillar Global"
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/3pillarlabs/ios-PDFexporter.git", :tag => "#{s.version}" }
  s.source_files  = "PDFExporter", "PDFExporter/**/*.{h,m}"
end
