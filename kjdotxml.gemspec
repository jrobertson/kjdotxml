Gem::Specification.new do |s|
  s.name = 'kjdotxml'
  s.version = '0.2.1'
  s.summary = 'King James Bible in XML format i.e. KjDotXml.new.book("Genesis")'
  s.authors = ['James Robertson']
  s.add_runtime_dependency('rexle', '~> 1.5', '>=1.5.14')
  s.files = Dir["lib/kjdotxml.rb",'xml/*.xml']
  s.add_runtime_dependency('novowels', '~> 0.1', '>=0.1.3')
  s.signing_key = '../privatekeys/kjdotxml.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'digital.robertson@gmail.com'
  s.homepage = 'https://github.com/jrobertson/kjdotxml'
end
