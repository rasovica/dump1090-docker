FROM alpine:latest
MAINTAINER Raslav Milutinović

# Install git and build dependencies
RUN apk add --update git make gcc g++ cmake libusb-dev


#Build and install rtl-sdr
RUN git clone git://git.osmocom.org/rtl-sdr.git && cd rtl-sdr && mkdir build && cd build && cmake ../ -DINSTALL_UDEV_RULES=ON -DDETACH_KERNEL_DRIVER=ON && make && make install && ldconfig .

# Clone the dump1090 repository and build the project
RUN git clone https://github.com/antirez/dump1090

WORKDIR dump1090

RUN make

#Expose the ports and run the server
EXPOSE 8080

CMD ./dump1090 --net