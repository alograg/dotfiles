#!/bin/bash
yum clean all
rm -rf /var/cache/yum
rm -rf /var/tmp/yum-*
find /var -name "*.log" \( \( -size +50M -mtime +7 \) -o -mtime +30 \) -exec truncate {} --size 0 \;
package-cleanup --quiet --leaves --exclude-bin
package-cleanup --quiet --leaves --exclude-bin | xargs yum remove -y
package-cleanup --oldkernels --count=1
rm -rf /root/.composer/cache
rm -rf /home/*/.cache/composer
find -regex ".*/core\.[0-9]+$" -delete
find /var/www/*/ -name error_log -delete
rm -rf /root/.npm /home/*/.npm /root/.node-gyp /home/*/.node-gyp /tmp/npm-*
