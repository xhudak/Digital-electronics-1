
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

 
ENTITY ultrasonic_sensor_tb IS
END ultrasonic_sensor_tb;
 
ARCHITECTURE behavior OF ultrasonic_sensor_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ultrasonic_sensor
    PORT(
         clock_i : IN  std_logic;
         echo_i : IN  std_logic;
         trigger_o : OUT  std_logic;
         meters_o : OUT  std_logic_vector(3 downto 0);
         decimeters_o : OUT  std_logic_vector(3 downto 0);
         centimeters_o : OUT  std_logic_vector(3 downto 0)
			
        );
    END COMPONENT;
    

   --Inputs
   signal clock_i : std_logic := '0';
   signal echo_i : std_logic := '0';
	signal pulse_s : std_logic_vector(21 downto 0);

 	--Outputs
   signal trigger_o : std_logic;
   signal meters_o : std_logic_vector(3 downto 0);
   signal decimeters_o : std_logic_vector(3 downto 0);
   signal centimeters_o : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clock_i_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ultrasonic_sensor PORT MAP (
          clock_i => clock_i,
          echo_i => echo_i,
          trigger_o => trigger_o,
          meters_o => meters_o,
          decimeters_o => decimeters_o,
          centimeters_o => centimeters_o,
			 distance_0 => "011101011" -- testing value
        );

   -- Clock process definitions
   clock_i_process :process
   begin
		clock_i <= '0';
		wait for clock_i_period/2;
		clock_i <= '1';
		wait for clock_i_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clock_i_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
