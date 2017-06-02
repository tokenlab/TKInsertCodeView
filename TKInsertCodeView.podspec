Pod::Spec.new do |s|
  s.name = "TKInsertCodeView"
  s.version = "1.0.0"
  s.summary = "TKInsertCodeView is A practical and customizable code insert UIView."
  s.homepage = "https://github.com/tokenlab/TKInsertCodeView"
  s.license = { type: 'MIT', file: 'LICENSE' }
  s.authors = {  "Daniele Boscolo" => 'danieleboscolo@tokenlab.com.br', "Leonardo Ribeiro" => 'leonardoribeiro@tokenlab.com.br' }

  s.ios.deployment_target = '9.0'
  s.source = { :git => 'https://github.com/tokenlab/TKInsertCodeView.git', :tag => s.version.to_s }
  s.source_files = "TKInsertCodeView/**/*.{h,swift}"
  s.resource_bundles = {
  "TKInsertCodeView" => ["TKInsertCodeView/Classes/*.{xib}"]
  }
end
