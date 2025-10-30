local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node


ls.add_snippets("c", {
	s("mainc", {
		t({ "#include <stdio.h>", "", "int main() {", "\t" }),
		i(0),
		t({ "", "}" }),
	}),
	s("iferr", {
		t({ "if (err != 0) {", '\tprintf("' }),
		i(1, "something went wrong"),
		t({ '\\n");', "}" }),
		i(0),
	}),
})



ls.add_snippets("cpp", {
	s("maincpp", {
		t({ "#include <bits/stdc++.h>", "using namespace std;", "", "int main() {", "\t" }),
		i(0),
		t({ "", "\treturn 0;", "}" }),
	}),
	s("ifer", {
		t({ "if (err) {", '\tcerr << "' }),
		i(1, "something went wrong"),
		t({ '" << endl;', "}" }),
		i(0),
	}),
})

-- mapping để nhảy trong snippet
vim.keymap.set("n", "<leader>nw", function()
	require("luasnip").jump(1)
end, { silent = true })

