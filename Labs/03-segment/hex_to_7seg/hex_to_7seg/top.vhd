------------------------------------------------------------------------
--
-- VHDL template for combinational logic circuits.
-- Xilinx XC2C256-TQ144 CPLD, ISE Design Suite 14.7
--
-- Copyright (c) 2018-2020 Tomas Fryza
-- Dept. of Radio Electronics, Brno University of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for top level
------------------------------------------------------------------------
entity top is
    port (SW1, SW0, BTN1, BTN0:    in  std_logic;
          LD3, LD2, LD1, LD0: out std_logic; 
			 disp_seg_o: out std_logic_vector(6-0 downto 0);
			 disp_dig_o: out std_logic_vector(3-0 downto 0));
end entity top;

------------------------------------------------------------------------
-- Architecture declaration for top level
------------------------------------------------------------------------
architecture Behavioral of top is
	signal s_hex: std_logic_vector(3-0 downto 0); -- vnutorna premenna
 begin

s_hex(3) <= SW1;
s_hex(2) <= SW0;
s_hex(1) <= not BTN1;
s_hex(0) <= not BTN0;
HEX2SSEG: entity work.hex_to_7seg
port map (-- <entity port_name> => <signal_name>,
			-- <entity port_name> => <signal_name>,
			-- ...
			-- <entity port_name> => <signal_name>);
			hex_i => s_hex,
			seg_o => disp_seg_o);

    -- Select display position
	 disp_dig_o <= "1110";


    -- Turn on LD3 if the input value is equal to "0000"
    -- WRITE YOUR CODE HERE
	 LD3 <= s_hex(3) or s_hex(2) or s_hex(1) or s_hex(0);

    -- Turn on LD2 if the input value is A, B, C, D, E, or F
    -- WRITE YOUR CODE HERE
	 -- A:1010 B:1011 C:1100 D:1101 E:1110 F:1111
	 LD2 <= not ((s_hex(3) and s_hex(1)) or (s_hex(3) and s_hex(2)));
	 
    -- Turn on LD1 if the input value is odd, ie 1, 3, 5, etc.
    -- WRITE YOUR CODE HERE
	 LD1 <= not s_hex(0);  -- je stlacena
	 
    -- Turn on LD0 if the input value is a power of two, ie 1, 2, 4, or 8.
    -- WRITE YOUR CODE HERE
	 LD0 <= '0' when (s_hex = "0001") else 
	        '0' when (s_hex = "0010") else
			  '0' when (s_hex = "0100") else	
			  '0' when (s_hex = "1000") else				  
			  '1';
	     

	 
end architecture Behavioral;