## My nvim config file
###### (And yeah, it's a single file)

This is my own take on trying to make an all-in-one-file configuration for Neovim. I previously used Visual Studio Code and wanna switch to something new to test things out and get some more fresh air (trust me, this is a hassle).

This configuration is under heavy influence from [ThePrimeagen's config]('https://github.com/ThePrimeagen/init.lua') and [Alexis12119's old config]('https://github.com/Alexis12119/nvim-config/tree/f33dca3897a907855cf0ebde1b49f85407a89f62'). Thank you all for putting your config online so that I can just copy things out easily.

I'm thinking about actually implementing more from [NVChad]('https://github.com/NvChad/NvChad') and [xero's config]('https://github.com/xero/dotfiles/tree/main/neovim/.config/nvim') too. Let me see if I have the time for that.

Just so you know if you haven't noticed yet, this is the absolute horrible configuration to use. The fact that it's inside of only one file makes it absolutely hard to read and write, and I don't have time to add comments! My take of just putting bits here and there and hopefully it works somehow turns out to be a bit decent but it may be a big 'thud' in your eyes.

So please be advised that if you wanna take a look at this config, please be aware of serious 'eye infections' and 'hazardous backaches' and other consequences that might occur!

### Prerequisites:
- **A decent working terminal.** What is a decent working terminal, you may ask? They are terminal that
    + Can use Unicode (for Nerd Fonts) and can specify font to use with.
    + Can change background and text colors.
- **Nerd Font** (I'm personally use NotoSansM, I don't know why but it looks quite good. You can use whatever you want).
- **Git** (for cloning this repo if you wanna use this).
- **npm** and **gcc/clang/'some kind of C complier'** for Mason and Treesitter.
- Some other things that I just don't remember. If anything breaks then go install the requiring packages and try again (Seriously).

### Installation
Just drop the init.lua into the nvim's configuration directory and see what happens

###### Written in Vim with sarcasm

