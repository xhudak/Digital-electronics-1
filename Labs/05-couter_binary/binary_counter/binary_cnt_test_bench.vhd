--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY binary_cnt_test_bench IS
END binary_cnt_test_bench;
 
ARCHITECTURE behavior OF binary_cnt_test_bench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT binary_cnt
    PORT(
			clk_i          : in  std_logic;
			srst_n_i       : in  std_logic;			-- Synchronous reset (active low)
			en_i 				: in  std_logic;
			clock_enable_o : out std_logic
        );
    END COMPONENT;
    
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clk_i_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: binary_cnt PORT MAP (
			clk_i => clk_i,
			srst_n_i => srst_n_i,
			en_i => en_i,
			cnt_o => cnt_o
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		wait for 100 ns;
		srst_n_i <= '1';
	
		for i in 0 to 50 loop
			 en_i <= '1';
			 wait for clk_i_period*1;
			 en_i <= '0';
			 wait for clk_i_period*3;
		end loop;
		
	end process;
END;
