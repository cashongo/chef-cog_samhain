default['cog_samhain']['samhain_version']  = '4.2.0'

case node['platform_family']
when 'rhel'
  default['cog_samhain']['packages']  = ['gcc','make','libattr-devel','libacl-devel','pcre-devel','audit-libs-devel','zlib-devel']
when 'debian'
  default['cog_samhain']['packages'] =  ['libaudit-dev','gcc','make','libattr1-dev','libacl1-dev','libpcre3-dev','zlib1g-dev']
end

default['cog_samhain']['samhain_build_options'] = '--enable-logfile-monitor --enable-process-check --enable-login-watch --enable-port-check --enable-db-reload --enable-userfiles'
