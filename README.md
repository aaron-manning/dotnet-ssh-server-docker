# Dotnet SSH Server in Docker

Simple (root user) SSH server running inside Docker with .net SDK + Entity Framework tools.

This is useful for Jetbrains or VScode remote IDE (via SSH) features if you cannot run the remote server directly on the host.

```
cp .env.example .env
```

Set your desired SSH_PASSWORD password in the .env file, then start the container.

```
docker compose up -d --build
```

Then connect using your password via a terminal app.

```
ssh root@host-ip-address -p 222
```

You will then have access to the following commands, and should be able to connect using IntelliJ Rider remote backend.

```
dotnet
dotnet ef
```
