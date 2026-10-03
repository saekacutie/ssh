# ssh — SSH-over-WebSocket bridge (Cloud Run)

Alpine-based image: OpenSSH server + a **websockify** bridge so SSH is reachable
over a WebSocket HTTP upgrade — handy where only HTTP(S) egress is allowed.

```
client ──WS──> :$PORT (websockify) ──> 127.0.0.1:2222 (sshd)
```

## Files

| File | Purpose |
|---|---|
| `Dockerfile` | `alpine` + openssh, bash, python3, websockify |
| `entrypoint.sh` | Configures sshd (port 2222), starts sshd, execs websockify on `${PORT:-8080}` |
| `ssh-services.sh` | Standalone service starter (same stack, for manual runs) |
| `docker-compose.yml` | Local run: `8080:8080`, `PORT=8080` |

## Run locally

```bash
docker compose up --build
# SSH via websocket tunnel to localhost:8080
```

## Security notes

- Change the default container user password (`prvtspyyy`) before exposing publicly —
  set it at runtime rather than baking it into the image.
- `PermitRootLogin yes` + password auth is convenient but weak; prefer key auth
  for anything long-lived.
