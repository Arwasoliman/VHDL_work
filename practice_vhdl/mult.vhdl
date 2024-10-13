library ieee;
use ieee.std_logic_1164;
use ieee.numeric_std.all;

entity mult is 
generic (
            WIDTH : positive;
            IS_SIGNED : BOOLEAN
        );
port (
        in0 : in std_logic_vector(width-1 downto 0);
        in1 : in std_logic_vector(width-1 downto 0);
        product : out std_logic_vector(2*width-1 downto 0);
);
end mult;

architecture mult1 of mult is 
begin
    process (in0, in1)
    begin
        if (IS_SIGNED) then
            product <= std_logic_vector(signed(in0) * signed (in1));
        else 
            product <= std_logic_vector(unsigned(in0) * unsigned (in1));
        end if;
    end process;

end mult1;


architecture mult2 of mult is
begin
    U_SIGNED : if (IS_SIGNED) generate
                product <= std_logic_vector(signed(in0) * signed (in1));
    end generate;

    U_UNSIGNED : if (not IS_SIGNED) generate
                product <= std_logic_vector(unsigned(in0) * unsigned (in1));
    end generate;

end mult2;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mult is
generic (
    WIDTH : positive;
    IS_SIGNED : BOOLEAN
);
port (

    in0 : in std_logic_vector(width-1 downto 0);
    in1 : in std_logic_vector(width-1 downto 0);
    high : out std_logic_vector(width-1 downto 0);
    low : out std_logic_vector(width-1 downto 0);
);
end mult;

architecture mult3 of mult is
begin
    process (in0, in1)
        variable temp : std_logic_vector (2*WIDTH-1 downto 0);
    begin
        if (IS_SIGNED) then
            temp := std_logic_vector(signed(in0) * signed (in1));
        else 
            temp := std_logic_vector(unsigned(in0) * unsigned (in1));
        end if; 
    end process;

    high <= temp(2*WIDTH-1 downto WIDTH);
    low <= temp(WIDTH-1 downto 0);


end mult3;



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mult_test is
end mult_test;

architecture mult_tb of mult_test is 
    CONSTANT WIDTH : integer := 8;
    CONSTANT IS_SIGNED : boolean := true;
    signal in0 : std_logic_vector (WIDTH-1 downto 0);
    signal in1 : std_logic_vector (WIDTH-1 downto 0);
    signal product : std_logic_vector (2*WIDTH-1 downto 0);
begin
    DUT : entity work.mult(mult1)
            generic map (
                WIDTH => WIDTH,
                IS_SIGNED => IS_SIGNED
            )
            port map(
                    in0 => in0,
                    in1 => in1,
                    product => product
            );
end mult_tb;


