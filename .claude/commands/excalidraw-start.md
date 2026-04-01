Check if the Excalidraw canvas server is already running by calling `curl -s http://localhost:3000/health`. If it returns a healthy response, confirm it's ready and tell the user to open http://localhost:3000.

If it's not running, start it in the background with:
```
node [REDACTED_LOCAL_PATH]/.local/share/mcp-excalidraw/dist/server.js &
```

Wait 2 seconds, then verify with `curl -s http://localhost:3000/health`. If healthy, tell the user the canvas is ready at http://localhost:3000 and they can now describe their graphic.
