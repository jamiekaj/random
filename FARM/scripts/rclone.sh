source ~/.bashrc
load_rclone && rclone copy --progress --update --verbose --contimeout 60s --timeout 300s --retries 3 --transfers=$(nproc) --checkers=16 --low-level-retries 10 --stats 1s $1 $2 && exit
