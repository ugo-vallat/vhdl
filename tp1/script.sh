# !/bin/bash

composants="pulse_gen"
test="test_pulse_gen"

if [[ $1 = "clear" ]] then
    rm -rf *.o *.ghw *.cf $test
elif [[ $1 = "run" ]] then
    ghdl -a --ieee=synopsys -fexplicit $composants.vhd $test.vhd
    ghdl -e --ieee=synopsys -fexplicit $test
    ghdl -r --ieee=synopsys -fexplicit $test --wave=test_pulse_gen.ghw
    gtkwave $test.ghw
elif [[ $1 = "display" ]] then
    gtkwave $test.ghw
fi

