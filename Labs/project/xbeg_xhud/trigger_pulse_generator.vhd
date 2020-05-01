library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity trigger_pulse_generator is
    Port ( clock_i : in  STD_LOGIC;
           trigger_o : out  STD_LOGIC);
end trigger_pulse_generator;

architecture Behavioral of trigger_pulse_generator is -- THIS ARCHITECTURE GENERATES EVERY 100ms 10us pulse
component counter is 

Port(clock_i : in STD_LOGIC;
                          echo_i : in STD_LOGIC;
								  reset_trigger_i : in STD_LOGIC;
								  counter_o : out STD_LOGIC_VECTOR(23 downto 0)
						   );
end component;
							
signal counter_reset : STD_LOGIC;
signal counter_output : STD_LOGIC_VECTOR(23 downto 0);

begin
	trigger_component : counter port map(clock_i, '1', counter_reset, counter_output); 
	process(clock_i)
		constant high_pulse_start : STD_LOGIC_VECTOR(23 downto 0) := "000011000011010100000000"; -- 100ms	                                                                              
		constant high_pulse_stop  : STD_LOGIC_VECTOR(23 downto 0) := "000011000011010101010000"; -- 100ms + 10us
		
		begin
			if(counter_output > high_pulse_start and counter_output < high_pulse_stop) then -- 000...100ms...0011...10us..1100...100ms..00
				trigger_o <= '1';
			else
				trigger_o <= '0';
			end if;
			
			
			if (counter_output = high_pulse_stop or counter_output = "XXXXXXXXXXXXXXXXXXXXXXXX") then  -- reset counter after pulse
				counter_reset <= '1';
			else
				counter_reset <= '0';
			end if;		
end process;
end Behavioral;

