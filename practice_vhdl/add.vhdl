library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add is 
generic (WIDTH : positive);
port (
        in0, in1 : in std_logic_vector(WIDTH-1 downto 0)
        sum : out std_logic_vector(WIDTH-1 downto 0)
        carry_out : out std_logic
     );
end add;

architecture add_bad of add is 
    signal temp : unsigned (WIDTH downto 0);
begin
    process(in0, in1)
    begin
        temp <= resize (unsigned(in0), WIDTH+1) + resize(in1, WIDTH+1   );
        sum <= std_logic_vector(temp(WIDTH-1 down to 0));
        carry_out <= temp(WIDTH);
    end
end add_bad;


architecture add_good1 of add is 
begin
    process(in0, in1)
    variable temp : unsigned (WIDTH downto 0);
    begin
        temp := resize (unsigned(in0), WIDTH+1) + resize(in1, WIDTH+1   );
        sum <= std_logic_vector(temp(WIDTH-1 down to 0));
        carry_out <= temp(WIDTH);
    end
end add_good1;


architecture add_good2 of add is 
    signal temp : unsigned (WIDTH downto 0);
begin

    temp <= resize (unsigned(in0), WIDTH+1) + resize(in1, WIDTH+1   );
    sum <= std_logic_vector(temp(WIDTH-1 down to 0));
    carry_out <= temp(WIDTH);

end add_good2;

------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_test is
end add_test;

architecture add_tb of add_test is 
    constant WIDTH : integer := 8;
    signal in0 : std_logic_vector(WIDTH-1 downto 0);
    signal in1 : std_logic_vector(WIDTH-1 downto 0);
    signal sum : std_logic_vector(WIDTH downto 0);
    signal carry_out : std_logic;
begin 
    DUT : entity work.add(add_good1)
    generic map (WIDTH => WIDTH)
    generic port (
                    in0 => in0,
                    in1 => in1,
                    sum => sum,
                    carry_out => carry_out
    );
end add_tb;
