function map(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true})
end

-- Normal Mode
function nmap(shortcut, command)
    map("n", shortcut, command)
end

-- Insert Mode
function imap(shortcut, command)
    map("i", shortcut, command)
end

-- Visual Mode
function vmap(shortcut, command)
    map("v", shortcut, command)
end

