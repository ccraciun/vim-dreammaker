" Vim syntax file
" Language: Dream Maker
" Maintainer: Kevin Lauder
" Latest Revision: 26 April 2008

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case    match

syn match   dmInt       /-\?\<\d\+\>/
syn match   dmInt       /\<0[xX]\x+\>/

syn match   dmFloat     "\<\d\+\.\d*\([Ee][-+]\?\d\+\)\?\>"
syn match   dmFloat     "\<\.\d\+\([Ee][-+]\?\d\+\)\?\>"
syn match   dmFloat     "\<\d\+[Ee][-+]\?\d\+\>"

syn region  dmDefine            start="^\s*\(#\)\s*\(define\|undef\)\>" skip="\\$" end="$" keepend contains=ALL
syn region  dmPreProc           start="^\s*\(#\)\s*\(error\>\)" skip="\\$" end="$" keepend
syn region  dmPreCondit         start="^\s*\(#\)\s*\(if\|ifdef\|ifndef\|elif\)\>" skip="\\$" end="$" keepend contains=dmMacroDefined
syn match   dmPreConditMatch    display "^\s*\(#\)\s*\(else\|endif\)\>"
syn region  dmIncluded          display contained start=+"+ skip=+\\\\\|\\"+ end=+"+
syn match   dmIncluded          display contained "<[^>]*>"
syn match   dmInclude           display "^\s*\(#\)\s*include\>\s*["<]" contains=dmIncluded

syn keyword dmMacroSpecial      FILE_DIR DEBUG DM_VERSION __FILE__ __LINE__ display
syn keyword dmMacroDefined      defined display contained

" TODO: contains string interpolation with variables, escape codes
"syn match   dmStringEscape    display contained 
"syn match   dmStringInterp    display contained 

syn cluster dmStringGroup   contains=dmStringInterp,dmStringEscape
syn region  dmString        start=/"/ skip=/\\"/ end=/"/ contains=@dmStringGroup keepend
syn region  dmString        start=/'/ skip=/\\'/ end=/'/ contains=@dmStringGroup keepend

syn keyword dmTodo      TODO FIXME XXX NOTE
syn region  dmComment   start="/\*" end="\*/" keepend contains=dmTodo
syn region  dmComment   start="//" end="$" keepend contains=dmTodo

" TODO: Better handling for for/if
syn keyword dmKeywordControl    sleep spawn break continue do
syn keyword dmKeywordControl    else for goto if return switch while
syn keyword dmKeywordMemory     new del
syn keyword dmKeywordList       newlist typesof args

syn keyword dmTypeAtom  var proc verb datum obj mob turf area savefile list
syn keyword dmTypeAtom  client sound image database matrix regex exception
syn keyword dmTypeAtom  null text atom

syn keyword dmTypeModifier  const global set static tmp
syn keyword dmTypeDeclaration  as "  nextgroup=dmType

syn match   dmOperatorBool      /!/
syn match   dmOperatorBool      /&&/
syn match   dmOperatorBool      /||/
syn match   dmOperatorComp      /==/
syn match   dmOperatorComp      /!=/
syn match   dmOperatorComp      /<>/
syn match   dmOperatorComp      /</
syn match   dmOperatorComp      />/
syn match   dmOperatorComp      /<=/
syn match   dmOperatorComp      />=/
syn match   dmOperatorMath      /\s+\s/ms=s+1,me=e-1
syn match   dmOperatorMath      /\s-/ms=s+1
syn match   dmOperatorMath      /\s\*\s/ms=s+1,me=e-1
syn match   dmOperatorMath      /\s\/\s/ms=s+1,me=e-1
syn match   dmOperatorMath      /\s\*\*\s/ms=s+1,me=e-1
syn match   dmOperatorMath      /\s%\s/ms=s+1,me=e-1
syn match   dmOperatorMath      /++/
syn match   dmOperatorMath      /--/
syn match   dmOperatorBit       /\~/
syn match   dmOperatorBit       /&/
syn match   dmOperatorBit       /|/
syn match   dmOperatorBit       /\^/
syn match   dmOperatorBit       />>/
syn match   dmOperatorBit       /<</
syn match   dmOperatorAssign    /=/
syn match   dmOperatorAssignMath    /+=/
syn match   dmOperatorAssignMath    /-=/
syn match   dmOperatorAssignMath    /*=/
syn match   dmOperatorAssignMath    /\/=/
syn match   dmOperatorAssignMath    /**=/
syn match   dmOperatorAssignMath    /%=/
syn match   dmOperatorAssignBit     /&=/
syn match   dmOperatorAssignBit     /|=/
syn match   dmOperatorAssignBit     /^=/

syn match   dmOperatorConditional   /\s\?\s/ms=s+1,me=e-1
syn match   dmOperatorConditional   /\s:\s/ms=s+1,me=e-1

syn match   dmOperatorDereference   /\w\.\w/ms=s+1,me=e-1
syn match   dmOperatorDereference   /\w:\w/ms=s+1,me=e-1

syn match   dmOperatorLookup        /\s\.\w/ms=s+1,me=e-1

syn match   dmOperatorParent        /\.\.\ze\s*(.*)/

syn keyword dmOperatorContains      in

syn match   dmOperatorPath          /\/\w/me=e-1
syn match   dmOperatorPath          /^\s*\/\ze[^*\/]/

syn region  dmBlock         start="{" end="}" transparent fold
syn region  dmParen         start="(" end=")" transparent

syn keyword dmObjectProperty    name gender desc suffix text icon
syn match   dmObjectProperty    /icon_state/
syn keyword dmObjectProperty    dir overlays underlays visibility luminosity
syn keyword dmObjectProperty    opacity density contents verbs type
syn keyword dmObjectLocation    loc x y z
syn keyword dmObjectMobProperty key ckey client sight group
syn keyword dmVerbProperty      name desc category hidden src
syn keyword dmListProperty      len

syn match   dmVariableSelf      /\<\.\>/  " TODO: make sure this is matched only by itself

if version >= 508 || !exists("did_dreammaker_syn_inits")
  if version < 508
    let did_dreammaker_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink dmInclude          Include
  HiLink dmIncluded         String
  HiLink dmPreProc          PreProc
  HiLink dmDefine           Macro
  HiLink dmPreCondit        PreCondit
  HiLink dmPreConditMatch   PreCondit
  HiLink dmMacroDefined     Keyword
  HiLink dmMacroSpecial     Keyword

  HiLink dmTodo         Todo
  HiLink dmComment      Comment

  HiLink dmKeywordControl   Keyword
  HiLink dmKeywordMemory    Keyword
  HiLink dmKeywordList      Keyword

  HiLink dmTypeAtom         Type
  HiLink dmTypeModifier     PreProc  " TODO Custom type for this
  HiLink dmTypeDeclaration  PreProc

  HiLink dmInt      Number
  HiLink dmFloat    Float
  HiLink dmString   String

  HiLink dmOperatorBool         Operator
  HiLink dmOperatorComp         Operator
  HiLink dmOperatorMath         Operator
  HiLink dmOperatorBit          Operator
  HiLink dmOperatorAssign       Operator
  HiLink dmOperatorAssignMath   Operator
  HiLink dmOperatorAssignBit    Operator
  HiLink dmOperatorConditional  Operator
  HiLink dmOperatorDereference  Operator
  HiLink dmOperatorPath         Operator
  HiLink dmOperatorLookup       Operator
  HiLink dmOperatorParent       Operator

  HiLink dmOperatorContains     Operator

  HiLink dmObjectProperty       Identifier
  HiLink dmObjectLocation       Identifier
  HiLink dmObjectMobProperty    Identifier
  HiLink dmVerbProperty         Identifier
  HiLink dmListProperty         Identifier

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
