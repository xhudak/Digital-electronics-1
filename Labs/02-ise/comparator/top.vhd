------------------------------------------------------------------------
--
-- VHDL template for combinational logic circuits.
-- Xilinx XC2C256-TQ144 CPLD, ISE Design Suite 14.7
--
-- Copyright (c) 2018-2020 Tomas Fryza
-- Dept. of Radio Electronics, Brno University of Technology, Czech republic
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for top level
------------------------------------------------------------------------
-- popisuje vstupy a vystupy
-- std_logic je logická úroveň: 0 a 1
entity top is
    port (BTN1, BTN0:    in  std_logic;
          LD3, LD2, LD1, LD0: out std_logic);
end entity top;

------------------------------------------------------------------------
-- Architecture declaration for top level
------------------------------------------------------------------------
-- ako sa to chová vnútri
architecture Behavioral of top is
begin
--    LD2 <= '1';
--    LD1 <= '0';
--    LD0 <= BTN1 and BTN0;
		LD2 <= not (BTN0 and not BTN1); --1b 0a
		LD1 <= not ((not BTN0 and not BTN1) or (BTN0 and BTN1));
		LD0 <= not ((BTN0 or BTN1) and (not BTN0 or not BTN1) and (not BTN0 or BTN1));
		LD3 <= not (BTN1 and not BTN0);
end architecture Behavioral;

-- kliknúť na top, Implement Design->Synthesize->PTM Run->Zelena fajfka