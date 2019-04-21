# MarkdownLive

## About

This project is an example of Markdown being rendered sever-side by [Phoenix LiveView](https://github.com/phoenixframework/phoenix_live_view). If you modify the text in the text area on the left, you should see the result being rendered on the right side of the page. What's more interesting is that if you look in your browser's developer tools you should notice that only the sections of the document that are being edited are being re-rendered and sent back from the server!

[Github Flavored Markdown](https://help.github.com/en/categories/writing-on-github) is supported, however, I prefer  [this](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) resource for a quick reference on Markdown syntax.

## Usage

Here are some of my favorite features for quick note taking:

Emphasis, aka italics, with *asterisks* or _underscores_.

Strong emphasis, aka bold, with **asterisks** or __underscores__.

Combined emphasis with **asterisks and _underscores_**.

Strikethrough uses two tildes. ~~Scratch this.~~

How about a

* list 
* of
* items

Pretty cool, huh? Some other useful features are:

```
code blocks
    unfortunately tabs don't currently work :(
```

or how about some `inline` code! 

You can also easily create tables:

| Tables      | Are     | Cool         |
| :----------: | :------: | :---------: |
| all               | of       | these        |
| elements | are   | centered |

Check out the documentation for more cool things you can do with Markdown and Phoenix LiveView!