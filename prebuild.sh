touch prebuild-is-started.txt
rm prebuild-is-ready.txt
./ensure-node-version.sh
npm run gitpod-init
docker pull deepf/deeplinks:main
docker run -v $(pwd)/packages/deeplinks:/deeplinks --rm --name links --entrypoint "sh" deepf/deeplinks:main -c "cp -r /snapshots/* /deeplinks/snapshots/ && chown -R 33333:33333 /deeplinks/snapshots/";
(cd packages/deeplinks && npm run snapshot:last);
npm install -g concurrently;
npm run gitpod-engine;
npm cache clean --force;
(cd packages/deepcase-app && rm -rf app);
(cd packages/deepcase/ && npm run package:build);
touch prebuild-is-ready.txt;
