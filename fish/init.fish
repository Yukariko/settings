function agi
    apt-get install $argv
end

function l
    ls -a $argv
end

function lsl
    ls -al $argv
end

function ps
    /bin/ps -ef $argv
end

function ncore
    cat /proc/cpuinfo | grep -c "processor" $argv
end

function buildcpp
    g++ -o (string split "." -- $argv[1])[1] $argv[1] -std=c++11 -O2 -Wall
end

function mmv
    find . -maxdepth 1 -name "*$argv[1]" -exec bash -c 'mv "$1" "${1%$2}$3"' _ "{}" $argv[1] $argv[2] \;
end

