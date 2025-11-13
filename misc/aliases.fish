abbr -ag ls ls -AFhlO
abbr -ag lss ls -ltr

abbr -ag rmrf rm -rf
abbr -ag c clear

abbr -ag caffeinate caffeinate -d -i -u -s

# compile command for chatterino2 https://github.com/chatterino/chatterino2
abbr -ag c2make 'cmake -DCMAKE_BUILD_TYPE=Debug -DUSE_PRECOMPILED_HEADERS=Off -DCMAKE_EXPORT_COMPILE_COMMANDS=YES .. && make -j5'
