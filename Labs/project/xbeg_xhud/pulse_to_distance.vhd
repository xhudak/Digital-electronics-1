library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity pulse_to_distance is
    Port ( clock_i : in  STD_LOGIC; -- clock z FPGA 8MHz
			  reset_calculator_i : in  STD_LOGIC; -- reset z triggra, každy 10us pulz
           echo_i : in  STD_LOGIC; -- vstup z modulu, že zachytil spatnu vlnu           
           distance_o : out  STD_LOGIC_VECTOR (8 downto 0)); -- max je 450 cm, takže 9b je postažujžcich
end pulse_to_distance;

architecture Behavioral of pulse_to_distance is

component counter is 
generic(
    g_NBIT : positive := 10      -- Number of bits
);
Port(clock_i : in STD_LOGIC; 
								  echo_i : in STD_LOGIC;
								  reset_trigger_i : in STD_LOGIC;
								  counter_o : out STD_LOGIC_VECTOR(g_NBIT-1 downto 0)
						   );
end component;							

signal calculated_pulse : STD_LOGIC_VECTOR(23 downto 0); -- 24b, abo nastaviž na 21							  
	
begin -- pozapajam
counter_ptd_component : counter port map(clock_i, echo_i, reset_trigger_i, calculated_pulse);

pulse_to_distance : process(echo_i)
	variable final_pulse : integer;
	variable convertor : STD_LOGIC_VECTOR(23 downto 0);
	
	begin
		if (echo_i = '0') then
			-- delim cislo v us 58 ale my pracujeme na clocku 129 ns, takže potrebujem previest na us 
			-- a potom podelit, deli sa tazko vyuzivam posuvu, ak vynasombim 125 a podelim 8195 tak 
			-- dostavam podobnu hodnotu ako /58
			convertor := calculated_pulse * "10011";
			final_pulse := to_integer(unsigned(convertor(23 downto 13)));
			
			if (final_pulse >= 450) then
				distance_o <= (others => '1'); -- alebo "111111111"
			else
				distance_o <= STD_LOGIC_VECTOR(to_unsigned(final_pulse, 9));
			end if;
		end if;
end process pulse_to_distance;
end Behavioral;
