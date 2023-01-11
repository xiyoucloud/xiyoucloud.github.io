if [[ $1 ]]; then
hexo generate && git add -A && git commit -m "$1" && git push && cd ../source && git add -A && git commit -m "$1" && git push
else
	echo "please input commit message"
fi
