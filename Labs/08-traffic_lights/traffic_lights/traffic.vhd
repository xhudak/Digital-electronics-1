library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity traffic is

	port ( 
		clk_i		: in STD_LOGIC;
		srst_n_i	: in STD_LOGIC;
		lights	: out STD_LOGIC_VECTOR(5 downto 0)
	);
end entity traffic;

architecture traffic of traffic is
		type state_type is (rd_rd0, rd_grn, rd_ylw, rd_rd1, grn_rd, ylw_rd);
		signal state	: state_type;
		
		--signal count: std_logic_vector(3 downto 0);
		--constant SEC5: std_logic_vector(3 downto 0) := "1111";
		--constant SEC1: std_logic_vector(3 downto 0) := "0011";
		
		signal count 	: unsigned(3 downto 0);
		constant SEC5	: unsigned(3 downto 0) := "1111";
		constant SEC1	: unsigned(3 downto 0) := "0011";
	begin
		process (clk_i,srst_n_i)
	begin
	
		if srst_n_i = '1' then
							state <= rd_rd0;
							count <= X"0";
		--elsif clk'event and clk = '1' then	
		elsif rising_edge(clk_i) then
		
			case state is 
				when rd_rd0 =>   						--s0
						if count < SEC5 then		-- waiting 1s
							state <= rd_rd0; 			--	s0
							count <= count + 1;
						else
							state <= rd_grn; 			-- s1
							count <= (others => '0'); -- set to 0
						end if;
						
				when rd_grn =>							--s1
						if count < SEC5 then		-- waiting 5s
							state <= rd_grn; 			--	s1
							count <= count + 1;
						else
							state <= rd_ylw; 			-- s2
							count <= (others => '0'); -- set to 0
						end if; 
						
				when rd_ylw =>							--s2
						if count < SEC1 then		-- waiting 1s
							state <= rd_ylw; 			--	s2
							count <= count + 1;
						else
							state <= rd_rd1; 			-- s3
							count <= (others => '0'); -- set to 0
						end if; 
						
				when rd_rd1 =>							--s3
						if count < SEC1 then		-- waiting 1s
							state <= rd_rd1; 			--	s3
							count <= count + 1;
						else
							state <= grn_rd; 			-- s4
							count <= (others => '0'); -- set to 0
						end if; 
						
				when grn_rd =>							--s4
						if count < SEC5 then		-- waiting 5s
							state <= grn_rd; 			--	s4
							count <= count + 1;
						else
							state <= ylw_rd; 			-- s5
							count <= (others => '0'); -- set to 0
						end if; 
						
				when ylw_rd =>							--s5
					if count < SEC1 then		-- waiting 1s
						state <= ylw_rd; 			--	s5
						count <= count + 1;
					else
						state <= rd_rd0; 			-- s0
						count <= (others => '0'); -- set to 0
					end if; 
					
				when others =>
								state <= rd_rd0;
			end case;
		end if;
end process;

c2: process(state)
	begin
		case state is
				when rd_rd0 => lights <= "001001"; 
				when rd_grn => lights <= "001100"; 
				when rd_ylw => lights <= "001010"; 
				when rd_rd1 => lights <= "001001"; 
				when grn_rd => lights <= "100001"; 
				when ylw_rd => lights <= "010001"; 
				when others => lights <= "001001";
		end case;
end process;

end traffic;