set -e

npm run build

cd dist

echo > .nojekyll

git init
git checkout -B main
git add -A
git commit -m 'deploy'

git push -f https://github.com/oleksandrshtonda/vue3_todo-app.git main:gh-pages

cd -
