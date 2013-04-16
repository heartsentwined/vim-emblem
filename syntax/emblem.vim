" Language:    emblem
" Maintainer:  heartsentwined <heartsentwined@cogito-lab.com>
" URL:         http://github.com/heartsentwined/vim-emblem
" Version:     1.0
" Last Change: 2013 Apr 17
" License:     GPL-3.0

" Quit when a syntax file is already loaded.
if exists('b:current_syntax') && b:current_syntax == 'emblem'
  finish
endif

if !exists('main_syntax')
  let main_syntax = 'emblem'
endif

syn match eblLineStart '^\s*' nextgroup=@eblStartElements                     display
syn match eblLineOp    '\s*:' nextgroup=@eblStartElements skipwhite contained display
hi def link eblLineOp eblOperator

syn cluster eblStartElements contains=eblIdOp,eblClassOp,eblHbsOp,eblHbsHelper,eblHbsPartialOp,eblView,@eblTag

syn cluster eblComponent     contains=eblIdOp,eblClassOp,eblInlineText,eblAttr,eblHbsOp,eblHbsAttrRegion,eblHbsPartialOp,eblLineOp

syn match eblIdOp    '#'         nextgroup=eblId         contained display
syn match eblId      '\v(\w|-)+' nextgroup=@eblComponent contained display
syn match eblClassOp '\.'        nextgroup=eblClass      contained display
syn match eblClass   '\v(\w|-)+' nextgroup=@eblComponent contained display
hi def link eblIdOp    eblId
hi def link eblClassOp eblClass

syn region eblHbsAttrRegion matchgroup=eblHbsAttrRegionOp start='{' end='}' contains=eblHbsHelper nextgroup=@eblComponent keepend contained display
hi def link eblHbsAttrRegionOp eblOperator

syn match eblInlineText '\v\s+[^:]+.*$' contains=eblItpl contained display
hi def link eblInlineText eblRaw

syn cluster eblHbsComponent contains=eblHbsArg,eblhbsAttr,eblHbsTextOp,eblLineOp

syn match eblHbsOp            '\v\s*\=+'                                                           nextgroup=eblHbsHelper     skipwhite contained display
syn match eblHbsHelper        '\v(\w|-)+'                             contains=eblKnownBlockHelper nextgroup=@eblHbsComponent skipwhite contained display
syn match eblHbsTextOp        '|'                                                                  nextgroup=eblHbsText                 contained display
syn match eblHbsText          '.*'                                                                                                      contained display
syn match eblKnownBlockHelper '\v<(if|unless|else|each|with|view)>'                                                                     contained display
hi def link eblHbsOp             eblOperator
hi def link eblHbsHelper         eblFunction
hi def link eblHbsTextOp         eblOperator
hi def link eblHbsText           eblRaw
hi def link eblKnownBlockHelper  eblKeyword

syn match eblHbsArg           '\v\s*((["'])[^\2]{-}\2|(\w|\.|-|\>)+)'                              nextgroup=@eblHbsComponent skipwhite contained display
syn match eblHbsAttr          '\v\s*(\w|-)+\=@='                      contains=eblHbsAttrBind      nextgroup=eblHbsAttrOp               contained display
syn match eblHbsAttrBind      /\v<(\w|-)+Bind>/                                                                                         contained display
syn match eblHbsAttrOp        '='                                                                  nextgroup=eblHbsAttrLit              contained display
syn match eblHbsAttrLit       /\v(["'])[^\1]{-}\1|[^: ]+/             contains=eblItpl             nextgroup=@eblHbsComponent skipwhite contained display
hi def link eblHbsArg            eblLiteral
hi def link eblHbsAttr           eblAttr
hi def link eblhbsAttrBind       eblBind
hi def link eblHbsAttrOp         eblOperator
hi def link eblHbsAttrLit        eblLiteral

syn cluster eblAttrComponent contains=eblAttr,eblInlineText,eblLineOp

syn match eblAttr                '\v\s*(\w|-)+\=@='   contains=eblKnownEvent nextgroup=eblAttrOp                                                         contained display
syn match eblAttrOp              '='                                         nextgroup=eblAttrLit,eblAttrClassLit,eblAttrBind,eblAttrRegion              contained display
syn match eblAttrLit             /\v(["'])[^\1]{-}\1/ contains=eblItpl       nextgroup=@eblAttrComponent                                       skipwhite contained display
syn match eblAttrBind            /\v(\w|-)+/                                 nextgroup=eblAttrBindAltOp,eblAttrBindUnboundOp,@eblAttrComponent skipwhite contained display
syn match eblAttrBindAltOp       '\v(\w|-|:)@=:'                             nextgroup=eblAttrBindAlt,eblAttrBindAltOp                                   contained display
syn match eblAttrBindAlt         /\v(\w|-)+/                                 nextgroup=eblAttrBindAltOp,@eblAttrComponent                      skipwhite contained display
syn match eblAttrClassLit        '\v:(\w|-)+'                                nextgroup=@eblAttrComponent                                       skipwhite contained display
syn match eblAttrBindUnboundOp   '\v(\w|-)@!!'                               nextgroup=@eblAttrComponent                                       skipwhite contained display
hi def link eblAttrOp               eblOperator
hi def link eblAttrLit              eblLiteral
hi def link eblAttrBind             eblBind
hi def link eblAttrBindAltOp        eblOperator
hi def link eblAttrBindAlt          eblBool
hi def link eblAttrClassLit         eblLiteral
hi def link eblAttrBindUnboundOp    eblOperator

syn region eblAttrRegion matchgroup=eblAttrRegionOp start='{' end='}' keepend contains=eblAttrRegionBind,eblAttrRegionClassLit nextgroup=@eblAttrComponent skipwhite contained display
syn match eblAttrRegionBind      /\v(\w|-)+/                                 nextgroup=eblAttrRegionBindAltOp                                            contained display
syn match eblAttrRegionBindAltOp ':'                                         nextgroup=eblAttrRegionBindAlt,eblAttrRegionBindAltOp                       contained display
syn match eblAttrRegionBindAlt   /\v(\w|-)+/                                 nextgroup=eblAttrRegionBindAltOp                                            contained display
syn match eblAttrRegionClassLit  '\v:(\w|-)+:@!'                             nextgroup=eblAttrRegionBind                                       skipwhite contained display
hi def link eblAttrRegionOp         eblOperator
hi def link eblAttrRegionBind       eblBind
hi def link eblAttrRegionBindAltOp  eblOperator
hi def link eblAttrRegionBindAlt    eblBool
hi def link eblAttrRegionClassLit   eblLiteral

syn match eblKnownEvent '\v\s*<(touchStart|touchMove|touchEnd|touchCancel|keyDown|keyUp|keyPress|mouseDown|mouseUp|contextMenu|click|doubleClick|mouseMove|focusIn|focusOut|mouseEnter|mouseLeave|submit|input|change|dragStart|drag|dragEnter|dragLeave|dragOver|drop|dragEnd)>' contained display
hi def link eblKnownEvent eblEvent

syn region eblItpl matchgroup=eblItplOp start='#{' end='}'  contains=eblHbsHelper,eblHbsPartialOp keepend contained display
syn region eblItpl matchgroup=eblItplOp start='{{' end='}}' contains=eblHbsHelper,eblHbsPartialOp keepend contained display
hi def link eblItplOp eblOperator

syn match eblHbsPartialOp '\s*>' nextgroup=eblHbsHelper skipwhite contained display
hi def link eblhbsPartialOp eblOperator

syn match eblView        '\v[A-Z](\w|\.)*' nextgroup=@eblViewComponent skipwhite contained display

syn cluster eblViewComponent contains=eblViewIdOp,eblViewClassOp,eblHbsArg,eblHbsAttr,eblLineOp

syn match eblViewIdOp    '#'               nextgroup=eblViewId                   contained display
syn match eblViewId      '\v(\w|-)+'       nextgroup=@eblViewComponent           contained display
syn match eblViewClassOp '\.'              nextgroup=eblViewClass                contained display
syn match eblViewClass   '\v(\w|-)+'       nextgroup=@eblViewComponent           contained display
hi def link eblViewIdOp     eblId
hi def link eblViewId       eblId
hi def link eblViewClassOp  eblClass
hi def link eblViewClass    eblClass

syn cluster eblTag contains=eblKnownTag,eblCustomTag

syn match eblKnownTag '\v<(figcaption|blockquote|plaintext|textarea|progress|optgroup|noscript|noframes|frameset|fieldset|datalist|colgroup|basefont|summary|section|marquee|listing|isindex|details|command|caption|bgsound|article|address|acronym|strong|strike|spacer|source|select|script|output|option|object|legend|keygen|iframe|hgroup|header|footer|figure|center|canvas|button|applet|video|track|title|thead|tfoot|tbody|table|style|small|param|meter|label|input|frame|embed|blink|audio|aside|time|span|samp|ruby|nobr|meta|menu|mark|main|link|html|head|form|font|data|code|cite|body|base|area|abbr|xmp|wbr|var|sup|sub|pre|nav|map|kbd|ins|img|div|dir|dfn|del|col|big|bdo|bdi|ul|tt|tr|th|td|rt|rp|ol|li|hr|h6|h5|h4|h3|h2|h1|em|dt|dl|dd|br|u|s|q|p|i|b|a)>' nextgroup=@eblComponent contained display
syn match eblCustomTag '%[a-z][a-z0-9-]*' nextgroup=@eblComponent contained display
hi def link eblKnownTag  eblTag
hi def link eblCustomTag eblTag

syn match eblText    '\v^(\s*)[|'].*(\n\1\s.*)*' contains=eblTextOp,eblItpl
syn match eblTextOp  '\v^(\s*)[|']'                                         contained display
syn match eblComment '\v^(\s*)/.*(\n\1\s.*)*'
hi def link eblText   eblRaw
hi def link eblTextOp eblOperator


hi def link eblOperator Operator
hi def link eblFunction Function
hi def link eblBool     Boolean
hi def link eblLiteral  String
hi def link eblRaw      NONE
hi def link eblComment  Comment

hi def link eblAttr     Label
hi def link eblBind     Identifier
hi def link eblKeyword  Keyword
hi def link eblEvent    Special

hi def link eblView     Type
hi def link eblTag      Type
hi def link eblId       Constant
hi def link eblClass    Identifier

let b:current_syntax = 'emblem'