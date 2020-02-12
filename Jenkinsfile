#!/user/bin/groovy
// Declarative Pipeline
pipeline {
	agent any
	environment{
		DOCKER_IMAGE_TAG = "${ECR_URI}/boston_houses:${BUILD_NUMBER}"
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
				sh "docker image build --tag \${DOCKER_IMAGE_TAG} ."
				//script{appImage = docker.build("${DOCKER_IMAGE_TAG}")}
			}
		}

		stage('Test - on container') {
			steps {
				sh "docker container run --rm -d --name \${TEST_CNT_NAME} -p 8000:8000 \${DOCKER_IMAGE_TAG}"
				sleep 5
				testAPI()
				sh "docker container stop \${TEST_CNT_NAME}"
			}
		}

		stage("Push to registry") {
			steps{
				sh "/home/ubuntu/.local/bin/aws ecr describe-repositories --region eu-west-1"
				//sh "\$(aws ecr get-login --region eu-west-1)"
				//sh "docker push \${DOCKER_IMAGE_TAG}"
			}
		}

		stage('Deploy') {
			steps {
				echo env.TEST_CNT_NAME
				echo env.DOCKER_IMAGE_TAG
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

