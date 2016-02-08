# Atom Tips
[Complete Atom Shortcuts](http://sweetme.at/2014/03/10/atom-editor-cheat-sheet/#atom_code_nav)

## Reindent

- Select some text, then Edit -> Line -> Auto indent
- Atom has no key-binding shortcut for this, however you can create one by Atom > Open Your Keymap and making your own key-binding such as:
```
atom-text-editor':
  'cmd-alt-l': 'editor:auto-indent'
```
## Whitespace

- In the lower right, you can change the indent
  - Always use 2 spaces.
- To make this change for all `*.rb` (or any other) kind of file
  - Atom -> Preferences -> Settings -> Tab Length  set the tab length to 2.

## Multi-select

- line
  - Command+ L
- word
  - Command+D

## Toggle select

- all: Command+A
- double click
- expand selection
  - Unit: Command+Shift+Space
  - Line: Command+L
  - To the beginning/end of a line: Command + Shift + Right/Left  Arrow
  - To the beginning/end of a document Command + Shift + Up/Down Arrow

## Toggle Indent

select lines, then
- tab or Command+]
- shift+tab or Command+[

## Toggle Comment Block
Command+/

## Layouts
View -> Panes

## Go-to-line
Ctrl+g
Good for error messages.

## Global Find&Replace
Command+Shift+F (escape to exit)

##Advanced Packages
https://atom.io/packages
