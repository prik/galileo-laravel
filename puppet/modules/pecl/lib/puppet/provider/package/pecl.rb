require 'puppet/provider/package'

Puppet::Type.type(:package).provide :pecl, :parent => ::Puppet::Provider::Package do

  desc "PHP extensions via `pecl`."

  commands :pecl => '/usr/bin/pecl'

  has_feature :installable, :uninstallable, :upgradeable, :versionable

  def self.instances
    packages = [] 
    ver = `/usr/bin/pecl list`
    semver = /^(\w+)\s*((?:\d+\.\d+\.\d+)(?:-(?:[0-9A-Za-z-]+(?:\.[0-9A-Za-z-]+)*))?(?:\+(?:[0-9A-Za-z-]+(?:\.[0-9A-Za-z-]+)*))?)\s*(\w+)$/
    ver.scan(semver) do |package|
      opts = {:ensure => "#{package[1]}}" , :name => package[0], :provider => name}
      packages << self.new(opts)
    end
    packages
  end

  def latest
    semver = /(\d+\.\d+\.\d+)(-([0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*))?(\+([0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*))?/
    ver = `/usr/bin/pecl info #{@resource[:name]} | grep 'Release Version'`
    ver = semver.match(ver)[1].strip
    return ver
  end

  # Install a package. 
  def install
    semver = /(\d+\.\d+\.\d+)(-([0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*))?(\+([0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*))?/

    args = 'install -o '
    if @resource[:source]
      args << "#{@resource[:source]}/"
    end

    args << @resource[:name]

    if @resource[:ensure].to_s.match(semver)
      args << "-#{@resource[:ensure]}"
    end

    cmd = "/usr/bin/pecl #{args}"

    system(cmd)

    File.open("/etc/php5/conf.d/10-#{@resource[:name]}.ini", 'w') { |f| 
      f.write("extension=#{@resource[:name]}.so") 
    }
  end

  # Uninstall a package. 
  def uninstall
    `/usr/bin/pecl uninstall #{@resource[:name]}`
    File.delete("/etc/php5/conf.d/10-#{@resource[:name]}.ini")
  end

  def update
    `/usr/bin/pecl upgrade -o #{@resource[:name]}`
  end

 def query
    self.class.instances.each do |prov|
      return prov.properties if @resource[:name] == prov.name
    end
    return nil
  end

end