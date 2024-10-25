set -e
PORT=$1
for i in {1..1000}
do
  curl -s http://localhost:$PORT/ > /dev/null &
done
wait