# FROM registry.access.redhat.com/ubi8-minimal
FROM registry.access.redhat.com/ubi8/ubi-minimal

# LABEL maintainer=""
# ENV HOME='/runner/'

RUN microdnf update -y && rm -rf /var/cache/yum
RUN microdnf install tmux nss_wrapper gettext tar gzip -y \
    && microdnf clean all

RUN curl -L -s \
    https://mirror.openshift.com/pub/openshift-v4/clients/ocp/4.2.12/openshift-client-linux-4.2.12.tar.gz \
    | tar -C /usr/local/bin/ -zxv oc kubectl ; \
    chmod +x /usr/local/bin/oc ; \
    chmod +x /usr/local/bin/kubectl

# RUN mkdir /container-scripts/ && cp /etc/passwd /container-scripts/ && chmod 666 /container-scripts/passwd
# RUN mkdir -p /runner/.gitlab-runner/ && chmod -R 777 /runner

# ADD container-scripts/* /container-scripts/

### ENTRYPOINT ["/container-scripts/entrypoint.sh"]
ENTRYPOINT ["/bin/sh", "-c", "--" , "while true; do sleep 30; done;"]
