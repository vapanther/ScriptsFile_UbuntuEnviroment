#!/bin/bash 
echo "File execution Started"
sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java8/0.0.1-SNAPSHOT/531004f0-bd5a-3e32-860e-06e3c622ffa3/csp-httpproxyagent-0.0.1-SNAPSHOT-jar-with-dependencies.jar
sudo wget https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java8/0.0.1-SNAPSHOT/531004f0-bd5a-3e32-860e-06e3c622ffa3/csp-httpproxyagent-0.0.1-SNAPSHOT-jar-with-dependencies.jar
echo "finish"