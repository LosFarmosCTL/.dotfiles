abbr -ag ls ls -AFhlO
abbr -ag c clear

abbr -ag cat bat

# compile command for chatterino2 https://github.com/chatterino/chatterino2
abbr -ag c2make cmake -DCMAKE_BUILD_TYPE=Debug -DUSE_PRECOMPILED_HEADERS=Off -DCMAKE_EXPORT_COMPILE_COMMANDS=YES .. && make -j5
