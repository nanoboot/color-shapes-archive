pipeline 
/*
Requirements:

Following variables are set in Jenkins:
 * TOMCAT10_HOME
 * TOMCAT10_TEST_HOME

Maven is Installed

Java 19 is installed

Following Systemd services are installed:
tomcat10
tomcat10test

*/
{
    agent any
    environment {
    	AAA = 'aaa'
    }
    stages
    {
        stage('Build')
        {
            steps {
            
	            echo "*** Building ${env.JOB_NAME} ***"
    		    sh '''
    		        #!/bin/bash
    		        echo JOB_NAME=$JOB_NAME

    		        mvn clean install -X
    		        
    		        echo "Build of $JOB_NAME was successful"
    		        '''
            }
        }
        
        stage('Deploy')
        {
            steps {
                echo "*** Deploying ${env.JOB_NAME} ***"
              
    		    sh '''
    		        #!/bin/bash
    		        
    		        #echo "Nothing to do"
    		        #exit

    		        if [ -z "$TOMCAT10_HOME" ]
                        then
                              echo "KO : Variable TOMCAT10_HOME is empty. You fix this issue by adding this variable to configuration of Jenkins."
                              exit 1
                        else
                              echo "OK : Variable TOMCAT10_HOME is NOT empty"
                        fi

    		        if [ -z "$TOMCAT10_TEST_HOME" ]
                        then
                              echo "KO : Variable TOMCAT10_TEST_HOME is empty. You fix this issue by adding this variable to configuration of Jenkins."
                              exit 1
                        else
                              echo "OK : Variable TOMCAT10_TEST_HOME is NOT empty"
                        fi

    		        case $BRANCH_NAME in

    		          master | deploy_prod)
                        echo Branch $BRANCH_NAME is supported. Continuing.
                        TOMCAT_HOME=$TOMCAT10_HOME
                        systemdService=tomcat10
        		        ;;
    		        
      		          develop | jenkins | deploy_test)
        		        echo Branch $BRANCH_NAME is supported. Continuing.
                        TOMCAT_HOME=$TOMCAT10_TEST_HOME
                        systemdService=tomcat10test
        		        ;;
    		        
      		        *)
        		        echo Branch $BRANCH_NAME is not supported. A failure happened. Exiting.
                        exit 1
        		        ;;
    		        esac

                        mv color-shapes-archive-web/target/color-shapes-archive-web-*.war colorshapesarchive.war
                        

                        currentDir=`pwd`&&cd $TOMCAT_HOME/bin
                        #./catalina.sh stop
                        sudo systemctl stop $systemdService
                        sleep 5

                        if [ -f "$TOMCAT_HOME/webapps/colorshapesarchive.war" ]; then
                            rm $TOMCAT_HOME/webapps/colorshapesarchive.war
                        fi

                        if [ -f "$TOMCAT_HOME/webapps/colorshapesarchive" ]; then
                            rm -r $TOMCAT_HOME/webapps/colorshapesarchive
                        fi
                        mv $currentDir/colorshapesarchive.war $TOMCAT_HOME/webapps
                        
                        #(
                        #  set -e
                        #  export BUILD_ID=dontKillMe
                        #  export JENKINS_NODE_COOKIE=dontKillMe
                        #  ./catalina.sh start &
                        #) &
                        sudo systemctl start $systemdService

                        cd $currentDir

    		       '''
	          
            }
        }
    }
}

