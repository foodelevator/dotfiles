FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive
RUN : \
    && apt update \
    && apt install -y \
        libegl-dev libfontconfig1 libxkbcommon-x11-0 libdbus-1-3 libxcb1 libxcb-icccm4 \
        libxcb-image0 libxcb-keysyms1 libxcb-render-util0 curl unzip libxcb-shape0 \
    && rm -rf /var/lib/apt/lists/* \
    && :

RUN curl "https://cdn.binary.ninja/installers/BinaryNinja-demo.zip" -O && unzip -d /opt BinaryNinja-demo.zip && rm BinaryNinja-demo.zip

RUN useradd binja
USER binja

CMD ["/opt/binaryninja/binaryninja"]

# Run with:
# podman run -it --rm -v "$HOME/code:$HOME/code" -e DISPLAY="$DISPLAY" -v "$HOME/.Xauthority:/root/.Xauthority:ro" -v /tmp/.X11-unix:/tmp/.X11-unix binaryninja
