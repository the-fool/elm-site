set -euxo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: ./do [build|dev|down]"
  exit 1
fi

if [ "$1" == "build" ]; then
  docker build -t the-fool/elm-site .
fi

if [ "$1" == "dev" ]; then
  docker run --name elm-site -i -p 8080:8080 --rm -v $(pwd)/src:/app/src the-fool/elm-site
fi

if [ "$1" == "down" ]; then
   docker kill elm-site
fi
