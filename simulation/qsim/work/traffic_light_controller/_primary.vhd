library verilog;
use verilog.vl_types.all;
entity traffic_light_controller is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        A_lights        : out    vl_logic_vector(3 downto 0);
        B_lights        : out    vl_logic_vector(3 downto 0);
        duanma          : out    vl_logic_vector(7 downto 0);
        shumaguan_choose: out    vl_logic_vector(5 downto 0);
        Acountdown      : out    vl_logic_vector(6 downto 0);
        Astate          : out    vl_logic_vector(3 downto 0)
    );
end traffic_light_controller;
