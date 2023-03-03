# Generate a filename string with date like "~/md/20220124-1.md"
# If the file exists, increase the last number like "~/md/20220124-2.md"
DIR=~/lrn
filename=$DIR/$(date +%Y%m%d)-1.md
while [ -f $filename ]; do
    num=$(echo $filename | sed -e 's/.*-\([0-9]*\)\.md/\1/')
    num=$((num+1))
    filename=$(echo $filename | sed -e "s/\([0-9]*\)\.md/${num}.md/")
done
# Judge if a neovim session is listening on the pipe
if [ -S ~/.cache/nvim/server.pipe ]; then
    # If so, send the filename to the neovim session
    nvim --remote-send "<esc>o$3[P$2]($1)<cr>" --server ~/.cache/nvim/server.pipe
else
    # If not, create a new neovim session
    alacritty -e nvim $filename -c ":norm i# $filename

## [P$2]($1)" --listen ~/.cache/nvim/server.pipe& 
fi
