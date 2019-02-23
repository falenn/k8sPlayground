FROM centos:7.2.1511

# use env variables to define working directories and versions.
# example
# 

ENV OPENSSL_PACKED=OpenSSL_1_1_0h.tar.gz \
    NGINX_PACKED=patched_nginx_v0.3.6.tar.gz \
    QATE_PACKED=QAT_Engine_v0.5.39.tar.gz \
    QATZ_PACKED=QAT_Zip_v0.2.6.tar.gz \
    OPENSSL=openssl-OpenSSL_1_1_0h \
    NGINX=asynch_mode_nginx-0.3.6 \
    QATE=QAT_Engine-0.5.39 \
    QATE_CONFIG=qat/config/c6xx/multi_thread_optimized \
    QATZ=QATzip-0.2.6 \
    CONTIG_MEM=qat_contig_mem \
    BUILD_DIR=/build \
    KERNEL=3.10.0-862.14.4.el7.x86_64 \
    QAT_DRIVER=QAT \
    NGINX_INSTALL_DIR=/usr/local/nginx/ \
    SSL_INSTALL_DIR=/usr/local/ssl/

WORKDIR ${BUILD_DIR}

RUN yum install -y perl.x86_64 gcc.x86_64 make \
                   autoconf automake libtool \
                   zlib*.x86_64 pcre-*.x86_64 \
                   man

COPY ./${OPENSSL_PACKED} ${BUILD_DIR}
COPY ./${NGINX_PACKED} ${BUILD_DIR}
COPY ./${QATE_PACKED} ${BUILD_DIR}
COPY ./${QATZ_PACKED} ${BUILD_DIR}
COPY ./${QAT_DRIVER} ${BUILD_DIR}/${QAT_DRIVER}

# TODO change to WGETs
RUN tar xzf ${OPENSSL_PACKED} && tar xzf ${NGINX_PACKED} && tar xzf ${QATE_PACKED} && tar xzf ${QATZ_PACKED} && rm -f *.tar.gz

# Building openssl
RUN cd ${BUILD_DIR}/${OPENSSL} && ./config --prefix=${SSL_INSTALL_DIR} && \
	cat Makefile && make && make install && \ 
	echo "export OPENSSL_ENGINES=${SSL_INSTALL_DIR}/lib/engines-1.1" >> /root/.bashrc && \ 
	cd ${BUILD_DIR}

# Building QAT_Engine
RUN cd ${BUILD_DIR}/${QATE} && ./autogen.sh && ./configure --with-qat_dir=${BUILD_DIR}/${QAT_DRIVER} --with-openssl_dir=${BUILD_DIR}/${OPENSSL}/ --with-openssl_install_dir=${SSL_INSTALL_DIR} --enable-openssl_install_build_arch_path --enable-qat_for_openssl_110 --enable-upstream_driver --enable-usdm --enable-qat_warnings --enable-qat_debug --enable-qat_mem_warnings --enable-qat_mem_debug --with-qat_debug_file=${BUILD_DIR}/qat-engine.log; make && make install && cp -f ${SSL_INSTALL_DIR}/lib/libqat.so ${SSL_INSTALL_DIR}/lib/engines-1.1/qat.so && cd ${BUILD_DIR}/${QATE}/${QATE_CONFIG} && cp c6xx_dev* /etc/ && touch /etc/ld.so.conf.d/usrlocal.conf && echo "${SSL_INSTALL_DIR}/lib/" > /etc/ld.so.conf.d/usrlocal.conf && echo "${BUILD_DIR}/${QAT_DRIVER}/build/" >> /etc/ld.so.conf.d/usrlocal.conf && ldconfig -v && cd ${BUILD_DIR}

# Building Qzip
RUN cd ${BUILD_DIR}/${QATZ} && \ 
	sed -i 's/const char \*g_dev_tag = "SHIM"\;/const char \*g_dev_tag = "SHIM2"\;/g' ./src/qatzip.c && \ 
	./configure --with-ICP_ROOT=${BUILD_DIR}/${QAT_DRIVER}/ && \ 
	make && make all install && \
	 cd ${BUILD_DIR}
 
RUN cd ${BUILD_DIR}/${NGINX} && ./configure --prefix=${NGINX_INSTALL_DIR} --with-http_ssl_module --with-stream --with-stream_ssl_module --add-dynamic-module=modules/nginx_qatzip_module --add-dynamic-module=modules/nginx_qat_module/ --with-cc-opt="-DNGX_SECURE_MEM -I${SSL_INSTALL_DIR}/include/ -I${BUILD_DIR}/${QAT_DRIVER}/include -Wno-error=deprecated-declarations" --with-ld-opt="-Wl,-rpath=${SSL_INSTALL_DIR}lib -L${SSL_INSTALL_DIR}lib -L${SSL_INSTALL_DIR}/include/ -lqatzip -lz" && make && make install && cd ${BUILD_DIR}

COPY ./init.sh ${BUILD_DIR}/
RUN chmod 555 ${BUILD_DIR}/init.sh

EXPOSE 80/tcp 80/udp 443/tcp 443/udp 12345/tcp 12345/udp

COPY ./nginx.conf /usr/local/nginx/conf/
CMD ["/bin/bash", "/build/init.sh"]
