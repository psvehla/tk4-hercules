FROM ubuntu:24.04 as builder

WORKDIR /tk4-/
ADD https://archive.org/download/tk4_ispf.tar/tk4_ispf.tar.gz /tk4-/
RUN tar xvfz tk4_ispf.tar.gz && \
    mv /tk4-/archive.org/* /tk4- && \
    rm -rf /tk4-/tk4_ispf.tar.gz
RUN rm -rf /tk4-/hercules/darwin && \
    rm -rf /tk4-/hercules/windows && \
    rm -rf /tk4-/hercules/source 

FROM ubuntu:24.04
LABEL org.opencontainers.image.authors="Ken Godoy - skunklabz"
LABEL version="1.00"
LABEL description="OS/VS2 MVS 3.8j Service Level 8505, Tur(n)key Level 4- Version 1.00"
WORKDIR /tk4-/
COPY --from=builder /tk4-/ .
VOLUME [ "/tk4-/conf","/tk4-/local_conf","/tk4-/local_scripts","/tk4-/prt","/tk4-/dasd","/tk4-/pch","/tk4-/jcl","tk4-/log" ]
CMD ["/tk4-/mvs"]
EXPOSE 3270 8038
