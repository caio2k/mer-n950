
FROM caio2k/mer:latest
MAINTAINER caio2k

#ADD nemo-armv7hl-n950-0.20130411.1.NEMO.2013-04-26.1.tar.bz2 /srv/mer/targets/n950rootfs 
ADD http://releases.nemomobile.org/snapshots/images/0.20130411.1.NEMO.2013-04-26.1/nemo-armv7hl-n950/nemo-armv7hl-n950-0.20130411.1.NEMO.2013-04-26.1.tar.bz2 /srv/mer/targets/n950rootfs/
WORKDIR /srv/mer/targets/n950rootfs/
RUN tar jxf nemo-armv7hl-n950-0.20130411.1.NEMO.2013-04-26.1.tar.bz2
RUN sb2-init  -L "--sysroot=/" -C "--sysroot=/" -c /usr/bin/qemu-arm-dynamic -m sdk-build -n -N -t / nemo-n950 /opt/cross/bin/armv7hl-meego-linux-gnueabi-gcc
RUN echo -n "armv7hl-meego-linux" > etc/rpm/platform
RUN zypper -n install expect
RUN echo /usr/lib/tcl/expect5.45/ > /etc/ld.so.conf.d/expect.conf
RUN ldconfig
RUN sb2 -t nemo-n950 -m sdk-install -R ssu ur
COPY sb2_wrapper.exp /root/
RUN chmod +x /root/sb2_wrapper.exp
RUN /root/./sb2_wrapper.exp 'zypper addrepo http://releases.merproject.org/releases/latest/builds/armv7hl/packages/ mer-project'
RUN /root/./sb2_wrapper.exp 'zypper removerepo nemo-platform'
#RUN /root/./sb2_wrapper.exp 'zypper lr'
RUN /root/./sb2_wrapper.exp 'zypper ref -f'
RUN /root/./sb2_wrapper.exp 'zypper dup'
RUN /root/./sb2_wrapper.exp 'zypper install gcc-c++'


