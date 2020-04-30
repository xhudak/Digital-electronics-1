library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter is
generic(
    g_NBIT : positive := 10      -- Number of bits
);
    Port ( clock_i : in  STD_LOGIC;
           echo_i : in  STD_LOGIC;
           reset_trigger_i : in  STD_LOGIC;
           counter_o : out  STD_LOGIC_VECTOR (g_NBIT-1 downto 0));
end counter;

architecture Behavioral of counter is
signal count : STD_LOGIC_VECTOR(g_NBIT-1 downto 0);
begin
process(clock_i)
	begin
--	if(reset_trigger_i = '1') then -- zresetuje counter na 1, cekaj
--		count <= (others => '0'); --SET VECTOR TO ZEROS
	if rising_edge(clock_i) then  -- Rising clock edge
      if reset_trigger_i = '0' then  -- Synchronous reset (active low)
         count <= (others => '0');   -- Clear all bits
		--elsif(clock_i'event and clock_i = '1') then -- vyskusat vymenit za rising_edge namiesto 'event
		elsif(echo_i = '1') then
			count <= count + 1;
		end if;
	end if;
end process;

counter_o <= count;

end Behavioral;
