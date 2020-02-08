#!/user/bin/groovy
// Declarative Pipeline
pipeline {
	agent any

	stages {

		stage('Lint') {
			steps {
				sh "Rscript -e 'lintr::lint(\"plumber_ml.r\")'"
			}
		}

		stage('Test - on VM') {
			steps {
				echo 'Testing on VM'
			}
		}

		stage('Build') {
			steps {
				echo 'Building image..'
			}
		}

		stage('Test - on container') {
			steps {
				echo 'Running and testing container..'
			}
		}

		stage('Deploy') {
			steps {
				echo 'Deploying to ECR / ECS..'
			}
		}

    		stage('Test - user acceptance') {
			steps {
				echo 'Testing, UAT..'
			}
		}

	}
}