ARG image_version
FROM grafana/grafana:$image_version
ENV HTTP_PROXY=$HTTP_PROXY
ENV HTTPS_PROXY=$HTTPS_PROXY
CMD ['sh', '/run.sh']
