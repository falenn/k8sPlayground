! QAT Acceleration of NginX and OpenSSL

!! References

See https://github.com/intel/async_mode_nginx

!! Goal

To provide an nginx sidecar that proxies all tcp/udp traffic with TLS termination.

!! Todo
1. Allow the docker conatiner to not run as root. The intel qat k8s plugin can be used to present qat devices to the docker container.
2. Figure out how a handleful of containers can be proxied by one nginx container. Likely using a kubernetes pod volume with a few unix sockets.
3. Fix certificate issuses related to self signed certs, so that connections are encrypted.
4. Tuning nginx parameters.
5. Tuning intel device files in /etc/

Documentation
https://01.org/sites/default/files/downloads/intelr-quickassist-technology/337020-001qatwcontaineranddocker.pdf

How To:
1. Setup the host to run the intel qat card.

2. Use dpdk to create ibg_uio for interfacing with c6xxvf virtual functions.

3. Run ./db.sh to start the docker conatiner that exposes a nginx proxy that forwards traffic on port 12345 to a local unix socket. Currently, there is a test http server listening in the same container on unix:/var/run/nginxproy.sock.

4. Use wget https://host:12345 to recieve http responses from the proxied http server. If the certificate is valid, then the nginx proxy will preform TLS encryption on the incoming/outgoing traffic and forward unencrypted traffic to the unix socket.
