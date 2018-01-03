Gem::Specification.new do |s|
  s.name         = "codefi_game"
  s.version      = "1.0.0"
  s.author       = "Richard Berry"
  s.email        = "berryrichardj@gmail.com"
  s.homepage     = "https://www.pragmaticstudio.com/"
  s.summary      = "A brief game where the user selects the number of turns for randomly geneerated events."
  s.description  = File.read(File.join(File.dirname(__FILE__), 'README'))
  s.licenses     = ['MIT']

  s.files         = Dir["{bin,lib,spec}/**/*"] + %w(LICENSE README)
  s.test_files    = Dir["spec/**/*"]
  s.executables   = [ 'studio_game' ]

  s.required_ruby_version = '>=1.9'
  s.add_development_dependency 'rspec'
end
