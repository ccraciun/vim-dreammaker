" Vim syntax file
" Language: Dream Maker
" Maintainer: Kevin Lauder
" Latest Revision: 26 April 2008

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn match   dmInt   /-\?\<\d\+\>/
syn match   dmInt   /\<0[xX]\x+\>/
syn match   dmFloat /\<-\?\d*\(\.\d*\)\?\([eE]\d+\)\?/
syn region  dmString  start=/"/ skip=/\\"/ end=/"/
syn region  dmString  start=/'/ skip=/\\'/ end=/'/

syn keyword dmTodo TODO FIXME XXX NOTE
syn region  dmComment start="/\*" end="\*/" keepend contains=dmTodo
syn region  dmComment start="//" end="$" keepend

syn keyword dmKeywordControl    sleep spawn break continue do
syn keyword dmKeywordControl    else for goto if return switch while

syn keyword dmKeywordMemory     new del

syn keyword dmType  var proc verb datum obj mob turf area savefile list
syn keyword dmType  client sound image database matrix regex exception text
syn match   dmType  #atom\(/movable\)\?#

syn keyword dmTypeModifier  as const global set static tmp

"syn match   dmOperator  /\s*\s/
"syn match   dmOperator  /./
"syn match   dmOperator  /:/

syn keyword dmObjectProperty    name gendder desc suffix text icon
syn match   dmObjectProperty    /icon_state/
syn keyword dmObjectProperty    dir overlays underlays visibility luminosity
syn keyword dmObjectProperty    opacity density contents verbs type
syn keyword dmObjectLocation    loc x y z
syn keyword dmObjectMobProperty key ckey client sight group


if version >= 508 || !exists("did_dreammaker_syn_inits")
  if version < 508
    let did_dreammaker_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink dmTodo         Todo
  HiLink dmComment      Comment

  HiLink dmKeywordControl   Keyword
  HiLink dmKeywordMemory    Keyword

  HiLink dmType         Type
  HiLink dmTypeModifier PreProc  " TODO Custom type for this

  HiLink dmInt      Number
  HiLink dmFloat    Float
  HiLink dmString   String

"  HiLink pbSyntax       Include
"  HiLink pbStructure    Structure
"  HiLink pbRepeat       Repeat
"  HiLink pbDefault      Keyword
"  HiLink pbExtend       Keyword
"  HiLink pbRPC          Keyword
"  HiLink pbType         Type
"  HiLink pbTypedef      Typedef
"  HiLink pbBool         Boolean
"
"  HiLink pbInt          Number
"  HiLink pbFloat        Float
"  HiLink pbString       String

  delcommand HiLink
endif

let b:current_syntax = "dreammaker"
