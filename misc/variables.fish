# Append qt installation to path, for cmake to find it
set PATH /usr/local/opt/qt@5/bin $PATH

# Append LLVM installation to path
# Homebrew does not link it to prevent overwriting apples built-in version, but it is needed for clangd
set PATH /usr/local/opt/llvm/bin $PATH

# Sets the upload URL for haste-client to Leppunen's instance
set -x HASTE_SERVER https://paste.ivr.fi

set -x PAGER less 
set -x EDITOR nvim
set -x VISUAL nvim
