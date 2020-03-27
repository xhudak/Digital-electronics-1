library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

library UNISIM;
use UNISIM.VComponents.all;

entity stopwatch is

			port	(
					--Inputs
					
					clk_i : in std_logic; 		
					srst_n_i : in std_logic;  	
					ce_100Hz_i : in std_logic; 
					cnt_en_i : in std_logic; 	
						
					--Outputs
					
					sec_h_o : out std_logic_vector (3 downto 0);	
					sec_l_o : out std_logic_vector (3 downto 0);	
					hth_h_o : out std_logic_vector (3 downto 0);	
					hth_l_o : out std_logic_vector (3 downto 0)	
				);
				
end entity stopwatch;

architecture Behavioral of stopwatch is
	 
	 signal sec_h : std_logic_vector (3 downto 0) := "0000";
	 signal sec_l : std_logic_vector (3 downto 0) := "0000";
	 signal hth_h : std_logic_vector (3 downto 0) := "0000";
	 signal hth_l : std_logic_vector (3 downto 0) := "0000";

begin
			sec_h_o <= sec_h;
			sec_l_o <= sec_l;
			hth_h_o <= hth_h;
			hth_l_o <= hth_l;

	stopwatch_pocitadlo : process (clk_i) 
		begin 
			if rising_edge (clk_i) then
					if srst_n_i = '0' then 
						sec_h <= "0000";
						sec_l <= "0000";
						hth_h <= "0000";
						hth_l <= "0000";
							
					elsif cnt_en_i = '1' then
							
							if sec_h  = "0101" and sec_l = "1001" and hth_h = "1001" and hth_l = "1001" then -- 59 99 --
								sec_h <= "0000";
								sec_l <= "0000";
								hth_h <= "0000";
								hth_l <= "0000";
										
							elsif sec_l = "1001" and hth_h = "1001" and hth_l = "1001" then -- 09 99 --
								sec_h <= sec_h + 1;
								sec_l <= "0000";
								hth_h <= "0000";
								hth_l <= "0000";
											
							elsif hth_h = "1001" and hth_l = "1001" then  -- 00 99 --
								sec_l <= sec_l + 1;
								hth_h <= "0000";
								hth_l <= "0000";
						
							elsif hth_l = "1001" then  	-- 00 09 --
								hth_h <= hth_h + 1;
								hth_l <= "0000";
					else 
						hth_l <= hth_l +1 ;
						
						end if;
					
					end if;
				
			end if;
									
		end process stopwatch_pocitadlo;
										
end architecture Behavioral;
