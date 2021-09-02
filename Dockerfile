FROM pltnk/icecast2:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt -y install libmp3lame-dev libxml2-dev libshout-dev libvorbis-dev gcc g++ build-essential wget

RUN wget http://downloads.us.xiph.org/releases/ices/ices-0.4.tar.gz

RUN tar -xf ices-0.4.tar.gz --directory /tmp/

WORKDIR "/tmp/ices-0.4/"

RUN ./configure --prefix=/usr/local --with-pic --with-lame

RUN make && make install

RUN mkdir /playlists /music /etc/ices

COPY ./icecast2/icecast.xml /etc/icecast2/icecast.xml

COPY ./ices/ices.conf /etc/ices/ices.conf

COPY ./createPlaylist.sh /createPlaylist.sh

CMD /createPlaylist.sh && /etc/init.d/icecast2 start && /usr/local/bin/ices -c /etc/ices/ices.conf -v