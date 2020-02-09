#!/user/bin/groovy
// Declarative Pipeline
pipeline {
	agent any

	stages {

		stage('Lint') {
			steps {
				sh "Rscript -e 'lintr::lint(\"plumber_ml.r\")'"
				//sh "Rscript -e 'quit(save = \"no\", status = length(lintr::lint(\"plumber_ml.r\")))'"
			}
		}

		stage('Test - on VM') {
			steps {
				sh "Rscript -e 'plumber::plumb(\"plumber_ml.r\")\$run(host=\"0.0.0.0\", port=8000)' &"
				sh "sleep 10"
				testAPI()
				sh "kill \$(lsof -t -i:8000)"
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

def testAPI(){
	sh "api_test.sh"
}

