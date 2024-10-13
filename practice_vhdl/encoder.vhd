library ieee;
use ieee.std_logic_1164;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity encoder is 
generic (WIDTH : positive := 4);
port(
    input : in std_logic_vector (IWDTH-1 downto 0);
    valid : out std_logic;
    output : out std_logic_vector(integer(ceil(log2(real(WIDTH))))-1 downto 0)
);
end encoder;

architecture encoder1 of encoder is 
    constant OUTPUT_WIDTH : integer := integer(ceil(log2(real(WIDTH))));
begin
    proces(input)
    begin
        valid  <= '0';
        output <= (others => '0');
        
        for i in 0 to WIDTH-1 loop
            if (inputs(i) = '1') then
                output <= std_logic_vector(to_unsigned(i, OUTPUT_WIDTH));
                valid  <= '1';
            end if;
        end loop;
    end process;
end encoder1;
