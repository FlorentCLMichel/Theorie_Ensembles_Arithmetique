local format, tohash = string.format, table.tohash
local P, S, V, patterns = lpeg.P, lpeg.S, lpeg.V, lpeg.patterns

local context                 = context
local verbatim                = context.verbatim
local makepattern             = visualizers.makepattern

local HaskellSnippet              = context.HaskellSnippet
local startHaskellSnippet         = context.startHaskellSnippet
local stopHaskellSnippet          = context.stopHaskellSnippet

local HaskellSnippetBoundary      = verbatim.HaskellSnippetBoundary
local HaskellSnippetQuote         = verbatim.HaskellSnippetQuote
local HaskellSnippetString        = verbatim.HaskellSnippetString
local HaskellSnippetSpecial       = verbatim.HaskellSnippetSpecial
local HaskellSnippetComment       = verbatim.HaskellSnippetComment
local HaskellSnippetPreprocess    = verbatim.HaskellSnippetPreprocess
local HaskellSnippetNameKeyword   = verbatim.HaskellSnippetNameKeyword
local HaskellSnippetName          = verbatim.HaskellSnippetName

local keywords = tohash {
    "let",
    "Integer",
    "add", "sub", "div", "mod",
    "otherwise"
}

local function visualizename(s)
    if keywords[s] then
        HaskellSnippetNameKeyword(s)
    else
        HaskellSnippetName(s)
    end
end

local handler = visualizers.newhandler {
    startinline  = function() HaskellSnippet(false,"{") end,
    stopinline   = function() context("}") end,

    startdisplay = function() startHaskellSnippet() end,
    stopdisplay  = function() stopHaskellSnippet() end ,

    boundary     = function(s) HaskellSnippetBoundary(s) end,
    special      = function(s) HaskellSnippetSpecial(s) end,
    comment      = function(s) HaskellSnippetComment(s) end,
    preprocess   = function(s) HaskellSnippetPreprocess(s) end,
    quote        = function(s) HaskellSnippetString(s) end,
    string       = function(s) HaskellSnippetString(s) end,

    name         = visualizename,
}

local comment     = P("--")
local name        = (patterns.letter + S("_"))^1
local boundary    = S('()[]=<>;"')
local special     = S("|&") + P("::") + P("->")
local punctuation = S("_-+().,;?!")

local grammar = visualizers.newgrammar("default", { "visualizer",

    comment     = makepattern(handler,"comment",comment)
                * makepattern(handler,"comment"," "+patterns.letter+patterns.digit+punctuation)^0,
    preprocess  = makepattern(handler,"preprocess","#")
                * makepattern(handler,"preprocess",patterns.letter)^0,
    dstring     = makepattern(handler,"quote",patterns.dquote)
                * makepattern(handler,"string",patterns.nodquote)
                * makepattern(handler,"quote",patterns.dquote),
    name        = makepattern(handler,"name",name),
    boundary    = makepattern(handler,"boundary",boundary),
    special     = makepattern(handler,"special",special),

    pattern     =
        V("comment") + V("preprocess") + V("dstring") + V("name") + V("boundary") + V("special")
      + V("newline") * V("emptyline")^0 * V("beginline")
      + V("space")
      + V("default"),

    visualizer  =
        V("pattern")^1

} )

local parser = P(grammar)

visualizers.register("haskell", { parser = parser, handler = handler, grammar = grammar } )
