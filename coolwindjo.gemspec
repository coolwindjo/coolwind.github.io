# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "coolwindjo"
  spec.version       = "1.0.0"
  spec.authors       = ["CoolWind"]
  spec.email         = ["coolwind@hotmail.co.kr"]

  spec.summary       =  "Blog posts and pages with cool wind"
  spec.description   = %q{Blog posts and pages with cool wind}
  spec.homepage      = "https://github.com/coolwindjo/coolwindjo.github.io"
  spec.license       = "MIT"

  spec.rdoc_options            = ["--charset=UTF-8"]
  spec.extra_rdoc_files        = %w(README.md LICENSE)
  spec.metadata["plugin_type"] = "theme"

  spec.files                   = `git ls-files -z`.split("\x0").select do |f|
    f.match(%r!^(assets/(js|css|fonts|data)/|_(includes|layouts|sass)/|_data/language.yml|(LICENSE|README.md))!i)
  end

  spec.post_install_message =  <<~MSG
                               Thanks for using Type on strap v2+!
                               MSG

  spec.required_ruby_version   = '>= 2.4.0'
    
  spec.add_runtime_dependency "jekyll", ">= 3.8", "< 5.0"
  spec.add_runtime_dependency "jekyll-feed", "~> 0.9"
  spec.add_runtime_dependency "jekyll-paginate", "~> 1.1"
  spec.add_runtime_dependency "jekyll-seo-tag", "~>2.6"
end
