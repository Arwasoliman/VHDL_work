-- Entity: memory_map
-- This entity establishes connections with user-defined addresses and
-- internal FPGA components (e.g. registers and blockRAMs).
--
-- Note: Make sure to use the addresses in user_pkg. Also, in your C code,
-- make sure to use the same constants.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.config_pkg.all;
use work.user_pkg.all;

entity memory_map is
    port (
        clk     : in std_logic;
        rst     : in std_logic;
        wr_en   : in std_logic;
        wr_addr : in std_logic_vector(MMAP_ADDR_RANGE);
        wr_data : in std_logic_vector(MMAP_DATA_RANGE);
        rd_en   : in std_logic;
        rd_addr : in std_logic_vector(MMAP_ADDR_RANGE);
        rd_data : out std_logic_vector(MMAP_DATA_RANGE);

        -- application-specific I/O
        go     : out std_logic;
        done   : in std_logic;
        n      : out std_logic_vector(15 downto 0);
        output : in std_logic
    );
end memory_map;

architecture BHV of memory_map is
	signal n_r : std_logic_vector (15 downto 0);
	signal go_r : std_logic;
	signal rd_data_r : std_logic_vector (MMAP_DATA_RANGE);
begin
	process (clk, rst)
		begin 
		if (rst = '1') then
			go_r <= '0';
			n_r <= (others => '0');
		elsif (rising_edge(clk)) then
			if (wr_en = '1') then
				case (wr_addr) is 
					when  std_logic_vector(to_unsigned(C_GO_ADDR, 2)) => 
						go_r <= wr_data(0);
					when  std_logic_vector(to_unsigned(C_N_ADDR, 2)) =>
						n_r <= wr_data(15 downto 0);
					when  std_logic_vector(to_unsigned(C_DONE_ADDR, 2)) =>
						go_r <= done;
					when  std_logic_vector(to_unsigned(C_OUTPUT_ADDR, 2)) =>
						go_r <= output;
					when others => null;
				end case;
			end if;
		end if;
	end process;
	
	process (clk,rst)
		begin 
		if (rst = '1') then
			rd_data_r <= (others => '0');
		elsif (rising_edge(clk)) then
			if (rd_en = '1') then
				case (rd_addr) is 
					when  std_logic_vector(to_unsigned(C_GO_ADDR, 2)) => 
						rd_data_r(0) <= go_r;
					when std_logic_vector(to_unsigned(C_N_ADDR, 2)) => 
						rd_data_r <= std_logic_vector(resize(unsigned(n_r), 32));
					when std_logic_vector(to_unsigned(C_DONE_ADDR, 2)) => 
						rd_data_r(0) <= done;
					when std_logic_vector(to_unsigned(C_OUTPUT_ADDR, 2)) => 
						rd_data_r(0) <= output;
					when others =>
						rd_data_r <= (others => '0');
				end case;
			end if;
		end if;
	end process;

	rd_data <= rd_data_r;
	go <= go_r;
	n <= n_r;
	
end BHV;
