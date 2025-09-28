local format, tohash = string.format, table.tohash
local P, S, V, patterns = lpeg.P, lpeg.S, lpeg.V, lpeg.patterns

local context                 = context
local verbatim                = context.verbatim
local makepattern             = visualizers.makepattern

local CppSnippet              = context.CppSnippet
local startCppSnippet         = context.startCppSnippet
local stopCppSnippet          = context.stopCppSnippet

local CppSnippetBoundary      = verbatim.CppSnippetBoundary
local CppSnippetQuote         = verbatim.CppSnippetQuote
local CppSnippetString        = verbatim.CppSnippetString
local CppSnippetSpecial       = verbatim.CppSnippetSpecial
local CppSnippetComment       = verbatim.CppSnippetComment
local CppSnippetPreprocess    = verbatim.CppSnippetPreprocess
local CppSnippetNameKeyword   = verbatim.CppSnippetNameKeyword
local CppSnippetName          = verbatim.CppSnippetName

local keywords = tohash {
    "typedef", "template", "return",
    "void", "const", "unsigned", 
    "char", "struct", "bool",
    "int", "long", "float", "double",
    "std", "vector", "iostream", "array",
    "cout", "endl", "cerr",
    "while", "do", "for", "if", "else", "try", "catch",
}

local function visualizename(s)
    if keywords[s] then
        CppSnippetNameKeyword(s)
    else
        CppSnippetName(s)
    end
end

local handler = visualizers.newhandler {
    startinline  = function() CppSnippet(false,"{") end,
    stopinline   = function() context("}") end,

    startdisplay = function() startCppSnippet() end,
    stopdisplay  = function() stopCppSnippet() end ,

    special      = function(s) CppSnippetSpecial(s) end,
    boundary     = function(s) CppSnippetBoundary(s) end,
    comment      = function(s) CppSnippetComment(s) end,
    preprocess   = function(s) CppSnippetPreprocess(s) end,
    quote        = function(s) CppSnippetString(s) end,
    string       = function(s) CppSnippetString(s) end,

    name         = visualizename,
}

local comment     = P("//")
local name        = (patterns.letter + S("_"))^1
local special     = S("|&!") + P("::")
local boundary    = S('()[]:=<>;"')
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
    special     = makepattern(handler,"special",special),
    boundary    = makepattern(handler,"boundary",boundary),

    pattern     =
        V("comment") + V("preprocess") + V("dstring") + V("name") + V("special") + V("boundary")
      + V("newline") * V("emptyline")^0 * V("beginline")
      + V("space")
      + V("default"),

    visualizer  =
        V("pattern")^1

} )

local parser = P(grammar)

visualizers.register("cpp", { parser = parser, handler = handler, grammar = grammar } )
