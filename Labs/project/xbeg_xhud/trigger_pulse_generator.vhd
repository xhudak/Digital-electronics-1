library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity trigger_pulse_generator is
    Port ( clock_i : in  STD_LOGIC;
           trigger_o : out  STD_LOGIC);
end trigger_pulse_generator;

architecture Behavioral of trigger_pulse_generator is -- generuj 10us kadch 50ms
component counter is 
generic(
    g_NBIT : positive := 10      -- Number of bits
);
Port(clock_i : in STD_LOGIC;
                          echo_i : in STD_LOGIC;
								  reset_triger_i : in STD_LOGIC;
								  counter_o : out STD_LOGIC_VECTOR(g_NBIT-1 downto 0)
						   );
end component;
							
signal counter_reset : STD_LOGIC;
signal counter_output : STD_LOGIC_VECTOR(23 downto 0);

begin
	trigger_component : counter port map(clock_i, '1', counter_reset, counter_output); 
	process(clock_i)
		constant clock_250ms : STD_LOGIC_VECTOR(23 downto 0) := "000111101000010010000000";
		constant clock_250_1ms : STD_LOGIC_VECTOR(23 downto 0) := "000111101000011110100000";
		
		begin
			if(counter_output > clock_250ms and counter_output < clock_250_1ms) then
				trigger_o <= '1';
			else
				trigger_o <= '0';
			end if;
			
			
			if (counter_output = clock_250_1ms or counter_output = "XXXXXXXXXXXXXXXXXXXXXXXX") then
				counter_reset <= '0';
			else
				counter_reset <= '1';
			end if;		
end process;
end Behavioral;

