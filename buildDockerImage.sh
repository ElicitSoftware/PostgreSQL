# Build the multi-arch image
docker buildx build --no-cache -t elicitsoftware/elicit_db:latest --load .
