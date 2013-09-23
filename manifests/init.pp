class sshd (
  $listen_port = 22,
  ) {
    case $operatingsystem {
      centos, redhat: {
        $service_name = 'sshd'
        $os_file = 'cent'
      }
      debian, ubuntu: {
        $service_name = 'ssh'
        $os_file = 'debian'
      }
    }
    
    
    file { '/etc/ssh/sshd_config':
      ensure => file,
      mode   => 600,
      content => template("sshd/sshd_config.${os_file}.erb"),
#      source => "puppet:///modules/sshd/sshd_config.$os_file",
    }
    
    service { 'ssh':
      name       => $service_name,
      ensure     => running,
      enable     => true,
      subscribe  => File['/etc/ssh/sshd_config'],
    }
  }
  
