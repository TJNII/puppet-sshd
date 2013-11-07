# Copyright 2013 Tom Noonan II (TJNII)
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# 
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
  
