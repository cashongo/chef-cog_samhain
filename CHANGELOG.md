# 0.4.1
- fix tag/version mismatch

# 0.3.3
- /var/log/nginx/error.log should be handled as logfile

# 0.3.2
- Samhain version 4.2.0

# 0.3.1
- Samhain version 4.1.5

# 0.3.0
- Samhain version 4.1.4

# 0.2.3
- Exclude /etc/datahub/s3-local directory

# 0.2.2
- Add environment variable that can disable samhain start

# 0.2.1
- exclude chef-client php and npm caches from /etc

# 0.2.0
- update Samhain to 4.1.2
- update config for datahub

# 0.1.6
- do not check /etc/ld.so.cache
- do not check /var/lib/clamav
- do not check /var/lib/NetworkManager

# 0.1.5
- change samhain to check files once a day
- do not check suricata's eve.json

# 0.1.4
- remove NTP dir
- remove nginx tmp
- add user file monitoring
- possibility to trigger reinstall

# 0.1.3
- make it work on ubuntu

# 0.1.2
- remove fail2ban from samhain

# 0.1.1
- remove mysql from samhain
- reload samhain on conf file change
- daemonize, shorter init time

# 0.1.0
- initial commit
