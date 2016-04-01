" Vim syntax file
" Language: Dream Maker
" Maintainer: ccraciun
" Latest Revision: 31 Mar 2016
" Bits of code adapted from c.vim and html.vim

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case    match

""" Int/Float Immediates

syn match   dmInt       /-\?\<\d\+\>/
syn match   dmInt       /\<0[xX]\x+\>/

syn match   dmFloat     "\<\d\+\.\d*\([Ee][-+]\?\d\+\)\?\>"
syn match   dmFloat     "\<\.\d\+\([Ee][-+]\?\d\+\)\?\>"
syn match   dmFloat     "\<\d\+[Ee][-+]\?\d\+\>"

""" Preprocessor

syn region  dmDefine            start="^\s*\(#\)\s*\(define\|undef\)\>" skip="\\$" end="$" keepend contains=ALL
syn region  dmPreProc           start="^\s*\(#\)\s*\(warn\>\|error\>\)" skip="\\$" end="$" keepend
syn region  dmPreCondit         start="^\s*\(#\)\s*\(if\|ifdef\|ifndef\|elif\)\>" skip="\\$" end="$" keepend contains=dmMacroDefined
syn match   dmPreConditMatch    display "^\s*\(#\)\s*\(else\|endif\)\>"
syn region  dmIncluded          display contained start=+"+ skip=+\\\\\|\\"+ end=+"+
syn match   dmIncluded          display contained "<[^>]*>"
syn match   dmInclude           display "^\s*\(#\)\s*include\>\s*["<]" contains=dmIncluded

syn keyword dmMacroSpecial      display FILE_DIR DEBUG DM_VERSION __FILE__ __LINE__ __MAIN__
syn keyword dmMacroDefined      display contained defined

syn cluster dmPreprocGroup      contains=dmDefine,dmPreProc,dmPreCondit,dmPreConditMatch,dmInclude,dmIncluded

""" String Immediates

"" String escapes, interpolation, entities, macros
syn match   dmStringEscape      display contained +\\[abfnrtv\\'"<>]+
syn match   dmStringEscape      display contained +\\\((space)\|(newline)\)+
syn match   dmStringMacro       contained display +\\\([Hh]is\|[Hh]ers\|[Tt]he\|[Aa]n\?\|[Hh]e\|[Ss]he\|him\|himself\|herself\|hers\|\(im\)\?proper\|th\|s\|icon\|ref\|[Rr]oman\|\.\.\.\)\>+
syn region  dmStringInterp      contained start=/\[/ end=/\]/ contains=ALLBUT,dmPreprocGroup keepend
syn match   dmStringEntity      contained /&\w\w*;/

"" String Html
syntax include @HTML syntax/html.vim

syntax sync fromstart

"" The actual string

syn cluster dmStringGroup   contains=dmStringInterp,dmStringEscape,dmStringMacro,dmStringEntity,@HTML
syn region  dmString        start=/"/ skip=/\\"/ end=/"/ contains=@dmStringGroup keepend
syn region  dmString        start=/'/ skip=/\\'/ end=/'/ contains=@dmStringGroup keepend
syn region  dmString        start=/{"/ skip=/\\"/ end=/"}/ contains=@dmStringGroup keepend

""" Comments

syn keyword dmTodo      TODO FIXME XXX NOTE
syn region  dmComment   start="/\*" end="\*/" keepend contains=dmTodo
syn region  dmComment   start="//" end="$" keepend contains=dmTodo

" TODO: Better handling for for/if/switch
syn keyword dmKeywordControl    sleep spawn break continue do
syn keyword dmKeywordControl    else for goto if return switch while to try catch
syn keyword dmKeywordMemory     new del
syn keyword dmKeywordList       newlist typesof args arglist

syn keyword dmLangProc          contained ASSERT CRASH EXCEPTION addtext alert animate block bounds
syn keyword dmLangProc          contained bounds_dist browse browse_rsc call ckey ckeyEx fcopy fcopy_rsc fdel
syn keyword dmLangProc          contained fexists file file2text text2file flick flist ftp get_dir get_dist
syn keyword dmLangProc          contained get_step get_step_away get_step_rand get_step_to get_step_towards
syn keyword dmLangProc          contained hascall hearers html_decode html_encode icon_states image initial input
syn keyword dmLangProc          contained isarea isfile isicon isloc ismob isnull isnum isobj ispath issaved
syn keyword dmLangProc          contained istext isturf istype length link list2params params2list locate log
syn keyword dmLangProc          contained matrix md5 obounds ohearers orange output oview oviewers rgb run
syn keyword dmLangProc          contained shell shutdown sleep sound spawn startup stat statpanel step
syn keyword dmLangProc          contained step_away step_rand step_to step_towards turn view viewers walk
syn keyword dmLangProc          contained walk_away walk_rand walk_to walk_towards winclone winexists winget
syn keyword dmLangProc          contained winset winshow
syn keyword dmLangProcMath      contained abs arcsin arccos sin cos max min prob pick rand rand_seed range
syn keyword dmLangProcMath      contained roll round sqrt
syn keyword dmLangProcText      contained ascii2text text2ascii cmptext cmptextEx copytext findtext findtextEx
syn keyword dmLangProcText      contained lentext lowertext uppertext num2text text2num sorttext sorttextEx
syn keyword dmLangProcText      contained text time2text url_decode url_encode

syn match   dmProcCall          /\w\w*\s*(/ contains=dmLangProc,dmLangProcMath,dmLangProcText

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

syn keyword dmObjectProperty    name gender desc suffix text icon icon_state
syn keyword dmObjectProperty    dir overlays underlays visibility luminosity
syn keyword dmObjectProperty    opacity density contents verbs type
syn keyword dmObjectLocation    loc x y z
syn keyword dmObjectMobProperty key ckey client sight group
syn keyword dmVerbProperty      name desc category hidden src
syn keyword dmListProperty      len

syn match   dmVariableSelf      /\<\.\>/

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

  HiLink dmStringEscape     Special
  HiLink dmStringMacro      Special
  HiLink dmStringEntity     Special

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

  HiLink dmLangProc         Identifier
  HiLink dmLangProcMath     Identifier
  HiLink dmLangProcText     Identifier

  delcommand HiLink
endif

let b:current_syntax = "dreammaker"
