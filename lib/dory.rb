Gem.find_files('dory/**/*.rb').each do |path|
  require path.gsub(/\.rb$/, '') unless path =~ /bot.*cli/
end
