def titoBuild(subdir) {
    return {
        stage("build: $subdir") {
            if (env.BRANCH_NAME ==~ /devel/ ) {
                environment {
                    titoArgs = "--build --rpm --test --output=${TITODIR}"
                }
            } else {
                environment {
                    titoArgs = "--build --rpm --output=${TITODIR}"
                }
            }

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
                    publishTitoResults distros
                }
            }
        }
    }
}