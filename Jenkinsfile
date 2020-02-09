#!/user/bin/groovy
// Declarative Pipeline
pipeline {
	agent any
	environment{
		DOCKER_IMAGE_TAG = "\${ECR_URI}"
		TEST_CNT_NAME = "test_cnt"
	}

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
				sh "docker image build --tag \${ECR_URI}/mlmodels/house_price_predictor:\${BUILD_NUMBER} ."
			}
		}

		stage('Test - on container') {
			steps {
				sh "docker container run --rm -d --name test_cnt -p 8000:8000 \${ECR_URI}/mlmodels/house_price_predictor:\${BUILD_NUMBER}"
				sleep 5
				testAPI()
				sh "docker container stop test_cnt"
			}
		}

		stage('Deploy') {
			steps {
				sh "echo 'Deploying... \${DOCKER_IMAGE_TAG}'"
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
	sh "bash api_test.sh"
}

