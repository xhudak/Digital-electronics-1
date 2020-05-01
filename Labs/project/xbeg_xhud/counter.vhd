library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter is

    Port ( clock_i : in  STD_LOGIC;
           echo_i : in  STD_LOGIC;
           reset_trigger_i : in  STD_LOGIC;
           counter_o : out  STD_LOGIC_VECTOR (23 downto 0));
end counter;

architecture Behavioral of counter is
signal count : STD_LOGIC_VECTOR(23 downto 0);
begin
process(clock_i)
	begin
	if rising_edge(clock_i) then  -- Rising clock edge
      if reset_trigger_i = '1' then  -- Synchronous reset 
         count <= (others => '0');   -- Clear all bits
		elsif(clock_i = '1' and echo_i = '1') then
			count <= count + 1;         -- adds up after every pulse from internal Coolrunner clock
		end if;
	end if;
end process;

counter_o <= count;

end Behavioral;
