--------------------------------------------------------------------------------
--
-- Test Bench for LAB #4
--
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY testALU_vhd IS
END testALU_vhd;

ARCHITECTURE behavior OF testALU_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT ALU
		Port(	DataIn1: in std_logic_vector(31 downto 0);
			DataIn2: in std_logic_vector(31 downto 0);
			ALUCtrl: in std_logic_vector(4 downto 0);
			Zero: out std_logic;
			ALUResult: out std_logic_vector(31 downto 0) );
	end COMPONENT ALU;

	--Inputs
	SIGNAL datain_a : std_logic_vector(31 downto 0) := (others=>'0');
	SIGNAL datain_b : std_logic_vector(31 downto 0) := (others=>'0');
	SIGNAL control	: std_logic_vector(4 downto 0)	:= (others=>'0');

	--Outputs
	SIGNAL result   :  std_logic_vector(31 downto 0);
	SIGNAL zeroOut  :  std_logic;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: ALU PORT MAP(
		DataIn1 => datain_a,
		DataIn2 => datain_b,
		ALUCtrl => control,
		Zero => zeroOut,
		ALUResult => result
	);
	

	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		wait for 100 ns;

		-- Start testing the ALU
		datain_a <= X"01234567";	-- DataIn in hex
		datain_b <= X"11223344";
		control  <= "00010";		-- Control in binary (ADD and ADDI test)
		wait for 100 ns; 			-- result = 0x124578AB  and zeroOut = 0

		control <= "10010";		--ADDI test
		wait for 100 ns;

		datain_a <= x"01234567";
		datain_b <= x"11223344";
		control <= "00110";		--SUB test
		wait for 100 ns;			--result = 0xF0011223 and zeroOut = 0

		datain_a <= x"11223344";
		control <= "00110";		--SUB test with zero result
		wait for 100 ns;			--result = 0x00000000 and zeroOut = 1

		datain_b <= x"FFFFFFFF";
		control <= "00000";		--AND test
		wait for 100 ns;			--result = 0x11223344 and zeroOut = 0

		control <= "10000";		--ANDI test
		wait for 100 ns;

		datain_a <= x"50505050";
		datain_b <= x"05050505";
		control <= "00001";		--OR test
							--result = 0x55555555
		wait for 100 ns;

		control <= "10001";		--ORI test
		wait for 100 ns;

		datain_a <= x"FFAABBCC";
		datain_b <= x"00000002";	--sll test
		control <= "00011";			--result = 0xFEAAEF30
		wait for 100 ns;

		control <= "10011";		--slli test
		wait for 100 ns;

		control <= "00100";		--srl test
		wait for 100 ns;			--result = 0x3FEAAEF3

		control <= "10100";		--srli test
		wait for 100 ns;

		control <= "11111";		--Pass through
		wait for 100 ns;			--result = 0x00000002


		wait; -- will wait forever
	END PROCESS;

END;