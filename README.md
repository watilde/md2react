# md2react

```
npm install --save md2react
```

## WIP

- It doesn't work at `table`.
- Not tested

## Example

```coffee
md = '''
# Hello
hello

- a
- b

1. 1
2. 2

`a`

------

<span></span>

```
bbb
```

**AA**

*BB*

[foo](/foo)

![img](/img.png)

> aaa
> bbb


|  TH  |  TH  |
| ---- | ---- |
|  TD  |  TD  |
|  TD  |  TD  |
'''

global.React = require('react');
md2react = require('md2react');
html = React.renderToString(md2react(md));
```
