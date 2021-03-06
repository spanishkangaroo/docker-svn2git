#!/bin/bash

not_blank()
{
  if [ -z "$1" ]; then
    echo "The parameter $2 is missing"
	exit 1
  fi
}

SVN_REPO_URL="$1"
not_blank "$SVN_REPO_URL" "SVN_REPO_URL"
HOST_DIR="$2"
not_blank "$HOST_DIR" "HOST_DIR"

docker rm svn2git
docker run -d --name svn2git -it -v $HOST_DIR:/host-dir sawano/svn2git:latest

docker exec svn2git sh -c "mkdir /host-dir/converted-repo; cd /host-dir/converted-repo; svn2git $SVN_REPO_URL --authors /host-dir/authors.txt"

docker stop svn2git
docker rm svn2git
