library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ultrasonic_sensor is
    Port ( clock_i : in  STD_LOGIC;
           echo_i : in  STD_LOGIC;
           trigger_o : out  STD_LOGIC;
           meters_o : out  STD_LOGIC_VECTOR (3 downto 0);
           decimeters_o : out  STD_LOGIC_VECTOR (3 downto 0);
           centimeters_o : out  STD_LOGIC_VECTOR (3 downto 0));
end ultrasonic_sensor;

architecture Behavioral of ultrasonic_sensor is
component pulse_to_distance is Port(clock_i : in STD_LOGIC;
                                    reset_calculator : in STD_LOGIC;
												echo_i : in STD_LOGIC;
												distance_o : out STD_LOGIC_VECTOR(8 downto 0)
												);
end component;												

component trigger_pulse_generator is Port(clock_i : in STD_LOGIC;
                                          trigger_o : out STD_LOGIC
														);
end component;

component double_dabble is Port(distance_i : in STD_LOGIC_VECTOR(8 downto 0);
										  m_o : out STD_LOGIC_VECTOR(3 downto 0);
										  dm_o : out STD_LOGIC_VECTOR(3 downto 0);
										  cm_o : out STD_LOGIC_VECTOR(3 downto 0)
										  );										  
end component;

signal s_distance : STD_LOGIC_VECTOR(8 downto 0);
signal s_trigger : STD_LOGIC;
										  
begin
trigger_pulse_generator_component : trigger_pulse_generator port map(clock_i, s_trigger);
pulse_to_distance_component : pulse_to_distance port map(clock_i, s_trigger, echo_i, s_distance);
dd_component : double_dabble port map(s_distance, meters_o, decimeters_o, centimeters_o);

trigger_o <= s_trigger;

end Behavioral;

