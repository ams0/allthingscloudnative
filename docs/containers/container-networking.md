# Container Networking

[]: # "Introduction"

## Outcomes

You should be able to:

- Understand docker networking

#Outline
1. Docker networking

```bash
docker run ‐‐net=none busybox ifconfig
lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
```

```bash
docker run --network host busybox ifconfig
```

Two containers can share the same network:
  
```bash
docker run ‐‐name foo ‐d busybox sleep 3600
docker run ‐‐net=container:foo ‐it busybox /bin/sh
```
