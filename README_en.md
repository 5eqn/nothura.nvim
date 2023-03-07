# nothura.nvim

Minimal knowledge management solution based on Neovim and Zathura.

## Usage

Suppose you opened a PDF file `text.pdf` with Zathura,
you can **tag page** in Zathura, adding a tag in
something like `20220104.md` in specified directory:

```markdown
[P2](~/pdf/2021A.pdf)
```

If you keep the newly-created file,
Zathura will insert the tag after your cursor.

You can also **view page** in Neovim,
it will try to open the document, and sync to requested page.
If the link is as the title, you can jump to it whenever your cursor
is in it's paragraph; Otherwise, you only need to select the row
where the link is.
If there are two links, the first would be preferred.
If `text.pdf` isn't open, Neovim will open it for you.

That's it!

## Installation guide

### Neovim

Using [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use {
  'stevearc/aerial.nvim',
  config = function() require('aerial').setup() end
}
use {
  '5eqn/nothura.nvim',
  requires = 'stevearc/aerial.nvim'
}
```

Add these to your `init.lua`:

```lua
require('nothura')
vim.keymap.set('n', ',n', ':lua GotoZathura()<CR>', { noremap = true, silent = true })
```

`,n` is the hotkey from Neovim to Zathura,
you can change it according to your own preference.

### Zathura

Add these configuration to `~/.config/zathura/zathurarc`:

```
map n exec "nothura-md $FILE $PAGE"
map ,n exec "nothura-md $FILE $PAGE '##<space>'"
```

### Bash

Clone the project and execute `make install`,
the make script will installed necessary shell scripts for you.

You can change the default directory of Markdown files
by modifying `DIR` in `nothura-md.sh`.

## Use cases

### Free-flowing note-taking

Create your Markdown file anywhere in `/path/to/md`,
it will just work!

If you want the daily-note mechanism,
you can create a script for it,
it should be simple.

### Find everything about discrete math

Put every textbook about discrete math in `/path/to/discrete/`,
and don't rename or move them,
then you can find everything about discrete math by searching for `/discrete/`.

Generally, **make everything as your index** to remove 100% of pressure,
and utilize fuzzy finders (Telescope Live Grep, for example).

### View random article

You can achieve this by making fuzzy finder random,
but if you don't use it heavily,
an alternative is to choose results randomly by yourself.

### Make knowledge graph

Making tags or word cloud would suffice to make knowledge graphs,
albeit I don't think this can really help you learn.

### Export all homework

I would suggest you use LaTeX for homework.
This workflow is only suitable for self-oriented learning.

### Create Table of Content

You can generate word cloud based on content in bold or title,
which substitutes TOC to a certain degree.

### Make TODO

You can use `- [ ]` to symbolize and search for TODOs,
but using `there-is-no-todo` is more recommended.

I'm actually planning to integrate `nothura.nvim` with `there-is-no-todo`,
sadly none of them are finished.

### Preview notes

Use another plugin for that.
You can also choose to not preview,
this can save up some screen spaces,
but will make formulas harder to read.

You can use some auto-conceal plugins to mitigate this problem.

## My Philosophy towards note-taking and learning

I'm not professional, but I have _very_ high demand on simplicity.
Avaliable solutions are great (like Roam Research, Logseq and Siyuan Notes),
but I would prefer a minimal one like `nothura.nvim`.

Ideally, your note should be interactable and easily scriptable,
but it's not possible for now.

There are essentially only two kinds of notes:

1. Facts: You remember it, and that's all.
2. Insight: You don't remember it at all,
   you use the process of note-taking to clarify your thoughts.

That being said, real-world knowledge is often mixture of the two kinds,
and not easily separatable.
For example, there can be insight in seemingly pure definitions,
and arbitrary choice of routes in seemingly pure insights.

However, we ultimately aim to contribute to the human being, not ourselves
(You can disagree with me, it's only personal trait),
so we should accumulate insight about how you can make the world better.
For example, Linear Algebra is actually a method of modelling the world,
with terms of Math;
Calculus is a way of modelling continuous concepts,
while Discrete Math for discrete ones.
They embody paradigms of how we form knowledge.

_Facts are bones of insight._
There are interior ones and exterior ones,
only remembering interior ones is necessary.

Sorry for being idealistic, but _we should learn for a better world._
Truth is neutral and symmetrical, but our feelings are not.
_For now._
