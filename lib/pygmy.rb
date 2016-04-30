Gem.find_files('pygmy/**/*.rb').each do |path|
  require path.gsub(/\.rb$/, '') unless path =~ /bot.*cli/
end
