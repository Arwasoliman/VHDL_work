library ieee;
use ieee.std_logic_1164;
use ieee.numeric_std.all;

entity alu is 
generic (WIDTH : positive := 8);
port (
    in0 : in std_logic_vector(WIDTH-1 downto 0);
    in1 : in std_logic_vector(WIDTH-1 downto 0);
    sel : in std_logic_vector (1 downto 0);
    neg : out std_logic;
    pos : out std_logic;
    zero : out std_logic;
    output : out std_logic_vector(WIDTH-1 downto 0)
);
end alu;

architecture alu_good1 of alu is 
begin
    process (in0, in1, sel)
        variable temp : signed (WIDTH-1 downto 0);
    begin
        pos  <= '0';
        neg  <= '0';
        zero <= '0';

        case sel is
            when "00" => 
                temp := signed(in0) + signed(in1); 
            when "01" => 
                temp := signed(in0) - signed(in1); 
            when "10" => 
                temp := signed(in0 and in1); 
            when "11" => 
                temp := signed(in0 or in1); 
            when others => null;
        end case;

        if (temp > 0) then
            pos <= '1';
        elsif (temp = 0) then
            zero <= '1';
        else
            neg <= '1';
        end if;

        output <= std_logic_vector(temp);

    end process;
end alu_good1;
