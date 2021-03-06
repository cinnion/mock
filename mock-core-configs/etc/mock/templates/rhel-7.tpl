config_opts['chroot_setup_cmd'] = 'install bash bzip2 coreutils cpio diffutils findutils gawk gcc gcc-c++ grep gzip info make patch redhat-rpm-config rpm-build sed shadow-utils tar unzip util-linux which xz'
config_opts['dist'] = 'el7'  # only useful for --resultdir variable subst
config_opts['releasever'] = '7Server'

config_opts['dnf_install_command'] += ' subscription-manager https://kojipkgs.fedoraproject.org//packages/distribution-gpg-keys/1.34/1.el7/noarch/distribution-gpg-keys-1.34-1.el7.noarch.rpm'
config_opts['yum_install_command'] += ' subscription-manager https://kojipkgs.fedoraproject.org//packages/distribution-gpg-keys/1.34/1.el7/noarch/distribution-gpg-keys-1.34-1.el7.noarch.rpm'

config_opts['root'] = 'rhel-7-{{ target_arch }}'

config_opts['redhat_subscription_required'] = True

config_opts['yum.conf'] = """
[main]
keepcache=1
debuglevel=2
reposdir=/dev/null
logfile=/var/log/yum.log
retries=20
obsoletes=1
gpgcheck=1
assumeyes=1
syslog_ident=mock
syslog_device=
best=1
protected_packages=

# repos

[rhel]
name = Red Hat Enterprise Linux
baseurl = https://cdn.redhat.com/content/dist/rhel/server/7/$releasever/$basearch/os
sslverify = 1
sslcacert = /etc/rhsm/ca/redhat-uep.pem
sslclientkey = /etc/pki/entitlement/{{ redhat_subscription_key_id }}-key.pem
sslclientcert = /etc/pki/entitlement/{{ redhat_subscription_key_id }}.pem
gpgkey=file:///usr/share/distribution-gpg-keys/redhat/RPM-GPG-KEY-redhat7-release
skip_if_unavailable=False

[rhel-optional]
name = Red Hat Enterprise Linux - Optional
baseurl = https://cdn.redhat.com/content/dist/rhel/server/7/$releasever/$basearch/optional/os
sslverify = 1
sslcacert = /etc/rhsm/ca/redhat-uep.pem
sslclientkey = /etc/pki/entitlement/{{ redhat_subscription_key_id }}-key.pem
sslclientcert = /etc/pki/entitlement/{{ redhat_subscription_key_id }}.pem
gpgkey=file:///usr/share/distribution-gpg-keys/redhat/RPM-GPG-KEY-redhat7-release
skip_if_unavailable=False

[rhel-extras]
name = Red Hat Enterprise Linux - Extras
baseurl = https://cdn.redhat.com/content/dist/rhel/server/7/7Server/$basearch/extras/os
enabled=0
sslverify = 1
sslcacert = /etc/rhsm/ca/redhat-uep.pem
sslclientkey = /etc/pki/entitlement/{{ redhat_subscription_key_id }}-key.pem
sslclientcert = /etc/pki/entitlement/{{ redhat_subscription_key_id }}.pem
gpgkey=file:///usr/share/distribution-gpg-keys/redhat/RPM-GPG-KEY-redhat7-release
skip_if_unavailable=False
"""
