#setenforce 0
#yum install -y kubelet kubeadm kubectl
#systemctl enable kubelet && systemctl start kubelet

/etc/yum.repos.d/k8s.repo:
  file.managed:
    - source: salt://etc/yum.repos.d/k8s.repo
    - user: root
    - group: root
    - mode: 644

kubeadm:
  pkg.installed: []

kubectl:
  pkg.installed: []

kubelet:
  pkg.installed: []
  service.running:
    - name: kubelet
    - enable: True
    

#/etc/kubernetes/kubelet.yaml:
#  file.managed:
#    - source: salt://etc/kubernetes/kubelet.yaml
#    - user: root
#    - group: root
#    - mode: 660

#/etc/systemd/system/kubelet.service.d/10-kubeadm.conf:
#  file.managed:
#    - source: salt://etc/systemd/system/kubelet.service.d/10-kubeadm.conf
#    - user: root
#    - group: root
#    - mode: 660

/etc/sysctl.d/k8s.conf:
    file.managed:
    - source: /srv/salt/etc/sysctl.d/k8s.conf
    - user: root
    - group: root
    - mode: 660

#kubelet:
#  pkg.installed: []
#  service.running:
#    - enable: True
#    - watch:
#      - pkg: kubelet
#      - file: /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
#      - file: /etc/kubernetes/kubelet.yaml
#      - file: /etc/sysctl.d/k8s.conf
