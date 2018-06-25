# quorum-docker
It's a repository for setting up (permissioned blockchain) quorum and constellation in docker with multiple nodes.

## Creating quorum image
```
cd quorum
docker build -t quorum:latest . 
```

## Creating constellation image
```
cd constellation
docker build -t constellation:latest . 
```