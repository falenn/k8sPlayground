FROM centos:7.2.1511

# use env variables to define working directories and versions.
# example
# 
ENV OPENSSL=OpenSSL_1_1_0h.tar.gz

WORKDIR /build

COPY ./${OPENSSL} /build
COPY ./patched_nginx_v0.3.6.tar.gz /build 
COPY ./QAT_Engine_v0.5.39.tar.gz /build
COPY ./QAT_Zip_v0.2.6.tar.gz /build
RUN tar xzf OpenSSL_1_1_0h.tar.gz && tar xzf patched_nginx_v0.3.6.tar.gz && tar xzf QAT_Engine_v0.5.39.tar.gz && tar xzf QAT_Zip_v0.2.6.tar.gz && rm -f *.tar.gz
# add builds for all packages
# add packages to complete builds
