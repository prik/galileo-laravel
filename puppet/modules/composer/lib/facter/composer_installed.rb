Facter.add("composer_installed") do
  setcode do
    if File.exist? "/usr/bin/composer"
      "yes"
    else
      "no"
    end
  end
end