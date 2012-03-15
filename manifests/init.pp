include rvm

$packages = [ 'VirtualBox-4.1', 'git', 'puppet', 'facter', 'curl', 'libxml2', 'libxml2-devel', 'libxslt', 'libxslt-devel' ]

package {$packages:
  ensure => 'present',
  require => Yumrepo['virtualbox'],
}

# virtualbox repository
# virtualbox asc
yumrepo {'virtualbox':
  enabled  => 1,
  gpgcheck => 1,
  gpgkey   => 'http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc',
  baseurl  => 'http://download.virtualbox.org/virtualbox/rpm/fedora/14/$basearch',
  name     => 'virtualbox',
}

yumrepo {'funduntu-testing':
  enabled    => 1,
  mirrorlist => 'http://packages.fuduntu.org/repo/mirrors/fuduntu-testing-rpms-$releasever',
  gpgcheck   => 1,
  gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fuduntu-$basearch',
}

# install rvm
# install ruby-1.9.2 with ssl
# make ruby-1.9.2 the system default
rvm::define::version {'ruby-1.9.2':
  ensure   => 'present',
  system   => 'true',
  ssl      => 'true',
}

# Install Vagrant/Veewee Gems
rvm::devine::gem { ['vagrant', 'veewee']:
  ensure       => 'present',
  ruby_version => '1.9.2',
}
