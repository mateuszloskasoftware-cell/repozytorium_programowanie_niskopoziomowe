# ARM bare‑metal toolchain + QEMU (Ubuntu)
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential make cmake git ca-certificates \
    gcc-arm-none-eabi binutils-arm-none-eabi gdb-multiarch \
    qemu-system-arm python3 python3-pip nano \
    libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib \
&& rm -rf /var/lib/apt/lists/*

# Convenience: allow `arm-none-eabi-gdb` name (symlink to multiarch)
RUN ln -sf /usr/bin/gdb-multiarch /usr/local/bin/arm-none-eabi-gdb

# Create non-root user (optional). You can override user via compose.
ARG USER=dev
ARG UID=1000
ARG GID=1000
RUN groupadd -g ${GID} ${USER} && useradd -m -u ${UID} -g ${GID} -s /bin/bash ${USER}
USER ${USER}
WORKDIR /work

CMD ["/bin/bash"]
