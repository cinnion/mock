def titoBuild(subdir) {
    return {
        stage("build: $subdir") {
            steps {
                sh """
                    env
                    cd ${subdir}
                    tito ${titoArgs}
                """
            }
        }
    }
}

pipeline {
    agent any

    environment {
        repoRoot = 'local'
        TITODIR = "${WORKSPACE}/tito"
        if (env.BRANCH_NAME ==~ /devel/ ) {
            titoArgs = "--build --rpm --test --output=${TITODIR}"
        } else {
            titoArgs = "--build --rpm --output=${TITODIR}"
        }
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '5'))
        disableConcurrentBuilds()
    }

    stages {
        stage('Build') {
            titoBuild 'mock'
            titoBuild 'mock-core-configs'
        }

        stage('Publish') {
            options {
                skipDefaultCheckout()
            }
            steps {
                script {
                    publishTitoResults distros
                }
            }
        }
    }    