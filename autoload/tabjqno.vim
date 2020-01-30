function! tabjqno#complete()
    if pumvisible()
        return "\<C-N>"
    endif

    let l:line = getline('.')
    let l:substr = strpart(l:line, 0, col('.') - 1)
    let l:substr = matchstr(l:substr, '\S*$')

    let l:only_whitespace = strlen(l:substr) == 0
    if (l:only_whitespace)
        return "\<Tab>"
    endif

    let l:has_slash = match(l:substr, '\/') != -1
    let l:has_html_slash = match(l:substr, '<\/') != -1
    if (l:has_slash && !l:has_html_slash)
        return "\<C-X>\<C-F>"
    endif

    if exists('g:did_plugin_ultisnips') && has_key(UltiSnips#SnippetsInCurrentScope(0), l:substr)
        return "\<C-R>=UltiSnips#ExpandSnippet()\<CR>"
    endif

    if exists('&omnifunc') && &omnifunc !=# ''
        return "\<C-X>\<C-O>"
    endif

    return "\<C-X>\<C-P>"
endfunction

