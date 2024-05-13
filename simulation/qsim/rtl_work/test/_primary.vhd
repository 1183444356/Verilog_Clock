library verilog;
use verilog.vl_types.all;
entity test is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        EN              : in     vl_logic;
        decodeout0      : out    vl_logic_vector(6 downto 0);
        decodeout1      : out    vl_logic_vector(6 downto 0);
        decodeout2      : out    vl_logic_vector(6 downto 0);
        decodeout3      : out    vl_logic_vector(6 downto 0);
        decodeout4      : out    vl_logic_vector(6 downto 0);
        decodeout5      : out    vl_logic_vector(6 downto 0)
    );
end test;
