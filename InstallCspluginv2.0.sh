#!/bin/bash 
echo CSPLUGIN INPROGRESS........
VER=`java -version 2>&1 | grep "java version" | awk '{print $3}' | tr -d \" | awk '{split($0, array, ".")} END{print array[2]}'`
OVER=`java -version 2>&1 | grep "openjdk version" | awk '{print $3}' | tr -d \" | awk '{split($0, array, ".")} END{print array[2]}'`
if [ -z != "$VER" -a "$VER" = 7  ]  || [ -z != "$OVER" -a  "$OVER" = 7 ]
then
    echo "Java version is 1.7."
elif [ -z != "$VER" -a "$VER" = 8  ]  || [ -z != "$OVER" -a "$OVER" = 8 ]
then
    echo "Java version is 1.8."
else
    echo "Java version is not supported."
    exit
fi

if [ -z "$1" ]
then
    echo "First parameter must be clientid"
    echo "usage : curl https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install_csplugin/InstallCsplugin.sh | bash -s clientid clientidentifier plugin java db"
    exit
elif [ -z != "$1" -a "$1" != "clientid"  ]
then
    echo "Incorrect first parameter! first parameter must be clientid"
    echo "usage : curl https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install_csplugin/InstallCsplugin.sh | bash -s clientid clientidentifier plugin java db"
    exit
fi

regex='^([0-9A-Za-z-]+)+$'
if [ -z "$2" ]
then
    echo "Second parameter must be clientidentifier"
    echo "usage : curl https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install_csplugin/InstallCsplugin.sh | bash -s clientid clientidentifier plugin java db"
    exit
fi

if  [[ "$2" =~ $regex ]]
then
    echo ""
else
    echo "Incorrect second parameter! , clientidentifier could be alpha-numric value and hypen is also allowed."
    echo "usage : curl https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install_csplugin/InstallCsplugin.sh | bash -s clientid clientidentifier plugin java db"
    exit
fi


if [ -z "$3" ]
then
    echo "Third parameter must be plugin"
    echo "usage : curl https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install_csplugin/InstallCsplugin.sh | bash -s clientid clientidentifier plugin java db"
    exit
elif [ -z != "$3" -a "$3" != "plugin"  ]
then
    echo "Incorrect third parameter! third parameter must be -plugin"
    echo "usage : curl https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install_csplugin/InstallCsplugin.sh | bash -s clientid clientidentifier plugin java db"
    exit
fi
UVER=`lsb_release -ds  2>&1 | grep "Ubuntu" | awk '{print $2}' | awk '{split($0, array, ".")} END{print array[1]}'`
if [ -z != "$4" -a "$4" = "java"  ]  && [ -z "$5" ]
then
    echo "====================================="
    echo " Downloading CSPLUGIN JAVA SERVICE"
   echo "======================================"
   if [ -z != "$UVER" -a "$UVER" = 16 ]
    then
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/install-serviceunit/cspluginjavaservice.service
        sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" cspluginjavaservice.service
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/cspluginjavaservice
        sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" cspluginjavaservice
     else 
       sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/cspluginjavaservice
       sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" cspluginjavaservice
     fi
     
elif [ -z != "$4" -a "$4" = "cpp"  ]  && [ -z "$5" ]
then
    echo "====================================="
    echo "  Downloading CSPLUGIN CPP SERVICE"
   echo "======================================"
    if [ -z != "$UVER" -a "$UVER" = 16 ]
    then
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/install-serviceunit/csplugincppservice.service
        sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" csplugincppservice.service
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/csplugincppservice
        sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" csplugincppservice
     else 
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/csplugincppservice
        sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" csplugincppservice
     fi
     
elif [ -z != "$4" -a "$4" = "db"  ]  && [ -z "$5" ]
then
    echo "====================================="
    echo "  Downloading CSPLUGIN DB SERVICE"
   echo "======================================"
    if [ -z != "$UVER" -a "$UVER" = 16 ]
    then
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/install-serviceunit/csplugindbservice.service
        sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" csplugindbservice.service
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/csplugindbservice
        sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" csplugindbservice
     else 
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/csplugindbservice
        sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" csplugindbservice
     fi
     
elif ( [ -z != "$4" -a "$4" = "java" ] && [ -z != "$5" -a "$5" = "db" ]  && [ -z "$6" ] ) ||( [ -z != "$4" -a "$4" = "db" ] && [ -z != "$5" -a "$5" = "java" ]  && [ -z "$6" ])
then
    echo "========================================="
    echo " Downloading CSPLUGIN JAVA & DB SERVICE " 
    echo "========================================="
    if [ -z != "$UVER" -a "$UVER" = 16 ]
    then
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/install-serviceunit/cspluginjavadbservice.service
        sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" cspluginjavadbservice.service
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/cspluginjavadbservice
        sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" cspluginjavadbservice
     else 
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/cspluginjavadbservice
        sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" cspluginjavadbservice
     fi

     elif ([ -z != "$4" -a "$4" = "java" ] && [ -z != "$5" -a "$5" = "httpproxy" ]  && [ -z "$6" ])||([ -z != "$4" -a "$4" = "httpproxy" ] && [ -z != "$5" -a "$5" = "java" ]  && [ -z "$6" ])
then
    echo "====================================================="
    echo "   Downloading CSPLUGIN JAVA & HTTPPROXY SERVICE " 
    echo "====================================================="
    if [ -z != "$UVER" -a "$UVER" = 16 ]
    then
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/install-serviceunit/cspluginjavahttpproxyservice.service
        sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" cspluginjavahttpproxyservice.service
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/cspluginjavahttpproxyservice
        sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" cspluginjavahttpproxyservice
     else 
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/cspluginjavahttpproxyservice
        sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" cspluginjavahttpproxyservice
     fi

elif ([ -z != "$4" -a "$4" = "cpp" ] && [ -z != "$5" -a "$5" = "db" ]  && [ -z "$6" ])||([ -z != "$4" -a "$4" = "db" ] && [ -z != "$5" -a "$5" = "cpp" ]  && [ -z "$6" ])
then
    echo "==============================================="
    echo "   Downloading CSPLUGIN CPP & DB SERVICE "
    echo "==============================================="
        if [ -z != "$UVER" -a "$UVER" = 16 ]
        then
                sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/install-serviceunit/csplugincppdbservice.service
                sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" csplugincppdbservice.service
                sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/csplugincppdbservice
                sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" csplugincppdbservice
         else
                sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/csplugincppdbservice
                sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" csplugincppdbservice
         fi

elif ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "cpp" ]  && [ -z "$6" ])||([ -z != "$4" -a "$4" = "cpp" ] && [ -z != "$5" -a "$5" = "java" ]  && [ -z "$6" ])
then
    echo "================================================="
    echo "   Downloading CSPLUGIN CPP & JAVA SERVICE "
    echo "=================================================="
        if [ -z != "$UVER" -a "$UVER" = 16 ]
        then
                sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/install-serviceunit/csplugincppjavaservice.service
                sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" csplugincppjavaservice.service
                sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/csplugincppjavaservice
                sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" csplugincppjavaservice
         else
                sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/csplugincppjavaservice
                sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" csplugincppjavaservice
         fi

elif ([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "db" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z "$7" ] ) ||([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "db" ] && [ -z "$7" ] )||([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z "$7" ] )
then
    echo "======================================================"
    echo "   Downloading CSPLUGIN CPP, JAVA and DB SERVICE "
    echo "======================================================"
        if [ -z != "$UVER" -a "$UVER" = 16 ]
        then
                sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/install-serviceunit/csplugincppjavadbservice.service
                sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" csplugincppjavadbservice.service
                sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/csplugincppjavadbservice
                sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" csplugincppjavadbservice
         else
                sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/csplugincppjavadbservice
                sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" csplugincppjavadbservice
         fi

elif ([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "db" ]) || ([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "db" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z "$7" ] )
then
    echo "=========================================================="
    echo "  Downloading CSPLUGIN JAVA , DB and HTTPPROXY SERVICE "
    echo "=========================================================="
        if [ -z != "$UVER" -a "$UVER" = 16 ]
        then
                sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/install-serviceunit/cspluginjavadbhttpproxyservice.service
                sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" cspluginjavadbhttpproxyservice.service
                sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/cspluginjavadbhttpproxyservice
                sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" cspluginjavadbhttpproxyservice
         else
                sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/cspluginjavadbhttpproxyservice
                sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" cspluginjavadbhttpproxyservice
         fi     
elif ([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z "$7" ] )
then
    echo "============================================================="
    echo "  Downloading CSPLUGIN JAVA , CPP and HTTPPROXY SERVICE "
    echo "============================================================="
        if [ -z != "$UVER" -a "$UVER" = 16 ]
        then
                sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/install-serviceunit/csplugincppjavahttpproxyservice.service
                sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" csplugincppjavahttpproxyservice.service
                sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/csplugincppjavahttpproxyservice
                sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" csplugincppjavahttpproxyservice
         else
                sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/csplugincppjavahttpproxyservice
                sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" csplugincppjavahttpproxyservice
         fi   
elif ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z != "$7" -a "$7" = "cpp" ] ) || ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z != "$7" -a "$7" = "httpproxy" ] ) || ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z != "$7" -a "$7" = "db" ] ) || ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "db" ] && [ -z != "$7" -a "$7" = "httpproxy" ] ) ||([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "db" ] && [ -z != "$7" -a "$7" = "cpp" ] ) ||([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z != "$7" -a "$7" = "db" ] ) ||([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z != "$7" -a "$7" = "cpp" ] ) ||([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z != "$7" -a "$7" = "httpproxy" ] ) ||([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z != "$7" -a "$7" = "cpp" ] ) ||([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z != "$7" -a "$7" = "java" ] ) ||([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z != "$7" -a "$7" = "java" ] ) ||([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z != "$7" -a "$7" = "httpproxy" ] ) ||([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z != "$7" -a "$7" = "cpp" ] ) ||([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z != "$7" -a "$7" = "java" ] ) ||([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "db" ] && [ -z != "$7" -a "$7" = "java" ] ) ||([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z != "$7" -a "$7" = "db" ] ) ||([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "db" ] && [ -z != "$7" -a "$7" = "cpp" ] ) ||([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z != "$7" -a "$7" = "db" ] ) ||([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z != "$7" -a "$7" = "httpproxy" ] ) ||([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z != "$7" -a "$7" = "java" ] ) ||([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z != "$7" -a "$7" = "db" ] ) ||([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "db" ] && [ -z != "$7" -a "$7" = "httpproxy" ] ) ||([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z != "$7" -a "$7" = "db" ] ) ||([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "db" ] && [ -z != "$7" -a "$7" = "java" ] )
   then
    echo "===================================================================="
    echo "  Downloading CSPLUGIN JAVA , HTTPPROXY , DB and CPP SERVICE "
    echo "===================================================================="
        if [ -z != "$UVER" -a "$UVER" = 16 ]
            then
                sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/install-serviceunit/cspluginjavahttpproxydbcppservice.service
                sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" cspluginjavahttpproxydbcppservice.service
                sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/cspluginjavahttpproxydbcppservice
                sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" cspluginjavahttpproxydbcppservice
         else
                sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install-csplugin/cspluginjavahttpproxydbcppservice
                sudo sed -i "s/ENVIRONMENT=.*/ENVIRONMENT=prod/" cspluginjavahttpproxydbcppservice
         fi   
else
    echo "Incorrect Plugin type, Plugin type must be one from java, db, cpp, java db, java cpp, db cpp and java db cpp either their combinations..."
    echo "usage : curl https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install_csplugin/InstallCsplugin.sh | bash -s -clientid clientidentifier plugin java db"
    exit
fi
echo "======================================================"
echo "         Downloading CSPLUGIN Agent JARs"
echo "======================================================"

if [ -z != "$VER" -a "$VER" = 7  ]  || [ -z != "$OVER" -a  "$OVER" = 7 ]
then
    echo "**************************"
    echo "     java version 7"
    echo "**************************"
    sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java7/0.0.1-SNAPSHOT/$2/csp-main-0.0.1-SNAPSHOT-jar-with-dependencies.jar
    sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java7/0.0.1-SNAPSHOT/$2/main-log4j2.properties
    if [ -z != "$4" -a "$4" = "java"  ]  || [ -z != "$5" -a "$5" = "java" ] || [ -z != "$6" -a "$6" = "java" ] || [ -z != "$7" -a "$7" = "java" ]
    then
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java7/0.0.1-SNAPSHOT/$2/csp-java-0.0.1-SNAPSHOT-jar-with-dependencies.jar
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java7/0.0.1-SNAPSHOT/$2/java-log4j2.properties
    fi
    if [ -z != "$4" -a "$4" = "db"  ]  || [ -z != "$5" -a "$5" = "db" ] || [ -z != "$6" -a "$6" = "db" ] || [ -z != "$7" -a "$7" = "db" ]
    then
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java7/0.0.1-SNAPSHOT/$2/csp-db-0.0.1-SNAPSHOT-jar-with-dependencies.jar
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java7/0.0.1-SNAPSHOT/$2/db-log4j2.properties
    fi  
        if [ -z != "$4" -a "$4" = "core"  ]  || [ -z != "$5" -a "$5" = "core" ] || [ -z != "$6" -a "$6" = "core" ] || [ -z != "$7" -a "$7" = "core" ]
        then
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java7/0.0.1-SNAPSHOT/$2/csp-core-0.0.1-SNAPSHOT-jar-with-dependencies.jar    
        fi
    if [ -z != "$4" -a "$4" = "cpp"  ]  || [ -z != "$5" -a "$5" = "cpp" ] || [ -z != "$6" -a "$6" = "cpp" ] || [ -z != "$7" -a "$7" = "cpp" ]
    then
                ./agent_packages.sh 
                ./install_missing_libs.sh
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java7/0.0.1-SNAPSHOT/$2/csp-cpp-0.0.1-SNAPSHOT-jar-with-dependencies.jar 
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java7/0.0.1-SNAPSHOT/$2/CppSourceParser    
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java7/0.0.1-SNAPSHOT/$2/CppProcessFinder
                sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java7/0.0.1-SNAPSHOT/$2/log4cpp.properties
                sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java7/0.0.1-SNAPSHOT/$2/cpp_plugin.config 
                sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java7/0.0.1-SNAPSHOT/$2/cpp-log4j2.properties  
    fi
    if [ -z != "$4" -a "$4" = "httpproxy"  ]  || [ -z != "$5" -a "$5" = "httpproxy" ] || [ -z != "$6" -a "$6" = "httpproxy" ] || [ -z != "$7" -a "$7" = "httpproxy" ]
    then
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java7/0.0.1-SNAPSHOT/531004f0-bd5a-3e32-860e-06e3c622ffa3/csp-httpproxy-0.0.1-SNAPSHOT-jar-with-dependencies.jar
       sudo curl -O https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java7/0.0.1-SNAPSHOT/531004f0-bd5a-3e32-860e-06e3c622ffa3/csp-httpproxyagent-0.0.1-SNAPSHOT-jar-with-dependencies.jar
       sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java7/0.0.1-SNAPSHOT/531004f0-bd5a-3e32-860e-06e3c622ffa3/httpproxy-log4j2.properties
    fi

elif [ -z != "$VER" -a "$VER" = 8  ]  || [ -z != "$OVER" -a  "$OVER" = 8 ]
then
    echo "**************************"
    echo "     java version 8"
    echo "**************************"
    sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java8/0.0.1-SNAPSHOT/$2/csp-main-0.0.1-SNAPSHOT-jar-with-dependencies.jar
    sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java8/0.0.1-SNAPSHOT/$2/main-log4j2.properties
    if [ -z != "$4" -a "$4" = "java"  ]  || [ -z != "$5" -a "$5" = "java" ] || [ -z != "$6" -a "$6" = "java" ] || [ -z != "$7" -a "$7" = "java" ]
    then
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java8/0.0.1-SNAPSHOT/$2/csp-java-0.0.1-SNAPSHOT-jar-with-dependencies.jar
                sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java8/0.0.1-SNAPSHOT/$2/java-log4j2.properties
    fi
    if [ -z != "$4" -a "$4" = "db"  ]  || [ -z != "$5" -a "$5" = "db" ] || [ -z != "$6" -a "$6" = "db" ] || [ -z != "$7" -a "$7" = "db" ]
    then
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java8/0.0.1-SNAPSHOT/$2/csp-db-0.0.1-SNAPSHOT-jar-with-dependencies.jar
                sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java8/0.0.1-SNAPSHOT/$2/db-log4j2.properties
    fi
        if [ -z != "$4" -a "$4" = "core"  ]  || [ -z != "$5" -a "$5" = "core" ] || [ -z != "$6" -a "$6" = "core" ]  || [ -z != "$7" -a "$7" = "core" ]
        then    
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java8/0.0.1-SNAPSHOT/$2/csp-core-0.0.1-SNAPSHOT-jar-with-dependencies.jar    
        fi
    if [ -z != "$4" -a "$4" = "cpp"  ]  || [ -z != "$5" -a "$5" = "cpp" ] || [ -z != "$6" -a "$6" = "cpp" ]  || [ -z != "$7" -a "$7" = "cpp" ]
    then
                ./agent_packages.sh 
                ./install_missing_libs.sh
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java8/0.0.1-SNAPSHOT/$2/csp-cpp-0.0.1-SNAPSHOT-jar-with-dependencies.jar
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java8/0.0.1-SNAPSHOT/$2/CppSourceParser
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java8/0.0.1-SNAPSHOT/$2/CppProcessFinder
                sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java8/0.0.1-SNAPSHOT/$2/log4cpp.properties
                sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java8/0.0.1-SNAPSHOT/$2/cpp_plugin.config
                sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java8/0.0.1-SNAPSHOT/$2/cpp-log4j2.properties
    fi  
    if [ -z != "$4" -a "$4" = "httpproxy"  ]  || [ -z != "$5" -a "$5" = "httpproxy" ] || [ -z != "$6" -a "$6" = "httpproxy" ]  || [ -z != "$7" -a "$7" = "httpproxy" ]
    then
        sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java8/0.0.1-SNAPSHOT/531004f0-bd5a-3e32-860e-06e3c622ffa3/csp-httpproxy-0.0.1-SNAPSHOT-jar-with-dependencies.jar
       sudo curl -O https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java8/0.0.1-SNAPSHOT/531004f0-bd5a-3e32-860e-06e3c622ffa3/csp-httpproxyagent-0.0.1-SNAPSHOT-jar-with-dependencies.jar
       sudo curl -O  https://s3-us-west-2.amazonaws.com/crosscode-csplugin/releasesv1.0/linux/java8/0.0.1-SNAPSHOT/531004f0-bd5a-3e32-860e-06e3c622ffa3/httpproxy-log4j2.properties
    fi
else
    exit
fi
echo "=============================================="
echo "   Moving CSPLUGIN SERVICE & CSPLUGIN JAR"
echo "=============================================="

sudo rm -rf /csplugin
sudo mkdir /csplugin


if [ -z != "$4" -a "$4" = "java"  ]  && [ -z "$5" ]
then    
    
    if [ -z != "$UVER" -a "$UVER" = 16 ]
    then
        sudo cp -v cspluginjavaservice.service /etc/systemd/system/cspluginjavaservice.service
        sudo sed -i -e 's/\r//g' /etc/systemd/system/cspluginjavaservice.service
        sudo mv -v cspluginjavaservice /etc/init.d/cspluginjavaservice
        sudo sed -i -e 's/\r//g' /etc/init.d/cspluginjavaservice
        sudo chmod +x /etc/init.d/cspluginjavaservice
                sudo chmod +x /etc/systemd/system/cspluginjavaservice.service   
     else 
        sudo cp -v cspluginjavaservice /etc/init.d/cspluginjavaservice
        sudo sed -i -e 's/\r//g' /etc/init.d/cspluginjavaservice
        sudo chmod +x /etc/init.d/cspluginjavaservice

     fi
     
elif [ -z != "$4" -a "$4" = "cpp"  ]  && [ -z "$5" ]
then
    
    if [ -z != "$UVER" -a "$UVER" = 16 ]
    then
        sudo cp -v csplugincppservice.service /etc/systemd/system/csplugincppservice.service
        sudo sed -i -e 's/\r//g' /etc/systemd/system/csplugincppservice.service
        sudo chmod +x /etc/systemd/system/csplugincppservice.service
        sudo mv -v csplugincppservice /etc/init.d/csplugincppservice
        sudo sed -i -e 's/\r//g' /etc/init.d/csplugincppservice
        sudo chmod +x /etc/init.d/csplugincppservice        
    else
        sudo cp -v csplugincppservice /etc/init.d/csplugincppservice
        sudo sed -i -e 's/\r//g' /etc/init.d/csplugincppservice
        sudo chmod +x /etc/init.d/csplugincppservice
     fi
     
         
elif [ -z != "$4" -a "$4" = "db"  ]  && [ -z "$5" ]
then
    
    if [ -z != "$UVER" -a "$UVER" = 16 ]
    then
        sudo cp -v csplugindbservice.service /etc/systemd/system/csplugindbservice.service
        sudo sed -i -e 's/\r//g' /etc/systemd/system/csplugindbservice.service
        sudo chmod +x /etc/systemd/system/csplugindbservice.service
        sudo mv -v csplugindbservice /etc/init.d/csplugindbservice
        sudo sed -i -e 's/\r//g' /etc/init.d/csplugindbservice
        sudo chmod +x /etc/init.d/csplugindbservice     
    else
        sudo cp -v csplugindbservice /etc/init.d/csplugindbservice
        sudo sed -i -e 's/\r//g' /etc/init.d/csplugindbservice
        sudo chmod +x /etc/init.d/csplugindbservice
     fi
     
     
elif ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "db" ]  && [ -z "$6" ]) || ([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "java" ]  && [ -z "$6" ])
then
        
    if [ -z != "$UVER" -a "$UVER" = 16 ]
    then
        sudo cp -v cspluginjavadbservice.service /etc/systemd/system/cspluginjavadbservice.service
        sudo sed -i -e 's/\r//g' /etc/systemd/system/cspluginjavadbservice.service
        sudo mv -v cspluginjavadbservice /etc/init.d/cspluginjavadbservice
        sudo sed -i -e 's/\r//g' /etc/init.d/cspluginjavadbservice
        sudo chmod +x /etc/init.d/cspluginjavadbservice
        sudo chmod +x /etc/systemd/system/cspluginjavadbservice.service 
     else 
        sudo cp -v cspluginjavadbservice /etc/init.d/cspluginjavadbservice
        sudo sed -i -e 's/\r//g' /etc/init.d/cspluginjavadbservice
        sudo chmod +x /etc/init.d/cspluginjavadbservice
     fi

 elif ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ]  && [ -z "$6" ]) || ([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "java" ]  && [ -z "$6" ])
then
        
    if [ -z != "$UVER" -a "$UVER" = 16 ]
    then
        sudo cp -v cspluginjavahttpproxyservice.service /etc/systemd/system/cspluginjavahttpproxyservice.service
        sudo sed -i -e 's/\r//g' /etc/systemd/system/cspluginjavahttpproxyservice.service
        sudo mv -v cspluginjavahttpproxyservice /etc/init.d/cspluginjavahttpproxyservice
        sudo sed -i -e 's/\r//g' /etc/init.d/cspluginjavahttpproxyservice
        sudo chmod +x /etc/init.d/cspluginjavahttpproxyservice
        sudo chmod +x /etc/systemd/system/cspluginjavahttpproxyservice.service 
     else 
        sudo cp -v cspluginjavahttpproxyservice /etc/init.d/cspluginjavahttpproxyservice
        sudo sed -i -e 's/\r//g' /etc/init.d/cspluginjavahttpproxyservice
        sudo chmod +x /etc/init.d/cspluginjavahttpproxyservice
     fi

elif ([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "cpp" ]  && [ -z "$6" ]) || ([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "db" ]  && [ -z "$6" ])
then
   
    if [ -z != "$UVER" -a "$UVER" = 16 ]
    then
        sudo cp -v csplugincppdbservice.service /etc/systemd/system/csplugincppdbservice.service
        sudo sed -i -e 's/\r//g' /etc/systemd/system/csplugincppdbservice.service
        sudo mv -v csplugincppdbservice /etc/init.d/csplugincppdbservice
            sudo sed -i -e 's/\r//g' /etc/init.d/csplugincppdbservice
            sudo chmod +x /etc/init.d/csplugincppdbservice
        sudo chmod +x /etc/systemd/system/csplugincppdbservice.service
    else 
            sudo cp -v csplugincppdbservice /etc/init.d/csplugincppdbservice
            sudo sed -i -e 's/\r//g' /etc/init.d/csplugincppdbservice
            sudo chmod +x /etc/init.d/csplugincppdbservice
     fi  

elif ([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "java" ]  && [ -z "$6" ] ) || ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "cpp" ]  && [ -z "$6" ])
then
   
    if [ -z != "$UVER" -a "$UVER" = 16 ]
    then
        sudo cp -v csplugincppjavaservice.service /etc/systemd/system/csplugincppjavaservice.service
        sudo sed -i -e 's/\r//g' /etc/systemd/system/csplugincppjavaservice.service
        sudo mv -v csplugincppjavaservice /etc/init.d/csplugincppjavaservice
            sudo sed -i -e 's/\r//g' /etc/init.d/csplugincppjavaservice
            sudo chmod +x /etc/init.d/csplugincppjavaservice
        sudo chmod +x /etc/systemd/system/csplugincppjavaservice.service
    else 
            sudo cp -v csplugincppjavaservice /etc/init.d/csplugincppjavaservice
            sudo sed -i -e 's/\r//g' /etc/init.d/csplugincppjavaservice
            sudo chmod +x /etc/init.d/csplugincppjavaservice
     fi  

elif ([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "db" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "db" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z "$7" ] )
then

    if [ -z != "$UVER" -a "$UVER" = 16 ]
    then
        sudo cp -v csplugincppjavadbservice.service /etc/systemd/system/csplugincppjavadbservice.service
        sudo sed -i -e 's/\r//g' /etc/systemd/system/csplugincppjavadbservice.service
        sudo mv -v csplugincppjavadbservice /etc/init.d/csplugincppjavadbservice
            sudo sed -i -e 's/\r//g' /etc/init.d/csplugincppjavadbservice
            sudo chmod +x /etc/init.d/csplugincppjavadbservice
        sudo chmod +x /etc/systemd/system/csplugincppjavadbservice.service
    else 
            sudo cp -v csplugincppjavadbservice /etc/init.d/csplugincppjavadbservice
            sudo sed -i -e 's/\r//g' /etc/init.d/csplugincppjavadbservice
            sudo chmod +x /etc/init.d/csplugincppjavadbservice
     fi      

elif ([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "db" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "db" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z "$7" ] )
then
   
    if [ -z != "$UVER" -a "$UVER" = 16 ]
    then
        sudo cp -v cspluginjavadbhttpproxyservice.service /etc/systemd/system/cspluginjavadbhttpproxyservice.service
        sudo sed -i -e 's/\r//g' /etc/systemd/system/cspluginjavadbhttpproxyservice.service
        sudo mv -v cspluginjavadbhttpproxyservice /etc/init.d/cspluginjavadbhttpproxyservice
            sudo sed -i -e 's/\r//g' /etc/init.d/cspluginjavadbhttpproxyservice
            sudo chmod +x /etc/init.d/cspluginjavadbhttpproxyservice
        sudo chmod +x /etc/systemd/system/cspluginjavadbhttpproxyservice.service
    else 
            sudo cp -v cspluginjavadbhttpproxyservice /etc/init.d/cspluginjavadbhttpproxyservice
            sudo sed -i -e 's/\r//g' /etc/init.d/cspluginjavadbhttpproxyservice
            sudo chmod +x /etc/init.d/cspluginjavadbhttpproxyservice
     fi 
elif ([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z "$7" ] )
then    
     
     if [ -z != "$UVER" -a "$UVER" = 16 ]
    then
        sudo cp -v csplugincppjavahttpproxyservice.service /etc/systemd/system/csplugincppjavahttpproxyservice.service
        sudo sed -i -e 's/\r//g' /etc/systemd/system/csplugincppjavahttpproxyservice.service
        sudo mv -v csplugincppjavahttpproxyservice /etc/init.d/csplugincppjavahttpproxyservice
            sudo sed -i -e 's/\r//g' /etc/init.d/csplugincppjavahttpproxyservice
            sudo chmod +x /etc/init.d/csplugincppjavahttpproxyservice
        sudo chmod +x /etc/systemd/system/csplugincppjavahttpproxyservice.service
    else 
            sudo cp -v csplugincppjavahttpproxyservice /etc/init.d/csplugincppjavahttpproxyservice
            sudo sed -i -e 's/\r//g' /etc/init.d/csplugincppjavahttpproxyservice
            sudo chmod +x /etc/init.d/csplugincppjavahttpproxyservice
     fi 
elif ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z != "$7" -a "$7" = "cpp" ] ) || ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z != "$7" -a "$7" = "httpproxy" ] ) || ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z != "$7" -a "$7" = "db" ] ) || ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "db" ] && [ -z != "$7" -a "$7" = "httpproxy" ] ) ||([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "db" ] && [ -z != "$7" -a "$7" = "cpp" ] ) ||([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z != "$7" -a "$7" = "db" ] ) ||([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z != "$7" -a "$7" = "cpp" ] ) ||([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z != "$7" -a "$7" = "httpproxy" ] ) ||([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z != "$7" -a "$7" = "cpp" ] ) ||([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z != "$7" -a "$7" = "java" ] ) ||([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z != "$7" -a "$7" = "java" ] ) ||([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z != "$7" -a "$7" = "httpproxy" ] ) ||([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z != "$7" -a "$7" = "cpp" ] ) ||([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z != "$7" -a "$7" = "java" ] ) ||([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "db" ] && [ -z != "$7" -a "$7" = "java" ] ) ||([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z != "$7" -a "$7" = "db" ] ) ||([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "db" ] && [ -z != "$7" -a "$7" = "cpp" ] ) ||([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z != "$7" -a "$7" = "db" ] ) ||([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z != "$7" -a "$7" = "httpproxy" ] ) ||([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z != "$7" -a "$7" = "java" ] ) ||([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z != "$7" -a "$7" = "db" ] ) ||([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "db" ] && [ -z != "$7" -a "$7" = "httpproxy" ] ) ||([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z != "$7" -a "$7" = "db" ] ) ||([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "db" ] && [ -z != "$7" -a "$7" = "java" ] )
     then    
     
     if [ -z != "$UVER" -a "$UVER" = 16 ]
    then
        sudo cp -v cspluginjavahttpproxydbcppservice.service /etc/systemd/system/cspluginjavahttpproxydbcppservice.service
        sudo sed -i -e 's/\r//g' /etc/systemd/system/cspluginjavahttpproxydbcppservice.service
        sudo mv -v cspluginjavahttpproxydbcppservice /etc/init.d/cspluginjavahttpproxydbcppservice
            sudo sed -i -e 's/\r//g' /etc/init.d/cspluginjavahttpproxydbcppservice
            sudo chmod +x /etc/init.d/cspluginjavahttpproxydbcppservice
        sudo chmod +x /etc/systemd/system/cspluginjavahttpproxydbcppservice.service
    else 
            sudo cp -v cspluginjavahttpproxydbcppservice /etc/init.d/cspluginjavahttpproxydbcppservice
            sudo sed -i -e 's/\r//g' /etc/init.d/cspluginjavahttpproxydbcppservice
            sudo chmod +x /etc/init.d/cspluginjavahttpproxydbcppservice
     fi 
else
    echo "Incorrect Plugin type, Plugin type must be either java or db or java db"
    echo "usage : curl https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install_csplugin/InstallCsplugin.sh | bash -s -clientid clientidentifier plugin java db"
    exit
fi

echo "========================================================="
echo "Providing Permissions to CSPLUGIN SERVICE & CSPLUGIN JAR"
echo "========================================================="
sudo cp -v csp-main-0.0.1-SNAPSHOT-jar-with-dependencies.jar  /etc/init.d/csp-main-0.0.1-SNAPSHOT-jar-with-dependencies.jar
sudo cp -v main-log4j2.properties  /etc/init.d/main-log4j2.properties
sudo cp -v main-log4j2.properties  /main-log4j2.properties
if [ -z != "$4" -a "$4" = "java"  ]  || [ -z != "$5" -a "$5" = "java" ] || [ -z != "$6" -a "$6" = "java" ] || [ -z != "$7" -a "$7" = "java" ] 
then
    sudo cp -v csp-java-0.0.1-SNAPSHOT-jar-with-dependencies.jar  /csplugin/csp-java-0.0.1-SNAPSHOT-jar-with-dependencies.jar
        sudo cp -v java-log4j2.properties  /csplugin/java-log4j2.properties
        sudo cp -v java-log4j2.properties  /java-log4j2.properties
fi
if [ -z != "$4" -a "$4" = "db"  ]  || [ -z != "$5" -a "$5" = "db" ] || [ -z != "$6" -a "$6" = "db" ] || [ -z != "$7" -a "$7" = "db" ] 
then
    sudo cp -v csp-db-0.0.1-SNAPSHOT-jar-with-dependencies.jar  /csplugin/csp-db-0.0.1-SNAPSHOT-jar-with-dependencies.jar
        sudo cp -v db-log4j2.properties  /csplugin/db-log4j2.properties
        sudo cp -v db-log4j2.properties  /db-log4j2.properties
fi
if [ -z != "$4" -a "$4" = "core"  ]  || [ -z != "$5" -a "$5" = "core" ] || [ -z != "$6" -a "$6" = "core" ] || [ -z != "$7" -a "$7" = "core" ] 
then    
    sudo cp -v csp-core-0.0.1-SNAPSHOT-jar-with-dependencies.jar  /csplugin/csp-core-0.0.1-SNAPSHOT-jar-with-dependencies.jar
fi
if [ -z != "$4" -a "$4" = "cpp"  ]  || [ -z != "$5" -a "$5" = "cpp" ] || [ -z != "$6" -a "$6" = "cpp" ] || [ -z != "$7" -a "$7" = "cpp" ] 
then
    sudo cp -v csp-cpp-0.0.1-SNAPSHOT-jar-with-dependencies.jar  /csplugin/csp-cpp-0.0.1-SNAPSHOT-jar-with-dependencies.jar
    sudo cp -v CppSourceParser  /csplugin/CppSourceParser
    sudo cp -v CppProcessFinder  /csplugin/CppProcessFinder
        sudo cp -v log4cpp.properties  /csplugin/log4cpp.properties
        sudo cp -v cpp_plugin.config  /csplugin/cpp_plugin.config
        sudo cp -v cpp-log4j2.properties  /csplugin/cpp-log4j2.properties
        sudo cp -v cpp-log4j2.properties  /cpp-log4j2.properties
fi  
if [ -z != "$4" -a "$4" = "httpproxy"  ]  || [ -z != "$5" -a "$5" = "httpproxy" ] || [ -z != "$6" -a "$6" = "httpproxy" ] || [ -z != "$7" -a "$7" = "httpproxy" ] 
then    
    sudo cp -v csp-httpproxy-0.0.1-SNAPSHOT-jar-with-dependencies.jar  /csplugin/csp-httpproxy-0.0.1-SNAPSHOT-jar-with-dependencies.jar
    sudo cp -v csp-httpproxyagent-0.0.1-SNAPSHOT-jar-with-dependencies.jar  /csplugin/csp-httpproxyagent-0.0.1-SNAPSHOT-jar-with-dependencies.jar
    sudo cp -v httpproxy-log4j2.properties /csplugin/httpproxy-log4j2.properties
fi
sudo chmod +x /etc/init.d/csp-main-0.0.1-SNAPSHOT-jar-with-dependencies.jar
sudo chmod +x /etc/init.d/main-log4j2.properties
sudo chmod +x /main-log4j2.properties
if [ -z != "$4" -a "$4" = "java"  ]  || [ -z != "$5" -a "$5" = "java" ] || [ -z != "$6" -a "$6" = "java" ] || [ -z != "$7" -a "$7" = "java" ] 
then
    sudo chmod +x /csplugin/csp-java-0.0.1-SNAPSHOT-jar-with-dependencies.jar
        sudo chmod +x /csplugin/java-log4j2.properties
        sudo chmod +x /java-log4j2.properties
fi
if [ -z != "$4" -a "$4" = "db"  ]  || [ -z != "$5" -a "$5" = "db" ] || [ -z != "$6" -a "$6" = "db" ] || [ -z != "$7" -a "$7" = "db" ] 
then
    sudo chmod +x /csplugin/csp-db-0.0.1-SNAPSHOT-jar-with-dependencies.jar
    sudo chmod +x /csplugin/db-log4j2.properties
        sudo chmod +x /db-log4j2.properties
fi
if [ -z != "$4" -a "$4" = "core"  ]  || [ -z != "$5" -a "$5" = "core" ] || [ -z != "$6" -a "$6" = "core" ] || [ -z != "$7" -a "$7" = "core" ] 
then
    sudo chmod +x /csplugin/csp-core-0.0.1-SNAPSHOT-jar-with-dependencies.jar
fi
if [ -z != "$4" -a "$4" = "cpp"  ]  || [ -z != "$5" -a "$5" = "cpp" ] || [ -z != "$6" -a "$6" = "cpp" ] || [ -z != "$7" -a "$7" = "cpp" ] 
then
    sudo chmod +x /csplugin/csp-cpp-0.0.1-SNAPSHOT-jar-with-dependencies.jar
    sudo chmod +x /csplugin/CppSourceParser
    sudo chmod +x /csplugin/CppProcessFinder
        sudo chmod +x /csplugin/log4cpp.properties
        sudo chmod +x /csplugin/cpp_plugin.config
    sudo chmod +x /csplugin/cpp-log4j2.properties
        sudo chmod +x /cpp-log4j2.properties
fi
if [ -z != "$4" -a "$4" = "httpproxy"  ]  || [ -z != "$5" -a "$5" = "httpproxy" ] || [ -z != "$6" -a "$6" = "httpproxy" ] || [ -z != "$7" -a "$7" = "httpproxy" ] 
then 
     sudo chmod +x /csplugin/csp-httpproxy-0.0.1-SNAPSHOT-jar-with-dependencies.jar
     sudo chmod +x  /csplugin/csp-httpproxyagent-0.0.1-SNAPSHOT-jar-with-dependencies.jar
     sudo chmod +x /csplugin/httpproxy-log4j2.properties
fi

echo "=================================="
echo "Checking Operating System Version"
echo "=================================="

UVER=`lsb_release -ds  2>&1 | grep "Ubuntu" | awk '{print $2}' | awk '{split($0, array, ".")} END{print array[1]}'`
if [ -z != "$UVER" -a "$UVER" = 16 ] || [ -z != "$UVER" -a "$UVER" = 14 ]
then
    echo "Ubuntu"$UVER
    sudo systemctl daemon-reload
    echo "Service Start Inprogress..."
    if [ -z != "$4" -a "$4" = "java"  ]  && [ -z "$5" ]
    then     
        
        sudo service cspluginjavaservice start      
        echo "cspluginjavaservice started"
    elif [ -z != "$4" -a "$4" = "cpp"  ]  && [ -z "$5" ]
    then
        
        sudo service csplugincppservice start
        echo "csplugincppservice started "  
    elif [ -z != "$4" -a "$4" = "db"  ]  && [ -z "$5" ]
    then
        
        sudo service csplugindbservice start
        echo "csplugindbservice started "
    
    elif ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "db" ]  && [ -z "$6" ]) || ([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "java" ]  && [ -z "$6" ])
    then        
        sudo service cspluginjavadbservice start
        echo "cspluginjavadbservice started"

    elif ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ]  && [ -z "$6" ]) || ([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "java" ]  && [ -z "$6" ])
    then        
        sudo service cspluginjavahttpproxyservice start
        echo "cspluginjavahttpproxyservice started" 

    elif ([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "cpp" ]  && [ -z "$6" ]) || ([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "db" ]  && [ -z "$6" ])
    then       
        sudo service csplugincppdbservice start
        echo "csplugincppdbservice started" 
    
    elif ([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "java" ]  && [ -z "$6" ]) || ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "cpp" ]  && [ -z "$6" ])
     then     
        
        sudo service csplugincppjavaservice start
        echo "csplugincppjavaservice started"           
            
    elif ([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "db" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "db" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z "$7" ] )
   then     
        
        sudo service csplugincppjavadbservice start
        echo "csplugincppjavadbservice started"                 
   
     elif ([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "db" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "db" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z "$7" ] )
     then     
        
        sudo service cspluginjavadbhttpproxyservice start
        echo "cspluginjavadbhttpproxyservice started"                 
    
   elif ([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z "$7" ] ) || ([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z "$7" ] )
   then     
        
        sudo service csplugincppjavahttpproxyservice start
        echo "csplugincppjavahttpproxyservice started"   

    elif ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z != "$7" -a "$7" = "cpp" ] ) || ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z != "$7" -a "$7" = "httpproxy" ] ) || ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z != "$7" -a "$7" = "db" ] ) || ([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "db" ] && [ -z != "$7" -a "$7" = "httpproxy" ] ) ||([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "db" ] && [ -z != "$7" -a "$7" = "cpp" ] ) ||([ -z != "$4" -a "$4" = "java"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z != "$7" -a "$7" = "db" ] ) ||([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z != "$7" -a "$7" = "cpp" ] ) ||([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z != "$7" -a "$7" = "httpproxy" ] ) ||([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z != "$7" -a "$7" = "cpp" ] ) ||([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z != "$7" -a "$7" = "java" ] ) ||([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z != "$7" -a "$7" = "java" ] ) ||([ -z != "$4" -a "$4" = "db"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z != "$7" -a "$7" = "httpproxy" ] ) ||([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z != "$7" -a "$7" = "cpp" ] ) ||([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z != "$7" -a "$7" = "java" ] ) ||([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "db" ] && [ -z != "$7" -a "$7" = "java" ] ) ||([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "cpp" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z != "$7" -a "$7" = "db" ] ) ||([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "db" ] && [ -z != "$7" -a "$7" = "cpp" ] ) ||([ -z != "$4" -a "$4" = "httpproxy"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "cpp" ] && [ -z != "$7" -a "$7" = "db" ] ) ||([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z != "$7" -a "$7" = "httpproxy" ] ) ||([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "db" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z != "$7" -a "$7" = "java" ] ) ||([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "httpproxy" ] && [ -z != "$7" -a "$7" = "db" ] ) ||([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "java" ] && [ -z != "$6" -a "$6" = "db" ] && [ -z != "$7" -a "$7" = "httpproxy" ] ) ||([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "java" ] && [ -z != "$7" -a "$7" = "db" ] ) ||([ -z != "$4" -a "$4" = "cpp"  ]  && [ -z != "$5" -a "$5" = "httpproxy" ] && [ -z != "$6" -a "$6" = "db" ] && [ -z != "$7" -a "$7" = "java" ] )
    then     
        
        sudo service cspluginjavahttpproxydbcppservice start
        echo "cspluginjavahttpproxydbcppservice started"            
                             
    else
        echo "Incorrect Plugin type, Plugin type must be either java or db or java db"
        echo "usage : curl https://s3-us-west-2.amazonaws.com/crosscode-csplugin/install_csplugin/InstallCsplugin.sh | bash -s clientid clientidentifier plugin java db"
        exit
        
    fi

fi
