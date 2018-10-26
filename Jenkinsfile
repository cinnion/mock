def titoBuild(subdir) {
    if (env.BRANCH_NAME =~ /devel/ ) {
        titoArgs = "build --rpm --test --output=${TITODIR}"
    } else {
        titoArgs = "build --rpm --output=${TITODIR}"
    }

    sh """
        pwd
        set
        env
        ls -la
        ( cd ${subdir} && tito ${titoArgs} )
    """
}

pipeline {
    agent any

    environment {
        repoRoot = 'local'
        TITODIR = "${WORKSPACE}/tito"
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
        disableConcurrentBuilds()
    }

    stages {
        stage('Build') {
            steps {
                script {
                    titoBuild 'mock'
                    titoBuild 'mock-core-configs'
                }
            }
        }

        stage('Publish') {
            options {
                skipDefaultCheckout()
            }
            steps {
                script {
                    publishTitoResults
                }
            }
        }
    }
}