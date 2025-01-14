source ~/.bashrc
load_rclone && rclone copy --copy-links --progress --update --verbose --contimeout 60s --timeout 300s --retries 3 --transfers=$(nproc) --checkers=16 --low-level-retries 10 --stats 15s ~/storage/ctbrownroot/ box:/backup && exit
