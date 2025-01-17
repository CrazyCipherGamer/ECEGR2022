--------------------------------------------------------------------------------
--
-- LAB #4
--
--------------------------------------------------------------------------------

Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity ALU is
	Port(	DataIn1: in std_logic_vector(31 downto 0);
		DataIn2: in std_logic_vector(31 downto 0);
		ALUCtrl: in std_logic_vector(4 downto 0);
		Zero: out std_logic;
		ALUResult: out std_logic_vector(31 downto 0) );
end entity ALU;

architecture ALU_Arch of ALU is
	-- ALU components	
	component adder_subtracter
		port(	datain_a: in std_logic_vector(31 downto 0);
			datain_b: in std_logic_vector(31 downto 0);
			add_sub: in std_logic;
			dataout: out std_logic_vector(31 downto 0);
			co: out std_logic);
	end component adder_subtracter;

	component shift_register
		port(	datain: in std_logic_vector(31 downto 0);
		   	dir: in std_logic;
			shamt:	in std_logic_vector(4 downto 0);
			dataout: out std_logic_vector(31 downto 0));
	end component shift_register;
	SIGNAL add_sub_out, or_out, and_out, shift_out, intermediate: std_logic_vector(31 downto 0);
	SIGNAL carry_out: std_logic;
begin
	ADD_SUB: adder_subtracter PORT MAP(DataIn1, DataIn2, ALUCtrl(2), add_sub_out, carry_out);
	SHIFT: shift_register PORT MAP(DataIn1, ALUCtrl(2), DataIn2(4 downto 0), shift_out);
	or_out <= DataIn1 OR DataIn2;
	and_out <= DataIn1 AND DataIn2;

	--Mux output select
	intermediate <= add_sub_out WHEN ALUCtrl(3 downto 0) = "0010" OR ALUCtrl(3 downto 0) = "0110" ELSE
		     shift_out WHEN ALUCtrl(3 downto 0) = "0011" OR ALUCtrl(3 downto 0) = "0100" ELSE
		     or_out WHEN ALUCtrl(3 downto 0) = "0001" ELSE
		     and_out WHEN ALUCtrl(3 downto 0) = "0000" ELSE
		     DataIn2 WHEN ALUCtrl(3 downto 0) = "1111";
	
	ALUResult <= intermediate;

	WITH intermediate SELECT
		Zero <= '1' WHEN x"00000000",
			'0' WHEN OTHERS;

end architecture ALU_Arch;


