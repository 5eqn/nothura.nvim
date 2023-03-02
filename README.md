# nothura.nvim

[English Version](./README_en.md) is to be updated.

基于 Neovim 和 Zathura 的极简主义知识管理方案。

## 安装方式

### Neovim

使用 [packer.nvim](https://github.com/wbthomason/packer.nvim)：

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

在 `init.lua` 中添加

```lua
require('nothura')
vim.keymap.set('n', ',n', ':lua GotoZathura()<CR>', { noremap = true, silent = true })
```

其中 `,n` 是用来从 Neovim 跳转到 Zathura 的快捷键，可以更换。

### Zathura

在 `~/.config/zathura/zathurarc` 增加一行配置：

```
map ,n exec "nothura-md $FILE $PAGE"
```

快捷键依然可以更换。

### Bash

Clone 本工程后执行 `make install` 即可。

可以通过修改 `nothura-md.sh` 的 `DIR` 来修改默认存放 Markdown 文件的位置。

## 使用方式

假设你用 Zathura 打开了 `text.pdf`，
你可以在 Zathura 中**标记页面**，
这会在你指定的目录里类似于 `20220104-1.md` 的文件中插入一个标签：

```markdown
<~/pdf/2021A.pdf P2>
```

如果你保持打开这个新创建的文件，
Zathura 将直接把笔记插入到光标后面。

你也可以在 Neovim 中**查看页面**，
这将会尝试打开目标文档，并且同步到标签中的页码。
如果链接作为标题，你只要光标在段内就可以跳转；
如果链接作为文本，你需要选中链接所在行，
如果一行有两个链接，暂时默认跳第一个。
如果你没有打开 `text.pdf`，那么 Neovim 会帮你打开。

就是这么简单！

## 经典案例

### 无压笔记

在 `/path/to/md` 中创建 Markdown 笔记，
剩下的本插件会帮你搞定！（参考后续案例）

如果你想要使用每日笔记机制，
你可以写一个简单的脚本，
但日期本身可以被笔记创建日期代替。

事实上，你可以选择写一个脚本，
自动创建一个随机文件名（含日期信息的话手动阅览方便些）的文件，
就不容易出现同时打开两次每日笔记的问题，
也可以减少创建新笔记的成本。

### 找到所有与离散数学相关的内容

把所有和离散数学相关的电子书放到 `/path/to/discrete/` 中，
不要重命名或移动它们，
这样你就能通过搜索 `/discrete/` 来找到全部相关的内容。

为了实现真正的无压，你可以将你记下来的全部东西视为索引，
然后使用一种模糊查找工具（例如 Telescope 插件的 Live Grep 功能）来查找。

### 制作知识图谱

你在进行笔记的时候往往会产生一些理解，
这些理解通常会把很多概念串起来，
这本身就是知识图谱，
没有必要依赖机器进行机械化的意象关联。

### 导出闪卡

可以将标斜体或非粗体的内容隐藏制作闪卡，
导入到专业的闪卡软件即可。
如果需要对 PDF 内容进行回忆，
可能需要自己单独写一个插件。

如果想要简易替代品，
可以考虑在记到感觉要回忆的东西时就标个加粗，
然后巩固记忆时直接搜索 `\*\*` 即可。

请尽量避免使用闪卡，
因为值得使用闪卡的知识是极少数。
如果你在工作中有较多回忆性质的工作，
可以考虑利用硬盘的记忆能力，
先写个程序对这些知识进行封装。
同时，ChatGPT 之类的工具也能起到根据模糊表述回忆的作用。
如果你需要在闭卷考试中取得高分，
或需要内化某种更精炼的表述以便于未来的学习，
使用闪卡是推荐的。

### 查看随机文章

你可以爆改模糊查找工具让它随机化，
也可以自己手动模拟随机。
不过由于通常是在思路比较乱的时候随机，
在理想状况下不需要随机，
在这方面不需要下太大功夫。

### 导出全部作业

可以考虑写脚本检测“作业”二级标题，
将其中的内容复制到一个新的 Markdown 文件后编译。

建议使用 LaTeX 来写作业，
因为这套插件支持的流程只适合做给自己看的潦草笔记。

### 创建 TOC

可以考虑自己重载一个独立于 Markdown 的层级结构语法，
并且自己写个补全扩展。

然而，TOC 在前面提到的增强知识网络下表现出
难以创建灵活的架构和联系的缺点，
因此我不建以采用。

### 创建 TODO

你可以使用 `- [ ]` 来代表和筛选 TODO，
但我更建议使用 `there-is-no-todo` 作为代办管理软件。

我计划为 `nothura.nvim` 添加和 `there-is-no-todo` 对接的插件，
可惜这两个工程一个也没做完。

### 预览笔记

你可以再找一个插件，
也可以选择不预览，
这样可以节约一些屏幕空间，
但公式可能比较难看。

建议使用自动折叠插件来缓和矛盾。

## 和现有解决方案的对比

### 双链笔记

双链笔记在减轻笔记压力的思想上是正确的，
将原先需要主动整理资料的压力降低到只需要标 Tag，
然后让机器自动存储知识关联。

然而，这个想法的缺陷在于我们不能保证每次写 Tag 思路都一样。
例如，我可能对“常数变易法”有一些笔记，对“待定系数法”又有一些笔记，
这样就形成了两个 Tag，但实质上这两者是高度一致的。
事后向程序声明这两者高度一致可行，
但如果某个方法有非常多的名字，
这种思路会增加笔记成本。

实质上我们只需要对知识建立索引，
而建立索引并不一定要依赖 Tag，
使用模糊查找效率更高且更灵活。
在上面的例子中，不论我们叫这个方法什么，
在实际笔记中必然会出现类似于“给原来的函数乘上一个未知函数”
之类的字样，因此可以模糊搜索“乘 未知 函数”，
就可以将笔记中所有内容按照与搜索内容相关的可能性排序，
在前面的大概率就是关联的知识了。
