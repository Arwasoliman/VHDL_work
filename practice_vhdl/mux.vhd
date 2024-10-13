library ieee;
use ieee.std_logic_1164.all;

entity mux_2x1 is 
generic (WIDTH : positive);
port (
    input : in std_logic;
    in1 : in std_logic;
    sel : in std_logic;
    output : out std_logic;
);
end mux;

architecture mux_if of mux_2x1 is 
begin
    proces(in0, in1, sel)
    begin
        if (sel = '0') then
            output <= in0;
        else 
            output <= in1;
        end if;
    end process;


end mux_if;

architecture mux_case of mux_2x1 is
begin 
    proces(in0, in1, sel)
    begin
        case (sel) is
            when '0' =>
            output <= in0;
            when '1' =>
            output <= in1;
        end case;
    end process;
end mux_case;

architecture mux_select of mux_2x1 is
begin 

    with sel select
        output <= in0 when '0';
        in1 when others;
    end with_select;
end mux_select;

architecture mux_when of mux_2x1 is
begin 
        output <= in0 when sel = '0' else in1;
        
end mux_when;
