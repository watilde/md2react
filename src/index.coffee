mdast = require 'mdast'
$ = React.createElement
sanitize = null
compile = (node) ->
  switch node.type
    when 'root'
      $ 'div', {}, (compile(child) for child in node.children)
    when 'text'
      node.value
    when 'strong'
      $ 'strong', {}, (compile(child) for child in node.children)
    when 'emphasis'
      $ 'em', {}, (compile(child) for child in node.children)
    when 'horizontalRule'
      $ 'hr'
    when 'inlineCode'
      # TODO: code is valide?
      $ 'code', {}, [node.value]
    when 'code'
      # TODO: code is valide?
      $ 'code', {}, [node.value]
    when 'heading'
      tag = 'h'+node.depth.toString()
      $ tag, {}, (compile(child) for child in node.children)
    when 'paragraph'
      $ 'p', {}, (compile(child) for child in node.children)
    when 'list'
      tag = if node.ordered then 'ol' else 'ul'
      $ tag, {}, (compile(child) for child in node.children)
    when 'link'
      $ 'a', {href: node.href, title: node.title}, (compile(child) for child in node.children)
    when 'image'
      $ 'img', {src: node.src, title: node.title, alt: node.alt}
    when 'blockquote'
      $ 'blockquote', {}, (compile(child) for child in node.children)
    when 'table'
      # TODO: fixme
      $ 'table', {}, (compile(child) for child in node.children)
    when 'tableHeader'
      $ 'tr', {}, (($ 'th', {}, compile(child)) for child in node.children)
    when 'tableRow'
      $ 'tr', {}, (($ 'td', {}, compile(child)) for child in node.children)
    when 'tableCell'
      $ 'span', {}, (compile(child) for child in node.children)
    when 'listItem'
      # TODO: what is loose property?
      $ 'li', {}, (compile(child) for child in node.children)
    when 'html'
      if window? and sanitize
        dompurify = require 'dompurify'
        $ 'div', dangerouslySetInnerHTML:{__html: dompurify.sanitize(node.value)}
      else
        $ 'div', dangerouslySetInnerHTML:{__html: node.value}
    else
      # console.log node
      throw node.type +' is unsuppoted node type. report to https://github.com/mizchi/md2react/issues'

module.exports = (raw, _sanitize = true) ->
  sanitize = _sanitize
  ast = mdast.parse raw
  compile(ast)
