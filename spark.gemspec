# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{spark}
  s.version = "0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["elliottcable"]
  s.date = %q{2009-08-04}
  s.description = %q{Rakes are for chumps. *Real* men ignite their specks with sparks!}
  s.email = ["Spark@elliottcable.com"]
  s.extra_rdoc_files = ["lib/spark/core_ext/string.rb", "lib/spark/core_ext.rb", "lib/spark/rake/speck_task.rb", "lib/spark.rb", "README.markdown"]
  s.files = ["lib/spark/core_ext/string.rb", "lib/spark/core_ext.rb", "lib/spark/rake/speck_task.rb", "lib/spark.rb", "Rakefile.rb", "README.markdown", ".manifest", "spark.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/elliottcable/spark}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Spark", "--main", "README.markdown"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{speck}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Rakes are for chumps. *Real* men ignite their specks with sparks!}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<speck>, [">= 0"])
      s.add_development_dependency(%q<echoe>, [">= 0", "= 3.0.2"])
      s.add_development_dependency(%q<slack>, [">= 0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<maruku>, [">= 0"])
    else
      s.add_dependency(%q<speck>, [">= 0"])
      s.add_dependency(%q<echoe>, [">= 0", "= 3.0.2"])
      s.add_dependency(%q<slack>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<maruku>, [">= 0"])
    end
  else
    s.add_dependency(%q<speck>, [">= 0"])
    s.add_dependency(%q<echoe>, [">= 0", "= 3.0.2"])
    s.add_dependency(%q<slack>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<maruku>, [">= 0"])
  end
end
