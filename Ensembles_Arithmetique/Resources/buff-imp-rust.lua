local format, tohash = string.format, table.tohash
local P, S, V, patterns = lpeg.P, lpeg.S, lpeg.V, lpeg.patterns

local context                 = context
local verbatim                = context.verbatim
local makepattern             = visualizers.makepattern

local RustSnippet             = context.RustSnippet
local startRustSnippet        = context.startRustppSnippet
local stopRustSnippet         = context.stopRustppSnippet

local RustSnippetBoundary     = verbatim.RustSnippetBoundary
local RustSnippetQuote        = verbatim.RustSnippetQuote
local RustSnippetString       = verbatim.RustSnippetString
local RustSnippetSpecial      = verbatim.RustSnippetSpecial
local RustSnippetComment      = verbatim.RustSnippetComment
local RustSnippetPreprocess   = verbatim.RustSnippetPreprocess
local RustSnippetNameKeyword  = verbatim.RustSnippetNameKeyword
local RustSnippetName         = verbatim.RustSnippetName

local keywords = tohash {
    "mod", "use", "pub",
    "let", "mut", "fn", "return",
    "while", "for", "if", "else", "try",
    "usize", "bool",
}

local function visualizename(s)
    if keywords[s] then
        RustSnippetNameKeyword(s)
    else
        RustSnippetName(s)
    end
end

local handler = visualizers.newhandler {
    startinline  = function() RustSnippet(false,"{") end,
    stopinline   = function() context("}") end,

    startdisplay = function() startRustSnippet() end,
    stopdisplay  = function() stopRustSnippet() end ,

    boundary     = function(s) RustSnippetBoundary(s) end,
    special      = function(s) RustSnippetSpecial(s) end,
    comment      = function(s) RustSnippetComment(s) end,
    preprocess   = function(s) RustSnippetPreprocess(s) end,
    quote        = function(s) RustSnippetString(s) end,
    string       = function(s) RustSnippetString(s) end,

    name         = visualizename,
}

local comment     = P("//")
local name        = (patterns.letter + S("_"))^1
local boundary    = S('()[]<>;"')
local special     = S("&") + P("->")
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

visualizers.register("rust", { parser = parser, handler = handler, grammar = grammar } )
