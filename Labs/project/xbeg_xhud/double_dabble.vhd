
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity double_dabble is
    Port ( distance_i : in  STD_LOGIC_VECTOR (8 downto 0);
           m_o : out  STD_LOGIC_VECTOR (3 downto 0);
           dm_o : out  STD_LOGIC_VECTOR (3 downto 0);
           cm_o : out  STD_LOGIC_VECTOR (3 downto 0));
end double_dabble;

architecture Behavioral of double_dabble is

begin
	process(distance_i)
		variable i : integer := 0;
		variable bcd : STD_LOGIC_VECTOR(20 downto 0);
		
		begin
		
		bcd := (others => '0');
		bcd(8 downto 0) := distance_i;
		
		for i in 0 to 8 loop
			bcd(19 downto 0) := bcd(18 downto 0) & '0';
			
			if (i < 8 and bcd(12 downto 9) > "0100") then
				bcd(12 downto 9) := bcd(12 downto 9) + "0011";
			end if;
			
			if (i < 8 and bcd(16 downto 13) > "0100") then
				bcd(16 downto 13) := bcd(16 downto 13) + "0011";
			end if;
		
			if (i < 8 and bcd(20 downto 17) > "0100") then
				bcd(20 downto 17) := bcd(20 downto 17) + "0011";
			end if;
		end loop;
		
		m_o <= bcd(20 downto 17);
		dm_o <= bcd(16 downto 13);
		cm_o <= bcd(12 downto 9);
	end process;
end Behavioral;
