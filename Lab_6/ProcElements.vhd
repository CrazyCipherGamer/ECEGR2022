--------------------------------------------------------------------------------
--
-- LAB #6 - Processor Elements
--
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BusMux2to1 is
	Port(	selector: in std_logic;
			In0, In1: in std_logic_vector(31 downto 0);
			Result: out std_logic_vector(31 downto 0) );
end entity BusMux2to1;

architecture selection of BusMux2to1 is
begin
    WITH selector SELECT
        Result <= In0 WHEN '0',
                  In1 WHEN OTHERS;
end architecture selection;

--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Control is
      Port(clk : in  STD_LOGIC;
           opcode : in  STD_LOGIC_VECTOR (6 downto 0);
           funct3  : in  STD_LOGIC_VECTOR (2 downto 0);
           funct7  : in  STD_LOGIC_VECTOR (6 downto 0);
           Branch : out  STD_LOGIC_VECTOR(1 downto 0);
           MemRead : out  STD_LOGIC;
           MemtoReg : out  STD_LOGIC;
           ALUCtrl : out  STD_LOGIC_VECTOR(4 downto 0);
           MemWrite : out  STD_LOGIC;
           ALUSrc : out  STD_LOGIC;
           RegWrite : out  STD_LOGIC;
           ImmGen : out STD_LOGIC_VECTOR(1 downto 0));
end Control;

architecture Boss of Control is
	SIGNAL intermediateALUCtrl: std_logic_vector(4 DOWNTO 0);
begin
	intermediateALUCtrl <= "00010" WHEN opcode = "0110011" AND funct3 = "000" AND funct7 = "0000000" ELSE	--ADD
		"00110" WHEN opcode = "0110011" AND funct3 = "000" AND funct7 = "0100000" ELSE		--SUB
		"00001" WHEN opcode = "0110011" AND funct3 = "110" AND funct7 = "0000000" ELSE		--OR
		"00000" WHEN opcode = "0110011" AND funct3 = "111" AND funct7 = "0000000" ELSE		--AND
		"00011" WHEN opcode = "0110011" AND funct3 = "001" AND funct7 = "0000000" ELSE		--SLL
		"00100" WHEN opcode = "0110011" AND funct3 = "101" AND funct7 = "0000000" ELSE		--SRL
		"10010"	WHEN opcode = "0010011" AND funct3 = "000" ELSE					--ADDI 
		"10001" WHEN opcode = "0010011" AND funct3 = "110" ELSE					--ORI
		"10000" WHEN opcode = "0010011" AND funct3 = "111" ELSE					--ANDI
		"10011" WHEN opcode = "0010011" AND funct3 = "001" ELSE					--SLLI
		"10100" WHEN opcode = "0010011" AND funct3 = "101" ELSE					--SRLI
		"00110" WHEN opcode = "1100011" AND (funct3 = "000" OR funct3 = "001") ELSE		--BEQ or BNE	(Subraction allows to compare equality or lack therefore)
		"10010" WHEN opcode = "0000011" OR opcode = "0100011" ELSE				--LW/SW		(Addition calculates effective address for getting data)
		"11111" WHEN opcode = "0110111" ELSE							--LUI
		"01111";										--Pass Through otherwise
	ALUCtrl <= intermediateALUCtrl;

	Branch <= "01" WHEN opcode = "1100011" AND funct3 = "000" ELSE		--BEQ
		  "10" WHEN opcode = "1100011" AND funct3 = "001" ELSE		--BNE
		  "00";								--No Branch

	ALUSrc <= '0' WHEN intermediateALUCtrl(4) = '0' ELSE
		  '1';
	ImmGen <= "00" WHEN opcode = "0010011" OR opcode = "0000011" ELSE	--Immediate generation for I-types / LW
		  "01" WHEN opcode = "0100011" ELSE				--ImmGen for S-type
		  "10" WHEN opcode = "1100011" ELSE				--ImmGen for B-type
		  "11";								--No ImmGen for R-type or U-type

	RegWrite <= '1' WHEN (opcode = "0110111" OR opcode = "0000011" OR opcode = "0010011" OR opcode = "0110011") AND clk = '0' ELSE
		    '0';

	MemWrite <= '1' WHEN opcode = "0100011" ELSE
		    '0';
	MemRead <= '0' WHEN opcode = "0000011" ELSE
		   '1';
	MemToReg <= '1' WHEN opcode = "0000011" ELSE
		    '0';

end Boss;

--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ProgramCounter is
    Port(Reset: in std_logic;
	 Clock: in std_logic;
	 PCin: in std_logic_vector(31 downto 0);
	 PCout: out std_logic_vector(31 downto 0));
end entity ProgramCounter;

architecture executive of ProgramCounter is
begin
    PROCESS(Reset, Clock) IS
    BEGIN
        IF(Reset = '1') THEN
            PCout <= x"00400000";
        end IF;
	IF rising_edge(Clock) THEN
		PCout <= PCin;
	END IF;
    END PROCESS;
end executive;
--------------------------------------------------------------------------------
