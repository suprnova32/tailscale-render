#!/usr/bin/env bash

/render/tailscaled --tun=userspace-networking --socks5-server=localhost:1055 &
PID=$!

until /render/tailscale up --authkey="${TAILSCALE_AUTHKEY}" --hostname="${RENDER_SERVICE_NAME}"  --advertise-exit-node; do
  sleep 0.1
done
export ALL_PROXY=socks5://localhost:1055/

wait ${PID}
