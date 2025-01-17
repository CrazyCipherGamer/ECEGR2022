--------------------------------------------------------------------------------
--
-- LAB #5 - Memory and Register Bank
--
--------------------------------------------------------------------------------
LIBRARY ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity RAM is
    Port(Reset:	  in std_logic;
	 Clock:	  in std_logic;	 
	 OE:      in std_logic;
	 WE:      in std_logic;
	 Address: in std_logic_vector(29 downto 0);
	 DataIn:  in std_logic_vector(31 downto 0);
	 DataOut: out std_logic_vector(31 downto 0));
end entity RAM;

architecture staticRAM of RAM is

   type ram_type is array (0 to 127) of std_logic_vector(31 downto 0);
   signal i_ram : ram_type;

begin

  RamProc: process(Clock, Reset, OE, WE, Address) is

  begin
    if Reset = '1' then
      for i in 0 to 127 loop   
          i_ram(i) <= X"00000000";
      end loop;
    end if;

    if falling_edge(Clock) then
	-- Add code to write data to RAM
	-- Use to_integer(unsigned(Address)) to index the i_ram array
		if WE = '1' then
			if to_integer(unsigned(Address)) >= 0 AND to_integer(unsigned(Address)) <= 127 then
				i_ram(to_integer(unsigned(Address))) <= DataIn;
			end if;
		end if;	
    end if;
    
    if to_integer(unsigned(Address)) >= 0 AND to_integer(unsigned(Address)) <= 127 then
		if OE = '0' then
			DataOut <= i_ram(to_integer(unsigned(Address)));
		else
			DataOut <= (others => 'Z');
		end if;
    else
	DataOut <= (Others => 'Z');		
    end if;
    
	
	
  end process RamProc;

end staticRAM;	


--------------------------------------------------------------------------------
LIBRARY ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity Registers is
    Port(ReadReg1: in std_logic_vector(4 downto 0); 
         ReadReg2: in std_logic_vector(4 downto 0); 
         WriteReg: in std_logic_vector(4 downto 0);
	 WriteData: in std_logic_vector(31 downto 0);
	 WriteCmd: in std_logic;
	 ReadData1: out std_logic_vector(31 downto 0);
	 ReadData2: out std_logic_vector(31 downto 0));
end entity Registers;

architecture remember of Registers is
	component register32
  	    port(datain: in std_logic_vector(31 downto 0);
		 enout32,enout16,enout8: in std_logic;
		 writein32, writein16, writein8: in std_logic;
		 dataout: out std_logic_vector(31 downto 0));
	end component;
	SIGNAL regWrite: std_logic_vector(7 downto 0);
	TYPE dataArray is Array(7 downto 0) of std_logic_vector(31 downto 0);
	SIGNAL regData: dataArray;
begin

	regWrite <= "00000001" WHEN WriteReg = "01010" AND WriteCmd = '1' ELSE
		    "00000010" WHEN WriteReg ="01011" AND WriteCmd = '1' ELSE
		    "00000100" WHEN WriteReg ="01100" AND WriteCmd = '1' ELSE
	  	    "00001000" WHEN WriteReg ="01101" AND WriteCmd = '1' ELSE
		    "00010000" WHEN WriteReg ="01110" AND WriteCmd = '1' ELSE
		    "00100000" WHEN WriteReg = "01111" AND WriteCmd = '1' ELSE
		    "01000000" WHEN WriteReg ="10000" AND WriteCmd = '1' ELSE
		    "10000000" WHEN WriteReg ="10001" AND WriteCmd = '1' ELSE
		    "00000000";
	
	
	RegisterMap: FOR i in 7 downto 0 GENERATE
		Ai: register32 PORT MAP(WriteData, '0', '1', '1', regWrite(i), '0', '0', regData(i));
	END GENERATE;

	WITH ReadReg1 SELECT
		ReadData1 <= regData(0) WHEN "01010",
			     regData(1) WHEN "01011",
			     regData(2) WHEN "01100",
			     regData(3) WHEN "01101",
			     regData(4) WHEN "01110",
			     regData(5) WHEN "01111",
			     regData(6) WHEN "10000",
                             regData(7) WHEN "10001",
			     (OTHERS => '0') WHEN "00000",
			     (Others => 'Z') WHEN OTHERS;
	WITH ReadReg2 SELECT
		ReadData2 <= regData(0) WHEN "01010",
			     regData(1) WHEN "01011",
			     regData(2) WHEN "01100",
			     regData(3) WHEN "01101",
			     regData(4) WHEN "01110",
			     regData(5) WHEN "01111",
			     regData(6) WHEN "10000",
                             regData(7) WHEN "10001",
			     (OTHERS => '0') WHEN "00000",
			     (OThers => 'Z') WHEN OTHERS;
    

end remember;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
