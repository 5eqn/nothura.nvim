# Generate a filename string with date like "~/md/20220124-1.md"
# If the file exists, increase the last number like "~/md/20220124-2.md"
DIR=~/lrn/md
filename=$DIR/$(date +%Y%m%d)-1.md
while [ -f $filename ]; do
    num=$(echo $filename | sed -e 's/.*-\([0-9]*\)\.md/\1/')
    num=$((num+1))
    filename=$(echo $filename | sed -e "s/\([0-9]*\)\.md/${num}.md/")
done
# Judge if a neovim session is listening on the pipe
if [ -S ~/.cache/nvim/server.pipe ]; then
    # If so, send the filename to the neovim session
    nvim --remote-send "<Esc>:norm a<lt>$1<Space>P$2><CR>" --server ~/.cache/nvim/server.pipe
else
    # If not, create a new neovim session
    alacritty -e nvim $filename -c ":norm i# $filename

## <$1 P$2>" --listen ~/.cache/nvim/server.pipe& 
fi
