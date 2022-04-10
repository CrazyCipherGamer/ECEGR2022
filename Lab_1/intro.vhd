library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity intro is
port(
	A: in std_logic;
	B: in std_logic;
	C: in std_logic;
	D: in std_logic;
	E: out std_logic);
end intro;

architecture behavior of intro is
begin
	E <= (A OR B) AND (C OR D);
end architecture behavior;
