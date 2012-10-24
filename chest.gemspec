Gem::Specification.new do |s|
  s.name              = "chest"
  s.version           = "0.0.1.pre"
  s.summary           = "Repository Pattern"
  s.description       = ""
  s.authors           = ["elcuervo"]
  s.email             = ["yo@brunoaguirre.com"]
  s.homepage          = "http://github.com/elcuervo/chest"
  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files test`.split("\n")

  s.add_development_dependency("minitest", "~> 4.1.0")
end
