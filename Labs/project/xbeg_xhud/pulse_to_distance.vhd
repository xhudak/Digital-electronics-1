library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity pulse_to_distance is
    Port ( clock_i : in  STD_LOGIC; 
			  reset_calculator : in  STD_LOGIC; -- reset from trigger, every 100ms
           echo_i : in  STD_LOGIC; -- ECHO input from ultrasonic module
           distance_o : out  STD_LOGIC_VECTOR (8 downto 0)); -- max distance is 450 cm, so 9b is enough to save the value
end pulse_to_distance;

architecture Behavioral of pulse_to_distance is

component counter is 

Port(clock_i : in STD_LOGIC; 
	  echo_i : in STD_LOGIC;
	  reset_trigger_i : in STD_LOGIC;
	  counter_o : out STD_LOGIC_VECTOR(23 downto 0)
	);
end component;							
signal reset_trigger_i :  STD_LOGIC;
signal calculated_pulse : STD_LOGIC_VECTOR(21 downto 0); 							  
	
begin 
counter_component : counter port map(clock_i, echo_i, reset_trigger_i, calculated_pulse);

pulse_to_distance : process(echo_i, calculated_pulse)
	variable final_pulse : integer;
	variable convertor : STD_LOGIC_VECTOR(23 downto 0);
	
	begin
		if (echo_i = '0') then
			-- convert ns from internal Coolrunner clock to us
			convertor := calculated_pulse * "10011";
			final_pulse := to_integer(unsigned(convertor(23 downto 13)));
			
			if (final_pulse >= 450) then  -- value is bigger then maximmum value
				distance_o <= (others => '1');
			else
				distance_o <= STD_LOGIC_VECTOR(to_unsigned(final_pulse, 9));   -- shift by two and finally we have distance in cm
			end if;
		end if;
end process pulse_to_distance;
end Behavioral;
