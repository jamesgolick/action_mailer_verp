# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{action_mailer_verp}
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["James Golick"]
  s.date = %q{2011-03-21}
  s.description = %q{Send VERP emails with actionmailer.}
  s.email = %q{jamesgolick@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "action_mailer_verp.gemspec",
    "lib/action_mailer_verp.rb",
    "lib/action_mailer_verp/bounce_processor.rb",
    "lib/action_mailer_verp/pop_fetcher.rb",
    "spec/action_mailer_verp_spec.rb",
    "spec/bounce_processor_spec.rb",
    "spec/spec.opts",
    "spec/spec_helper.rb",
    "spec/templates/my_mailer/multiple_froms.erb",
    "spec/templates/my_mailer/multiple_recipients.erb",
    "spec/templates/my_mailer/some_mail.erb"
  ]
  s.homepage = %q{http://github.com/jamesgolick/action_mailer_verp}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Send VERP emails with actionmailer.}
  s.test_files = [
    "spec/action_mailer_verp_spec.rb",
    "spec/bounce_processor_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_runtime_dependency(%q<actionmailer>, ["~> 3.0.5"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<actionmailer>, ["~> 3.0.5"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<actionmailer>, ["~> 3.0.5"])
  end
end

