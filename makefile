include ../../../make.inc

build_docker_image:
	docker build -t ${DOCKER_IMAGE_NAME} .

run_docker_image:
	docker run --rm -it -p 8000:8000 ${DOCKER_IMAGE_NAME}

push_docker_image:
	-e PORT=${PORT}
	docker tag "${IMAGE_NAME}:${IMAGE_TAG}" "${HOSTNAME}/${PROJECT_ID}/${REPOSITORY}/${IMAGE_NAME}:${IMAGE_TAG}"
	docker push "${HOSTNAME}/${PROJECT_ID}/${REPOSITORY}/${IMAGE_NAME}:${IMAGE_TAG}"
	gcloud container images list-tags "${HOSTNAME}/${PROJECT_ID}/${REPOSITORY}/${IMAGE_NAME}"

deploy_docker_image:
	gcloud run deploy first-app --image ${HOSTNAME}/${PROJECT_ID}/${REPOSITORY}/${IMAGE_NAME}:${IMAGE_TAG} --region europe-north1 --allow-unauthenticated
