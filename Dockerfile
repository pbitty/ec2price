FROM ubuntu:trusty

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get install -y --force-yes \
      python=2.7.5-5ubuntu3 \
      python-pip=1.5.4-1

RUN apt-get install -y python-dev=2.7.5-5ubuntu3

# Handle requirements separately, so they're cached by docker
ADD requirements.txt /
RUN pip install -r requirements.txt

ADD / /ec2price

RUN cd /ec2price && \
    bin/post_compile

ENV PYTHONPATH=/ec2price

WORKDIR /ec2price
CMD ["scripts/ec2price", "web"]
